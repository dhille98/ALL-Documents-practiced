## Advance Scheduling

**types of schdules**
1. Node selctors
2. Node affinity 
3. Taint and Tolarations 
4. Pod Affinity & Pod anti-Affinity

### Node Selectors 

* Node will be select the pod on based upon labels

* check the default labels on node 
```sh
    kubectl describe node <node-name> 
```
* set the labels on node
```sh
    kubectl label node <node-name> key=value
```
* remove the labes on node
```sh
    kubectl label node <node-name> key-
```

### practice on Node Selctors 
**deploye the application** 
```sh
    kubectl create deployment app1 --image nginx --replicas 4 -o yaml
    kubectl create deployment app1 --image nginx --replicas 4
```
**Note**: in the deployment yaml file need mensioned on node selectors as like below 
```yaml
    ---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: myapp02
  name: myapp02
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp02
  template:
    metadata:
      labels:
        app: myapp02
    spec:
      containers:
      - image: sreeharshav/rollingupdate:v1
        name: rollingupdate
      nodeSelector:
        high-perf-cpu: "yes"
```
*check the varitations of the pods status pass the below commands*
```sh
    ku get po -o wide 

    ku cordon <node-name>
    ku scale deployment myapp01 --replicas 6
    ku describe po <pod-name>
    ku uncordan <node-name> 
    ku drain <node-name> --ignore-deamonsets
```
**after drain the node kubernetes schduler apply the taint on node**
```sh
    ku describe no <node-name> | grep -i taint

    ku uncordan <node-name>

    ku describe no <node-name> | grep -i taint
```

### Node Affinity 
-----------------
* taints and tolerations are useful when you need to reserve nodes.
* node affinity is better when you want to target certain node characteristics like hardware specs.

**required**: pod will seclete the particalar node if you not schdule the pod it will be pending state.

**preferred**: pod will seclete the particalar node if you not schdule the pod it will be schdule the on another pod

**pratice on nodeaffinty** 
-------------------------
```sh
    ku label node <node-1> az="us-east-1a"
    ku label node <node-2> az="us-east-1b"
    ku label node <3> az="us-east-1c"
    ku label node <node-1> perf="high"
    ku label node <node-2> perf="medium"
    ku label node <3> perf="low"
``` 
**Note**: in the deployment yaml file need mensioned on below 
```yaml
affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            # The below expression will only deploy to server which satifies
            # az and perf labels which is us-east-1a server.
            - matchExpressions:
              - key: az
                operator: In
                values:
                - us-east-1a
                - us-east-1b
              - key: perf
                operator: In
                values:
                - high
                - 
```
*excute the above yaml file pass the below command. check the pod run which node*
```sh
    kubectl get po -o wide
```

```yaml
affinity:
        nodeAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
          - weight: 75
            preference:
              matchExpressions:
              - key: az
                operator: In
                values:
                - us-east-1a
          - weight: 25
            preference:
              matchExpressions:
              - key: perf
                operator: In
                values:
                - medium
```
```sh
    kubectl get pod -o wide | grep -i <node-1> | wc -l
    kubectl get pod -o wide | grep -i -v <node-1> | wc -l
    ku cordon <>
    ku rollout restart deployment <>

# disable the labels node use these commands 

    kubectl label node <1> az-
    kubectl label node <2> az-
    kubectl label node <3> az-
    kubectl label node <1> perf-
    kubectl label node <2> perf-
    kubectl label node <3> perf-
```
### Taints and Tolerations 
---------------------------

* you want tain the node use this commands 
* 
```sh
    kubectl taint node node-name perf=high:NoSchedule 
    kubectl taint node node-name perf=medium:NoExecute
    ku taint node node-1 perf=high:NoSchedule
    kubectl taint node-2 perf=medium:NoExecute
    kubectl taint node node-name perf=high:NoExecute
    kubectl taint node node-name perf=medium:NoExecute
```
### Note: 
**NoSchedule**: this means after tainted the node run any pods not removed but any pods willnot 
   schdule. this means after tainted the node run any pods 


**NoExecute**: this means after tainted the node run any pods *Evicted pods* Schdule on shoutable node 
    this means after tainted the node run any pods

```yaml
tolerations:
         - key: "perf"
           operator: "Equal"
           value: "high"
           effect: "NoSchedule"
```


```sh
    ku label node node-1 az-
    ku label node node-2 az-
    ku label node node-1 perf-
    ku label node node-2 perf-
    # if you want to untainted node 
    ku taint node <node-name> key-
    # ex:
    ku taint no node-1 perf-
```
### pod affinity 
------------

**pod Affinity** - making sure Pods are grouped together in the same host

**pod Anti Affinity** - Making sure no two pods reside on the same host

**Note:**

*Image you have a big cluster with 20 nodes and you want to make sure where*
*the application pod resides and we need to make sure redis/db pods must* 
*run along with the app pods, we can use POD affinity between Web, App, DB Pods.*

```yaml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: redis
  name: redis
spec:
  replicas: 2
  selector:
    matchLabels:
      app: redis
  template:
    metadata:
      labels:
        app: redis
    spec:
      affinity:
        podAntiAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchExpressions:
              - key: app
                operator: In
                values:
                - redis
            topologyKey: "topology.kubernetes.io/zone"
      containers:
      - image: redis:latest
        name: redis
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: web
  name: web
spec:
  replicas: 2
  selector:
    matchLabels:
      app: web
  template:
    metadata:
      labels:
        app: web
        perf: high
    spec:
      affinity:
        podAntiAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchExpressions:
              - key: app
                operator: In
                values:
                - web
            topologyKey: "topology.kubernetes.io/zone"
        podAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchExpressions:
              - key: app
                operator: In
                values:
                - redis
            topologyKey: "topology.kubernetes.io/zone"
      containers:
      - image: nginx:latest
        name: nginx

---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: app
  name: app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: app
  template:
    metadata:
      labels:
        app: app
        perf: high
    spec:
      affinity:
        podAntiAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchExpressions:
              - key: app
                operator: In
                values:
                - app
            topologyKey: "topology.kubernetes.io/zone"
        podAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchExpressions:
              - key: app
                operator: In
                values:
                - redis
            topologyKey: "topology.kubernetes.io/zone"
      containers:
      - image: nginx:latest
        name: nginx
    ```

```sh
# get the labes on nodes
    kubectl get nodes --show-labels
```
* pod affinty and anti affinty means : same label pod run node-1 this pod will be also run same pod means 
  
  pod affintiy 

  this pod run differnt nodes that is called anti-affinty 