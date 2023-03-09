# [wip] Argovis Deployment

This repo will contain notes and resource on deploying Argovis to production.

## Release Process

Argovis consists of four microservices, wihch all have their own release process (except for mongo, for which we use the off-the-shelf upstream). See the latest releases of each in the following repos:

 - API
   - GitHub: https://github.com/argovis/argovis_api
   - Docker Hub: https://hub.docker.com/repository/docker/argovis/api
 - Redis
   - GitHub: https://github.com/argovis/argovis_redis
   - Docker Hub: https://hub.docker.com/repository/docker/argovis/redis
 - React:
   - GitHub: https://github.com/argovis/react
   - Docker Hub: https://hub.docker.com/repository/docker/argovis/react

### Deploy to Kube

Kubernetes is Argovis' preferred deployment target, when a managed cluster is available. To this end, we provide a Helm chart in this repo. This chart assumes there exists the following objects in the cluster: 

 - a PVC which contains everything from `/data/db` in the mongo container.
 - a secret called `sendgrid-api-token`, which contains a key `SENDGRID_API_TOKEN`, with a value that will be used against the Sendgrid API.
 - an API token active in mongodb's user table with the kv `"key": "guest"`

When any of the underlying base images change, or anything about the orchestration structure changes, follow the procedures below to increment the release on the OKD cluster:

 - In `argovis/values.yaml`, update any image tags as necessary.
 - In `argovis/Chart.yaml`, increment the `version` and `appVersion` values. Keep these the same, and use semver.
 - Log into the OKD cluster from the command line by doing `oc login`, and following the link it provides.
 - Update the application: `helm upgrade argovis ./argovis`
 - Make a new release in this repo tagged the same as the chart version.

Some helpful things to know about application management that you may occassionally need:

 - Delete / recreate application: `helm uninstall argovis` / `helm install argovis ./argovis`
 - Undo last update: `helm rollback argovis`

### Deploy to Swarm

In the event that Argovis must be deployed to an environment where a managed Kubernetes service isn't available, we also provide a script to deploy services and containers to Docker Swarm. Read `swarm-deploy.sh` and make sure image tags and environment variables are up to date, and deploy to a host with sufficient resources and Docker installed with `bash swarm-deploy.sh`.
