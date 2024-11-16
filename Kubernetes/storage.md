## storage 
    * pods are state less if incase pod restart are deleted no probulem.
    * pods are statefull if incase pod restart are deleted data will lose 

# note: 
     *  in stateless application you can use deployment stage


    1) storage 
    2) statefullset

# storage types 
    * emptyDir
    * hostPath
    * Mount a raw ebs volumes (pv)
    * creating persistatent Volumes (PVC)
    * mounting persistatent volumes using persistant volume claims
    * storage classes
    * Dynamic Provisioning 
    * Open EBS


# emptyDir

    * creating deployment 
```
    kubectl create deployment app1 --image sreeharhav/fastapi:v1 --replicas 3 --dry-run -o yaml

    kubectl expose deployment app1 --port 80 --type NodePort --dry-run -o yaml

```
    * by create pod by default attached storage on `emotyDir` 
        --> main.c -- /etc/date
        --> side.c -- /var/logs 
    * emoty dir usecase some testing purpose 

    * createing the mysql pods with 3 container with useing NodePort
    * in pod runs multipule container with on of the container login commands
```
    ku exec -it <pod_name> -c <container_name> -- bash
```
    * pod or container restart the data will not lose in case delete pod or recreate pod data will be lose


# host path

    * host path usecase you can mount on the worker node filesystem
    * mostly used monitaring 
      ex: `Deamonsets`
    * collecting the metrix on the node
# Q. what is differnt between deployment vs deamonsets 
------------------------------------------------------
# Deamonsets:
    * Deamonsets are used each node request one pod run all the nodes not more the one pod or 
      lessthen one run pod on node 
    * if in case node in maintences pods are deleted but deamonsets pods are not be deleted that 
      time collecting the metrix on pod (delted means cordon).
    
