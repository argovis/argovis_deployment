# [wip] Argovis Deployment

This repo will contain notes and resource on deploying Argovis to production.

## Target: CU OKD

 - Lifecycle:
   - Log into cluster: `oc login`, follow instructions.
   - Birth: `helm install argovis ./argovis`
   - Growth: `helm upgrade argovis ./argovis`
   - Death: `helm uninstall argovis` 

 - Assumes a pre-existing PVC called `mongoback` which contains the current state of the mongo database
 - TBD: frontend.
