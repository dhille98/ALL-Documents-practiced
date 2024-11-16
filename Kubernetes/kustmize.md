Kubernetes Kustomize
---------------

**Q. What is different between deployed keys and ssh-keys in github actions**

* This is a tool for k8s configuration management that allows us to customize k8s yaml configurationswithout modifying the original files
  
* while excuteing/createing/modifying check twice our manifacst file must haveing case-senstive words 

we are using kustomize and Helm 

Helm charts both but very complex size application and deploy secrets and config-maps we are using helm templates 

very small size application using kustomized this supporting to patch 

**NOTE:**
	Moreover, Helm templates enable dynamic generation of manifests based on **user-provided values**. In contrast, 

Kustomize follows a declarative approach to configuration management. It uses a base configuration and applies **overlay or patches** to customize the manifests for different environments or use cases 

[referhere][https://github.com/kubernetes-sigs/kustomize/releases] install kustomized packages 

```
    wget /usr/local/bin/https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv5.4.3/kustomize_v5.4.3_linux_amd64.tar.gz 
```
Command is 
```
    kustomize build <path/kustmize.yaml>
	kubectl apply -f -k <path/.>
```

* kustomized using we deployed applications multipool different namespace 


**Note:** we configure wrong image name change the image name using kustmioze file 

**we are using kustomize we can add , change, deleted and modified**

### step-1
--------
* frist we deployment on sample ymal file like 
* our main yaml file base folder (in base folder deployment.yml service.ymal)
* 
```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
namespace: megastar
namePrefix: dev-
nameSuffix: -env

resources:
- ../../base # path of base directory 
replicas:
- count: 2
  name: nginx001

images:
- newName: sreeharshav/testcontainer
  newTag: v1
  name: sreeharshav/rollingupdate
```
### step-2 

* add the evn files useing patching 

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
namespace: megastar
namePrefix: dev-
nameSuffix: -env

resources:
- ../../base


patches:
 - target:
    group: apps
    version: v1
    kind: Deployment
    name: dev-nginx001-env
   path: patch-limits.yaml

replicas:
- count: 2
  name: nginx001

images:
- newName: sreeharshav/testcontainer
  newTag: v1
  name: sreeharshav/rollingupdate
```
* pod login checking env
* deploy the multipul namespace 
```
  kubectl get po -n <name-space>
```
```
  ku exec -it <pod_name> -- bash
  ku get po <pod-name> -o yaml # checking what ever configurations the yaml see the
```

* patch-limites.yaml
```yaml
- op: add #action
  path: "/spec/template/spec/nodeSelector" #resouirce we want to change
  value:             #value we want to use for patching
    kubernetes.io/hostname: i-06ec3eb2c02f49424

```

### Step-3

* change and modify the environment useing patch
  
[referhere][https://github.com/dhille98/k8s29b/tree/main/kustomize/overlays/development] check the git hub links  


```
 # delete the kustomize
  cd /tmp/k8sb29-kustomize/k8sb29-kustomize-master/overlays/production
 ku delete -k .
```