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

Also, this chart assumes there exists a PVC called `mongoback`, which contains everything from `/data/db` in the mongo container.

When any of the underlying base images change, or anything about the orchestration structure changes, follow the procedures below to increment the release on the OKD cluster:

 - In `argovis/values.yaml`, update any image tags as necessary.
 - In `argovis/Chart.yaml`, increment the `version` and `appVersion` values. Keep these the same, and use semver.
 - Log into the OKD cluster from the command line by doing `oc login`, and following the link it provides.
 - Update the application: `helm upgrade argovis ./argovis`

Some helpful things to know about application management that you may occassionally need:

 - Delete / recreate application: `helm uninstall argovis` / `helm install argovis ./argovis`
 - Undo last update: `helm rollback argovis`


