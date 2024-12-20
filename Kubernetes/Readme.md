### kubernetes 


**kubernetes clusters:**
    - Kubeadm
    - kops
    - k3s
    - Rancher
    - minkube
    - EKS
    - AKS

## kubernetes componetes 
**Master Node**
    - kube apiserver
    - schduler 
    - etcd
    - controller manager 
**Worker Node**
    - kubelet
    - containerd
    - kubeproxy

### POD
* pod types
  * main / application pod --> Web server, backend API
  * sidecar container ---> Logging, monitoring, proxies, security
* Empty dir: container is using `emptydir` if container resart or deleted data will be lost 
* pods run one or more container 
* single point of failer in application run on one pod 
* schduler can schdule the pod on sutable node 

* create pod or any thing is using on `imperative` is commandline `declartive` using on `yml` file 
```bash
    # create pod 
    kubectl run pod-1 --image=nginx:latest

    # dry run command is 
    kubectl run pod-2 --image=nginx:latest --dry-run -o yaml

```

## what is diffrent between `kubectl create` and `kubectl apply`

**kubectl create:** is a imperative commnds 
**kubectl apply** is using on manifast / yaml file

--> kubectl apply command is this used for declarative command is resources is already exit/ unchanged 
--> kubectl create command is if the resource is created already exist kubctl create will error 

* some commands create work loads
```sh
    echo 'yaml file' | kubectl create -f -
    # login the pod 
    kubectl exec --it <pod> --bash
    # pod datails 
    kubectl get pod -o wide
    kubectl describe pod 
```

* node maintances time 
```sh
    # running pods are not affictive but schduler will not schdule pod on that nod
    kubectl cordon <node-name>
    # node empty
    kubectl drain <node-name>
    kubectl uncordon <node>
```

* pod acccess on outside cluster 
```sh
    kubectl port forword pod pod1 8080:80
    kubectl port forword pod pod1 --address 0.0.0.0 8080:80
```
* check that system wich ports running `netstat -nltp`
* check that ip address on `ifconfig.io` 
* kubernetes pods run multipule container run same port that pod not run container 
* check the pod logs `kubectl logs pod -f ` or `kubectl logs pod` 

* `ENTRYPOINT` in Docker file is equle to `command` in k8s 
* `CMD` in Dockerfile is equle to `args` in k8s 
* to run multiple containers expose the outside `kubectl port port forword pod1 --address 0.0.0.0 8080:80 9000:8080`

```bash
tmux 
  -> crtl + b
    --> shift + "
```

