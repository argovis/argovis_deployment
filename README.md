# [wip] Argovis Deployment

This repo will contain notes and resource on deploying Argovis to production.

## Release Process

Argovis consists of five microservices, wihch all have their own release process (except for mongo, for which we use the off-the-shelf upstream). See the latest releases of each in the following repos:

 - API
   - GitHub: https://github.com/argovis/argovis_api
   - Docker Hub: https://hub.docker.com/repository/docker/argovis/api
 - Redis
   - GitHub: https://github.com/argovis/argovis_redis
   - Docker Hub: https://hub.docker.com/repository/docker/argovis/redis
 - Angular:
   - GitHub: https://github.com/argovis/argovisNg
   - Docker Hub: https://hub.docker.com/repository/docker/argovis/ng
 - Datapages:
   - GitHub: https://github.com/argovis/datapages
   - Docker Hub: https://hub.docker.com/repository/docker/argovis/datapages

Also, this chart assumes there exists the following objects in the cluster: 

 - a PVC called `mongoback0`, which contains everything from `/data/db` in the mongo container.
 - a secret called `apitoken`, which contains a key `token` that will be used as an API token by the frontend. This token must be present and active in mongodb's user table.
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


