## project 

**hotels + restarent**

env dev==> devolopment
    QA==> testing env
UAT/STG/PRE-PROD --> ENV

DEV --> 4 NODE
PROD --> 10 NODE

CI 
    - checkout stage
    - build the code
    - sonar scan
    - build the docker images
    - push the docker images
    - x ray images


CD 
    - deploy
    - service
    - ingress
    - cronjob
    - configmaps
    - secrates

deploying 
  - helm deployment 
        - values.yaml file on diiffrent env
        - namespace, application name, image name, version
        - using Gitops 
              - argocd  -- UI (multipull clusters)
              - FLUXCD -- Agent 


[ReferHere](https://kustomize.io/) this kustomization documnetations 