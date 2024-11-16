# security Best Practices POD Level and Cluster


## Pod level security 
---------------------

- **readOnlyRootFilesystem**
- **runasNonRoot**
- **runasUser**
- **allowPrivilegeEscalation**
- **allowPrivilegeEscalations: false**


[referhere](https://medium.com/marionete/kubernetes-securitycontext-with-practical-examples-67d890558d11) this link pod level security 
* create a deployment 

```
	ku create deployment app1 --image sreeharshv/testcontainer:v1 --replicas 3 --dry-run -o yaml
```
* **readOnlyRootFilesystem**
* 
* pod level security we are using **security Context** this set a security pod level and container level 


* by default run any pod run as root user 


* first run a default docker images 

* create some file in the pod 

login with pod 
```
    kubectl get po
    kubectl exec -it app1-74d66b5997-6cprs -- bash
```
 
 * create some files 

```sh
for I in { 1..10} 
do
echo $(date) > /etc/demo/FILE-$I
sleep 1
done
```
now add the *securityContext* 
* first run a read only filesystem 


* Read only Root file system 

* deploy the applications

* checking the applications 

```
ku describe pod 
ku logs <pod>

ku delete deploy
```

* utils:latest take this image yaml file
```
ku logs <>
```

* nginx acces log to empty dir


* add the volumes and volume mounts 

* change images nginx:latest
	            sreeharshav/fastapi:v2

* create a one file login in containers 
```yaml
    securityContext:
      readOnlyRootFilesystem: true # you will give true any user not create any things 

```
```
    ku get po
    ku exec -it app1-6bb5f9556b-ckjkz -- bash
```

```
root@app1-6bb5f9556b-ckjkz:/app# ls
main.py  requirements.txt  templates
root@app1-6bb5f9556b-ckjkz:/app# mkdir pod
mkdir: cannot create directory ‘pod’: Read-only file system
root@app1-6bb5f9556b-ckjkz:/app#
```


## run as noon root user

* 1000 and user 
```yaml
securityContext:
          runAsNonRoot: true
          runAsUser: 1000 #This will start the container with user news.
```


* after that checking user `'0'` 
```yaml
securityContext:
          runAsNonRoot: true
          runAsUser: 0
```
* while run user `0` bleow the error 
  
```
dell@instance-20240711-050432:~$ ku get po
NAME                    READY   STATUS                       RESTARTS   AGE
app1-76c78cff85-nqsc7   0/1     CreateContainerConfigError   0          14s
```

* first run 1000  2000 user
```
dell@instance-20240711-050432:~$ ku get po
NAME                    READY   STATUS             RESTARTS     AGE
app1-6c5bf4795b-hd2m2   0/1     CrashLoopBackOff   1 (2s ago)   4s
```
* best practice purpose while creating docker images create a non root user 

* image : utils
* after run a `9 news user`

* login and executing some commands 
```
dell@instance-20240711-050432:~$ ku get po
NAME                   READY   STATUS    RESTARTS   AGE
app1-55d7d4f67-r9btg   1/1     Running   0          45s
dell@instance-20240711-050432:~$ ku exec -it app1-55d7d4f67-r9btg -- bash
news@app1-55d7d4f67-r9btg:/$ whoami
news
```
**Note:** 
* Above cases uses while Docker file createing Docker images best practice creating user in docker images 

* creating deployment file mensioned user id in security Context 

# allow PrivilegesEscalation

* before apply any PrivilegesEscalation in pod 
```
dell@instance-20240711-050432:~$ ku exec -it app1-987d65579-k4lk4 -- bash

root@app1-987d65579-k4lk4:/# ping google.com

PING google.com (74.125.69.100) 56(84) bytes of data.
64 bytes from iq-in-f100.1e100.net (74.125.69.100): icmp_seq=1 ttl=114 time=1.74 ms
64 bytes from iq-in-f100.1e100.net (74.125.69.100): icmp_seq=2 ttl=114 time=1.03 ms
64 bytes from iq-in-f100.1e100.net (74.125.69.100): icmp_seq=3 ttl=114 time=0.985 ms
64 bytes from iq-in-f100.1e100.net (74.125.69.100): icmp_seq=4 ttl=114 time=1.03 ms
64 bytes from iq-in-f100.1e100.net (74.125.69.100): icmp_seq=5 ttl=114 time=1.02 ms
^C
--- google.com ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4004ms
rtt min/avg/max/mdev = 0.985/1.164/1.744/0.293 ms
```
after applying capabilities:

* give on some security applying capabilities and block some capabilities


```yaml
securityContext:
      capabilities:
        drop:
          - ALL
        add: [“NET_ADMIN”]
```


