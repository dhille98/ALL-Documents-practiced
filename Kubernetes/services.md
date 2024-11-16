## services:
    any deployment, deamonsets and statefulsets by default we are not accessbul
     inside or outside k8s cluster you can use services access the applications 
    ([referhere](https://kubernetes.io/docs/concepts/services-networking/service/))

* types of services
    # Clusterip: 
        reachable from inside the cluster only. used for internal like monataring 
        or logging or app backend like database
    # NodePort:
        expose application externally on node IP address using ephermal 
        ** ports: 30000-32767
        -> usefull for testing the application dont qulify for productions.

    # Load Blancer: 
        deploy loadblaner to connect to you backend pods

    # Headless-service:
        used for by statefull set
    # External Name: 
        exposing external website or IP ranges internally to cluster objects

## lab:
* createing deployment 
```
    ku create deployment <name> --image: <image> --replicas 3 --dry-run -o yaml
    ku create deployment <name> --image: <image> --replicas 3
    ku expose deployment <app1> --port 80 --target-port 80 --type ClusterIp --dry-run -o yaml
```
# Labels: 
    labels are used target the pod size 1-63 characters 
    * labes are key value paires 
    * use labels easyly identifies the pods 
    * in k8s any resources identifes another reources useing labels 
# annotation: 
    * used to store metaData
    * you can add the additional futers use the annotations 

# 
``` 
    ku run utils --image sreeharshav/utils:latest
```
login with utils pod check 
```
    nslookup <service-name>
```
# headless services
    it is given all pod IP address. use for DB access 



