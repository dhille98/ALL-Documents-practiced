# HELM Package management 

* Helm is a package manager for k8s that helps you manage k8s applications through helm charts.
* This simplifies deployment, versioning and management of applications
* Installation [Refer Here](https://helm.sh/docs/intro/install/)
* Lots of applications can be deployed with helm charts
*  [Refer Here](https://artifacthub.io/) for helm chart artifact hub which islarge collection of openly available helm chartsLets 
*  we can deploy for large applications easly deploying using helm chats 
## ECOM applications 
    - Frontend    --> Deployment, Service, Ingress
    - BackEnd     --> Deployment, service
    - Message     --> Deployment, service
    - DataBase    --> StateFullset, service, secrates, configMaps, PV, PVC
    - Casching    --> StateFullset, service,

*  create a new helm chart

```
    helm create demoapp
```
* above create helm charts templates lets understands for folder 
  
[referHere](https://github.com/dhille98/k8s29b/tree/main/helm/demoapp) for sample helm templates 


* create one nginx template deployed by useing helm 

Helm lint command is checking the values and syntax

```
    helm lint ./mynginx/ -f ./mynginx/values.yaml -f ./mynginx/values2.yml
```

```
     helm lint ./mynginx/ -f ./mynginx/values.yaml -f ./mynginx/values2.yml
        ==> Linting ./mynginx/
    [INFO] Chart.yaml: icon is recommended

    1 chart(s) linted, 0 chart(s) failed
```
### helm templates 

* this commands checking preview mod for helm templates all is correct or not (for rendering )
```
    helm template demoapp ./mynginx/ -f ./mynginx/values.yaml -f ./mynginx/values2.yml
```
* helm  dry run 
```
    helm install --dry-run mynginx/ --generate-name  -f ./mynginx/values.yaml -f ./mynginx/values2.yml
```
* abvoe command excuteing this will commaing 
* we will be change chat name & namespace 
```yaml
NAME: mynginx-1723368945
LAST DEPLOYED: Sun Aug 11 09:35:45 2024
NAMESPACE: default
STATUS: pending-install
REVISION: 1
TEST SUITE: None
HOOKS:
MANIFEST:
```
* we can change default values use this commands 
```
	helm install demoapp mynginx/  --set repicasCount=3 -n demoapp-ns --create-namespace
    helm install --dry-run demoapp mynginx/  --set repicasCount=3 -n demoapp-ns --create-namespace -f ./mynginx/values.yaml -f ./mynginx/values2.yml
```
* change the chart name and namespace 
```yaml
NAME: demoapp
LAST DEPLOYED: Sun Aug 11 09:41:15 2024
NAMESPACE: demoapp-ns
STATUS: pending-install
REVISION: 1
TEST SUITE: None
HOOKS:
MANIFEST:
```
## Q. how to pass multipole files in helm deploy / we can pass multipole values in heml deploy

* helm install nginx deployment 
* [referHere](https://github.com/dhille98/k8s29b/tree/main/helm/mynginx-code-for-testing-k8sb28) by the mainfact files 
```
     helm install demoapp mynginx/ --set repicasCount=4 -n demoapp-ns --create-namespace -f ./mynginx/values.yaml -f ./mynginx/values2.yml
```
* after deploying the helm charts 

```
    heml list -n demoapp-ns
```
|         |                |             |                                           |          |                     |
|-------- |--------------- |------------ | ----------------------------------------- | -------- |-------------------- |
|   NAME  |  NAMESPACE     |  REVISION   |    UPDATED                                |  STATUS  |       CHART         | APP VERSION
|demoapp  | demoapp-ns     | 1           |    2024-08-11 09:44:47.224411313 +0000 UTC| deployed |       mynginx-0.1.0 | 1.16.0

### helm package upgrade 
```
	helm upgrade demoapp mynginx/ --set replicaCount=6 --set service.type=NodePort -n demoapp-ns -f ./mynginx/values.yaml -f ./mynginx/values2.yml
```
* any values you can change/upgrade  dynamically use flog `--set` and name of the chart list name

* change image name 
  
```
    helm upgrade demoapp mynginx/ --set replicaCount=8 --set service.type=NodePort --set image.repository=sreeharshav/fastapi --set image.tag=v2 -n demoapp-ns --create-namespace -f ./mynginx/values.yaml -f ./mynginx/values2.yml
```

* checking the helm history 
```
    helm history demoapp
```
* write a shell scripting files 
```sh
while true
do
curl -sL http://0.0.0.0:32394/docs | grep -i container ID
sleep 1s
done 
```
* rollout the previous version
```
    helm rollback demoapp -n demoapp
    helm rollback demoapp 5 -n demoapp # rollback to particalar version 
``` 
* helm delete the all configurations files 
```
    helm uninstall demoapp  -n demoapp-ns
```
* helm packages are create a own helm abvoe steps 

* you can use and already exstings packages download remote url 

### any repository add remote by using
``` 
	helm repo ls
	helm repo add <url>
	helm repo update 
	helm search repo mongo 

	helm fetch 
```
* for exapmle take one statefull set *bitnami helm charts*
```
    helm repo ls
    helm repo add bitnami https://charts.bitnami.com/bitnami
    helm repo update 
    helm search repo mongo
    helm fetch bitnami/mongodb
    helm repo remove bitnami 
```
* after download remote repo using helm we can modifying our project scenario like.
```
    helm install mongodb bitnami/mongodb --set architecture=replicaset --set replicaCount=3 --set persistence.size=2Gi --set useStatefulSet=true --set auth.rootUser=adminsree --set auth.rootPassword="India@123456@" -n mongo --create-namespace
```
**Note:**  in kubernetes any errors frist checking `describe` and checking `logs`