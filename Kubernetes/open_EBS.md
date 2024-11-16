# open EBS
------------

* open bs eastblish for layer of node 
* 
```
    kops create cluster --name=dhille.shop --state=s3://dhillek8s.xyz --zones=us-east-1a,us-east-1b,us-east-1c --node-count=3 --control-plane-count=1 --node-size=t3.large --control-plane-size=t3.large --control-plane-zones=us-east-1a --control-plane-volume-size 20 --node-volume-size 20 --ssh-public-key ~/.ssh/id_ed25519.pub --dns-zone=dhille.shop --networking calico
```
* after excutative above command 
```
    kops get ig --name dhille.shop
    kops edit ig nodes-us-east-1a --name dhille.shop
    kops edit ig nodes-us-east-1b --name dhille.shop
    kops edit ig nodes-us-east-1c --name dhille.shop

```

```yaml
  volumes:
  - device: /dev/xvdd
    size: 20
    type: gp2
```

* change the ymal file 
```yaml
---
apiVersion: kops.k8s.io/v1alpha2
kind: InstanceGroup
metadata:
  labels:
	kops.k8s.io/cluster: my-beloved-cluster
  name: compute
spec:
  cloudLabels:
	role: compute
  image: coreos.com/CoreOS-stable-1855.4.0-hvm
  machineType: m4.large
  ...
  volumes:
  - device: /dev/xvdd
    size: 20
    type: gp2
```
* after update the kops cluster 

```
kops update cluster --yes --name dhille.shop --admin
```
* create the kops cluser 
```
    ku get node
```
* Run following commands on all Control & Worker Nodes.
* login into each cluster via 'ssh'
```
    sudo apt-get update && sudo apt-get install open-iscsi -y && sudo systemctl enable --now iscsid && systemctl status iscsid --no-pager

```
* creat a namespace in k8s cluster 
```
    kubectl create ns openebs
    kubectl apply -f https://openebs.github.io/charts/openebs-operator.yaml
    kubectl apply -f https://openebs.github.io/charts/cstor-operator.yaml

    kubectl get pods -n openebs
    kubectl get sc
```

* 
```
    kubectl get blockdevice -n openebs
    kubectl describe blockdevice <name>| grep -i Elastic_Block_Store
    kubectl get blockdevice | grep Unclaimed
```
## Download CStorPoolCluster.yaml to local from google drive. Make sure you change the kubernetes.io/hostname & blockDeviceName

* cstorpoolcluster.yml
``` yaml
apiVersion: cstor.openebs.io/v1
kind: CStorPoolCluster
metadata:
  name: cstor-storage
  namespace: openebs
spec:
  pools:
    - nodeSelector:
        kubernetes.io/hostname: "i-0ab2e2a5d60109a40" # edit
      dataRaidGroups:
        - blockDevices:
            - blockDeviceName: "blockdevice-03cb97c4619e6018aa0af200caabf29a" # edit
      poolConfig:
        dataRaidGroupType: "stripe"

    - nodeSelector:
        kubernetes.io/hostname: "i-04113ca22adc8b548"  # edit
      dataRaidGroups:
        - blockDevices:
            - blockDeviceName: "blockdevice-1861d31030cf33e06c6d92a5a5179d5e" # edit
      poolConfig:
        dataRaidGroupType: "stripe"
   
    - nodeSelector:
        kubernetes.io/hostname: "i-0c9ee1317024191f7" # edit
      dataRaidGroups:
        - blockDevices:
            - blockDeviceName: "blockdevice-c782ca827bb23071ca94485ef46cba79" # edit
      poolConfig:
        dataRaidGroupType: "stripe"
```
```
    
    Kubectl apply -f CStorPoolCluster.yaml
```
```

    kubectl get cspc -n openebs
```
## Wait for a min to get all disks online.
## Wait until STATE is ONLINE for all the disks.
```
kubectl get cspi -n openebs --no-headers  
```
# Download and execute openebs-StorageClass.yaml
-------------------------------------------------
```yaml
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: cstor-csi
provisioner: cstor.csi.openebs.io
allowVolumeExpansion: true
parameters:
  cas-type: cstor
  # cstorPoolCluster should have the name of the CSPC
  cstorPoolCluster: cstor-storage
  # replicaCount should be <= no. of CSPI
  replicaCount: "3"
```
```
    kubectl apply -f openebs-StorageClass.yaml
    kubectl get sc | grep -i 'cstor-csi'
```
# Download and execute PersistentVolumeClaim.yaml 
-------------------------------------------------

