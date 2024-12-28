## Deployment:
===============================
 -  **k8s Deployments & Daemonsets & Statefulsets**
 - pods can be Maintained in above 3 methods
 - A collection of Pods which are running your applications and maned by Replicaset.
 - When compared to RS, we can do automate the pod through Deployements for Automatic & RS for manual
 - INQ: How many ways we rebooted or restarted the pods ( whenever we do the any chnages in deployemts it wou;d be Restarted )
      1 Making changes like image, env Varibales, secrets
      2 ku rollout Restart
      3 Delete the pods and RS will creat a new :
        Multiple ways we can do the different ways:
 - based upon the Starategy its works how and why it is restarted in the in Envirionments; whenever the Pods restred Pods      name automaticaaly changed bcz we are not using statefulsets
 - whenever the Pods restred Pods name automaticaaly and RS As well Restared and Mained the earlier version
 - Deployements Can be Updated multiple Ways: Set and Patch Methods: Explained below in inbrief
 - FORkBomb
   - :(){ :|:& };:

# Frequent Commands Used for Lab Pratcise:
================================
```sh
  ku create deployment app1 --image arifullalab01/fastapi:v1 --replicas 3 --dry-run -o yaml  --> DryRun Checks
  ku describe no <i-09b895a63fcdb85b5>   --> taint concepts
  ku edit deployments.apps app1
  ku rollout history deployment app1
  ku rollout undo deployment app1 4
  ku rollout history deployment app1 --to-version=1
  pots
  ku scale deployment app1 -- replicas 6
  kubectl set env deployment/app1 APP_Version="2.0"
  ku rollout status deployment app1
  ku rollout pause deployment app1
  ku port-forward pod/app1-6ddfbdfdd7-6c6sw  --address 0.0.0.0 8000:80
  ku rollout resume deployment app1 8000
  ku rollout resume deployment app1
  ku pacth deployments.apps app1 --patch-file /tmp/patch.yaml
```

## Cluster-setup for Lab Pratcise

nano 1-master-3-bode.sh

#!/bin/bash
kops create cluster --name=k8sb29.xyz --state=s3://arifk8sb29.xyz \
--zones=us-east-1a,us-east-1b,us-east-1c --node-count=3 --control-plane-count=1 \
--node-size=t3.medium --control-plane-size=t3.medium --control-plane-zones=us-east-1a \
--control-plane-volume-size 10 --node-volume-size 10 --ssh-public-key ~/.ssh/id_rsa.pub \
--dns-zone=k8sb29.xyz  --networking calico --yes

cat 1-master-3-bode.sh

time kops create cluster --name=k8sb29.xyz --state=s3://arifk8sb29.xyz \
--zones=us-east-1a,us-east-1b,us-east-1c --node-count=3 --control-plane-count=1 \
--node-size=t3.medium --control-plane-size=t3.medium --control-plane-zones=us-east-1a \
--control-plane-volume-size 10 --node-volume-size 10 --ssh-public-key ~/.ssh/id_rsa.pub \
--dns-zone=k8sb29.xyz  --networking calico --yes

# Once the  Cluster is up, then we need to check the below heirarchy

====================

###### Lab Practise And concepts Starts:

## Deployements Explanation:
>>>>>>>>>
```yaml
echo 'apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: app1
  name: app1
spec:
  replicas: 3
  selector:
    matchLabels:
      app: app1
  template:
    metadata:
      labels:
        app: app1
    spec:
      containers:
      - image: sreeharshav/fastapi:v1
        name: fastapi' | ku apply -f -
>>>>>>>>>
``` 

ku describe pods
pots
nodes
pots -o wide 
ku describe no <i-09b895a63fcdb85b5>   --> taint concepts
```
ku edit deployments.apps app1
```
<change the images name>            --> whenever we do the any changes in deployemts it would be Restarted

sreeharshav/testcontainer:v1

pots
```
ku edit deployments.apps app1
```
<edit env varibles>                    --> whenever we do the any changes in deployemts it would be Restarted

pots
```
ku edit deployments.apps app1         
```
 --> whenever we do the any changes in deployemts it would be Restarted <Change Environment varibles>
==

## Deployements Rollout Concepts Explained:

based upon the Starategy its works how and why it is restarted in the in Envirionments;
whenever the Pods restred Pods name automaticaaly changed bcz we are not using statefulsets
```
ku rollout restart deployment app1
watch -n 1 | ku get po

ku get rs               ---> whenever the Pods restred Pods name automaticaaly and RS As well Restared and Mained the earliers 

ku rollout history deployment app1
ku rollout undo deployment app1 4
ku rollout history deployment app1 --to-version=1

kubectl rollout undo deployment/app1 --to-revision=1

pots
ku scale deployment app1 -- replicas 6
```
==
## Deployements Concepts Max Surge and Minunavailable Concepts Explained in detailed way:
```yaml
echo 'apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: app1
  name: app1
spec:
  minReadySeconds: 20
  strategy:
   rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 0
  replicas: 3
  selector:
    matchLabels:
      app: app1
  template:
    metadata:
      labels:
        app: app1
    spec:
      containers:
      - image: sreeharshav/fastapi:v1
        name: fastapi' | ku apply -f -

``` 
## Deployements Can be Updated multiple Ways: Set and Patch Methods

# Set Method
 - Update deployment 'registry' with a new environment variable :
```
kubectl set env deployment/app1 APP_Version="1.0"
ku rollout status deployment app1
ku rollout pause deployment app1

ku port-forward pod/app1-6ddfbdfdd7-6c6sw  --address 0.0.0.0 8000:80
ku rollout resume deployment app1 8000
ku rollout resume deployment app1
```
# Patch Method : ku patch deployments.apps app1 --patch-file /tmp/patch.yaml

===
```yaml
spec:
  template:
    spec:
      containers:
      - image: sreeharshav/fastapi:v1
        name: fastapi
        env:
        - name: POWERSTAR
          value: PAWANKALYAN
        - name: Arifulla
          value: Shaik


spec:
  template:
    spec:
      containers:
      - image: sreeharshav/fastapi:v2
        name: fastapi
         env:
        - name: POWERSTAR
          value: PAWANKALYAN
        - name: Arifulla
          value: Shaik


spec:
  minReadySeconds: 20
  strategy:
   rollingUpdate:
      maxSurge: 50%
      maxUnavailable: 0
```
===

# Patch Methods:
==
```

ku pacth deployments.apps app1 --patch-file /tmp/patch.yaml

ku port-forward pod/<podname> --address 

ku describe pod/<PODname> | grep -I image


ku rollout pause deployment app1

ku port-forward pod/app1-6ddfbdfdd7-6c6sw  --address 0.0.0.0 8000:80

ku logs <Podname> -f

```
Resources Must be Given to the Pods

sAmple Test Done:

FORK Bomb need to apply 


## ForkBomb:
===
:(){ :|:& };:





