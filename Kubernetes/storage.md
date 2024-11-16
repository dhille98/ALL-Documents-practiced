# kubernetes storages

    --> Pods are state less if in case pod restart are deleted no Probulams
   **state less allpications is useing  deployement** 
    
    for pods are data base like MY Sql / MongoDb / postgress Sql we need to save the date

    1. Storage 
    2.  State fullset
## storage Type

1. EmptyDIR
2. HostPath
3. Mounting a Raw EBS Volume
4. creating Present Volumes(Pv) & mounting the presitant Volume using PVC
5. Storage Classes
6. Srarage Classes 
7. Dynamic Provisioning 
8. Open EBS


## EmptyDir

* if you creating a pod by default attached storage on `EmptyDir`
* thats why if you pod restart data will not lose 
*  Empty Dir usecase some testing Purpose 


![preview](https://1.bp.blogspot.com/-wSVvC_X8sqI/YYFjgajGPSI/AAAAAAAAJEA/F0_2MrX-bzAgwxDM9V7razreZEwwAGVBACLcBGAsYHQ/w400-h266/kubenetes-volume-emptydir.PNG)

**steps**:
    - create a deployment 
```
    kubectl create deployemnt app1 --image sreeharshav/testcontainer:v1 --replicase 3 -o yaml
```
    - kubernetes expose serve on 
```
    kubectl expose deployment app1 --type NodePort port 80 
```
### creating a mysql Pods with 3 container with using Nodeport 

```yaml 
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mysql
spec:
  selector:
    matchLabels:
      app: mysql
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
      - image: sreeharshav/utils:latest
        name: utils
        volumeMounts:
        - name: sqldata
          mountPath: /sqldata
        resources:
          requests:
            memory: "64Mi"
            cpu: "250m"
          limits:
            memory: "128Mi"
            cpu: "500m"
      - image: adminer:latest
        name: adminer
        ports:
         - containerPort: 8080
      - image: mysql:8.0
        name: mysql
        env:
        - name: MYSQL_ROOT_PASSWORD
          value: "India@123456"
        ports:
        - containerPort: 3306
          name: mysql
        volumeMounts:
        - name: sqldata
          mountPath: /var/lib/mysql
        resources:
          requests:
            memory: "64Mi"
            cpu: "250m"
          limits:
            memory: "500Mi"
            cpu: "500m"
      volumes:
        - name: sqldata
          emptyDir: {}
---
apiVersion: v1
kind: Service
metadata:
  name: mysql
spec:
  type: NodePort
  ports:
    - name: mysql
      protocol: TCP
      port: 3306
      targetPort: 3306
    - name: adminier
      protocol: TCP
      port: 8080
      targetPort: 8080
  selector:
    app: mysql
```
*   creating multi pod container login with one of the container useing this command 

```
    kubectl exec --it <pod> -c <container> -- bash
```
## HostPath

* host path usecase you can mount on the worker node filesystem 
* mostly used on Deamon sets `collecting the metrics on pod/node`

**QS. what is different between Deployment and Deamonsets**

    Each Node Requrement one Pod run all the nodes Not a more then one and less then one 

    if incase node in maintences pods are deleted but Demon sets pod are not be deleted 

    that time Deamonset pod run and collecting the metcrics like `cordon`

* sample yaml file
```yaml
volumeMounts:
        - mountPath: /host/sys
          mountPropagation: HostToContainer
          name: sys
          readOnly: true
        - mountPath: /host/root
          mountPropagation: HostToContainer
          name: root
          readOnly: true
      volumes:
      - hostPath:
          path: /sys
        name: sys
      - hostPath:
          path: /
        name: root
      tolerations:  
      - key: "node-role.kubernetes.io/control-plane"
        operator: "Equal"
        effect: "NoSchedule"
```