``` yaml
---
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: demo-cstor-vol-1
spec:
  storageClassName: cstor-csi
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi

---
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: demo-cstor-vol-2
spec:
  storageClassName: cstor-csi
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 2Gi

---
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: demo-cstor-vol-3
spec:
  storageClassName: cstor-csi
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 3Gi
``` 
```
    kubectl get pvc
```
```
    kubectl get cstorvolumeconfig -n openebs
```
```
    kubectl get cstorvolume -n openebs
```
```
    kubectl get cstorvolumereplica -n openebs
```
# Wait for 2 min and all the PV show healthy.
---------------------------------------------

* For testing mongodb statefulset with openebs, delete all pv and pvc as mongo uses volumeClaimTemplates to create PV and PVC automatically.
```

kubectl delete pvc  --all
``` 

# Use the file mongodb-statefullset.yml for testing openebs with Mongo Statefulset.
-----------------------------------------------------------------------------------
``` yaml
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: mongodb
  namespace: default
spec:
  selector:
    matchLabels:
      app: mongodb
  serviceName: mongodb
  replicas: 3
  template:
    metadata:
      labels:
        app: mongodb
    spec:
      containers:
      - name: mongodb
        image: mongo
        env:
        - name: MONGO_INITDB_ROOT_USERNAME
          value: "root"
        - name: MONGO_INITDB_ROOT_PASSWORD
          value: "India123456"
        command:
          - mongod
          - "--bind_ip"
          - "0.0.0.0"
          - "--replSet"
          - "rs0"
        ports:
        - containerPort: 27017
        volumeMounts:
        - name: data
          mountPath: /data/db
  volumeClaimTemplates:
  - metadata:
      name: data
      annotations:
        volume.beta.kubernetes.io/storage-class: "cstor-csi"
    spec:
      accessModes: [ "ReadWriteOnce" ]
      resources:
        requests:
          storage: 3Gi


---
#This service is used by MongoDB Pods for Cluster Communication.
apiVersion: v1
kind: Service
metadata:
  name: mongodb
spec:
  clusterIP: None
  selector:
    app: mongodb
  ports:
  - protocol: TCP
    port: 27017
    targetPort: 27017

---
#This service is used by MongoDB Pods for Application Communication.
apiVersion: v1
kind: Service
metadata:
  labels:
    app: mongodb
  name: mongodb-app
spec:
  ports:
  - port: 27017
    protocol: TCP
    targetPort: 27017
    nodePort: 31234
  selector:
    app: mongodb
  type: NodePort

---
#This service is used by MongoDB Pods for Application Communication.
apiVersion: v1
kind: Service
metadata:
  labels:
    app: mongodb
    apps.kubernetes.io/pod-index: "0"
    statefulset.kubernetes.io/pod-name: mongodb-0
  name: mongodb-0
spec:
  ports:
  - port: 27017
    protocol: TCP
    targetPort: 27017
    nodePort: 31111
  selector:
    app: mongodb
    apps.kubernetes.io/pod-index: "0"
    statefulset.kubernetes.io/pod-name: mongodb-0
  type: NodePort
```
## Troubleshooting
```
ku run utils --image sreeharshav/utils:latest
```
root@utils:/# "nslookup mongodb"
Server:         100.64.0.10
Address:        100.64.0.10#53

Name:   mongodb.openebs.svc.cluster.local
Address: 100.96.243.200
Name:   mongodb.openebs.svc.cluster.local
Address: 100.120.182.12
Name:   mongodb.openebs.svc.cluster.local
Address: 100.96.71.76

root@utils:/# "nslookup 100.96.243.200"
200.243.96.100.in-addr.arpa     name = mongodb-2.mongodb.openebs.svc.cluster.local.
200.243.96.100.in-addr.arpa     name = 100-96-243-200.mongodb-np.openebs.svc.cluster.local.


root@utils:/# "nslookup mongodb-2.mongodb.openebs.svc.cluster.local."
Server:         100.64.0.10
Address:        100.64.0.10#53

Name:   mongodb-2.mongodb.openebs.svc.cluster.local
Address: 100.96.243.200


```
ku exec -it mongodb-0 -- mongosh
```
```
rs.status()
rs.initiate({ _id: "rs0", version: 1,
members: [
 { _id: 0, host: "mongodb-0.mongodb.default.svc.cluster.local:27017" },
 { _id: 1, host: "mongodb-1.mongodb.default.svc.cluster.local:27017" },
 { _id: 2, host: "mongodb-2.mongodb.default.svc.cluster.local:27017" }
 ]
 });
```

# Making mongo-0 as priamry after mongodb-0 recreation.
------------------------------------------------------
* which one the primey that pod you are login exucative this commands 

```
cfg = rs.conf()
cfg.members[0].priority = 1
cfg.members[1].priority = 0.5
cfg.members[2].priority = 0.5
rs.reconfig(cfg)
```



