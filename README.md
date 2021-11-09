# [wip] Argovis Deployment

This repo will contain notes and resource on deploying Argovis to production.

## Target: CU OKD

 - See argovis.yaml for specification of all objects
 - Assumes a pre-existing PVC called `mongoback` which contains the current state of the mongo database
 - Also necessitates creating external routes for the API
 - TBD: frontend.
