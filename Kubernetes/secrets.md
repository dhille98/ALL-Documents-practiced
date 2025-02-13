# Kubernetes Secreates 

**secreates in k8s**

* TLS secrets
* Registry Secrets 
* Genrates and Integrating with aws secrates manager with external 
  
**TLS Secretes** 
  
```
kubectl create secret tls wc-tls-secret --cert=wc_k8sb29_shop.crt --key=wc_k8sb29_shop.key
kubectl create secret tls nk-tls-secret --cert=nk_k8sb29_shop.crt --key=nk_k8sb29_shop.key

kubectl describe secrets wc-tls-secret
kubectl describe secrets nk-tls-secret

For Patching the Ingress BlueGreen
# spec:
#   ingressClassName: nginx
#   tls:
#   - hosts:
#     - "bg.k8sb29.shop"
#     secretName: wc-tls-secret
#   rules:
#   - host: bg.k8sb29.shop
#     http:
#       paths:
#       - path: /
#         pathType: Prefix
#         backend:
#           service:
#             name: app1
#             port:
#               number: 80

nano /tmp/patch.yml
kubectl patch ingress bluegreen-ingress-1 --patch-file /tmp/patch.yml

```

**Registry Secretes**


## kubenetes secrertes 
----------------------
    -->   TLS
    --> Registry secrets
    --> Generic and intergating with aws serets manager with external secret operations 


# Lab
-----
    * set up on aws/azuer resgity 

```
    docker push 381491921050.dkr.ecr.ap-south-1.amazonaws.com/school:latest
```
    * after push the docker image create deployment 
```
     ku create deployment app1 --image 381491921050.dkr.ecr.ap-south-1.amazonaws.com/school:latest --replicas 3 --dry-run -o yaml
```
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: app1
  name: app1
spec:
  replicas: 3
  selector:
    matchLabels:
      app: app1
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: app1
    spec:
      containers:
      - image: 381491921050.dkr.ecr.ap-south-1.amazonaws.com/school:latest
        name: school
        resources: {}
status: {}
```
    * after the create a deployment  comming to this error 


NAME                  READY   STATUS             RESTARTS   AGE
app1-bbf5c756-pxgwz   0/1     ImagePullBackOff   0          5m9s
app1-bbf5c756-tnvpr   0/1     ImagePullBackOff   0          5m9s
app1-bbf5c756-w2hd7   0/1     ImagePullBackOff   0          5m9s

    * we need pass the creadtionls 
# create a secret key with aws rigiry 
------------------------------------
```
    # check the ecr passwd 

    aws ecr get-login-password --region ap-south-1
    
    # create secrets ecr

    kubectl create secret docker-registry myecr \
    --docker-server=381491921050.dkr.ecr.ap-south-1.amazonaws.com \
    --docker-username=AWS \
    --docker-password=$(aws ecr get-login-password --region ap-south-1) \
    --docker-email=k8s@gmail.com

```
    * you mensiond on yml file this section 


* steps: push docker image on ECR, ACR, Docker registry 
```
    docker pull sreeharshav/testcontainer:v1
```
*create a registry in aws*

*store the ECR in AWS*

* pushing docker images following steps 

```
# install aws cli on intences 

    aws configure # IAM role atached to ec2 
    aws  s3 ls 
    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 381491921050.dkr.ecr.us-east-1.amazonaws.com
    docker tag sreeharshav/testcontainer:v1 381491921050.dkr.ecr.us-east-1.amazonaws.com/testing:latest
    docker push 381491921050.dkr.ecr.us-east-1.amazonaws.com/testing
```

**Q.how to pull the docker image kubernetes with private registry**

### following the steps 

[referhere](https://github.com/iam-veeramalla/kubernetes-troubleshooting-zero-to-hero/blob/main/01-ImagePullBackOff/02-private-image.md) to pull the ecr images and docker pvt image 

```
    aws ecr get-login-password --region us-east-1

    kubectl create secret docker-registry my-ecr-secret \
    --docker-server=381491921050.dkr.ecr.us-east-1.amazonaws.com \
    --docker-username=AWS \
    --docker-password=$(aws ecr get-login-password --region us-west-2) \
    --docker-email=vajjadhiili@gamil.com

    ku get secrates 
```
* after create the secrests mensiond the yaml file below taxt 
```yaml
imagePullSecrets:
  - name: regcred
``` 

## from-literal generic keys

**generic-keys**
  - **from-literal** means use enverolament 
  - **file mount** use create a yaml file secrets to attched file mount

```
#AWS Credentails As Strings
kubectl create secret generic aws-access-key --from-literal=AWS_ACCESS_KEY_ID=*******
kubectl create secret generic aws-secret-key --from-literal=AWS_SECRET_ACCESS_KEY=*******

```
```
    ku get secrets 
    ku describe secrets <sec-name>
```
## file mount form
```yaml
#AWS Credentails in a file and create secret 
---
apiVersion: v1
kind: Secret
metadata:
  name: aws-creds-in-file
type: Opaque
stringData:
  credentials: |
    [default]
    aws_access_key_id = ******
    aws_secret_access_key = *******

#Mount AWS Credentails as a volume
---
apiVersion: v1
kind: Pod
metadata:
  name: secret-test-pod-1
spec:
  containers:
    - name: aws-cli-container
      image: sreeharshav/utils:latest
      volumeMounts:
        - name: secret-volume
          mountPath: /root/.aws/credentials
          subPath: credentials
          readOnly: true
  volumes:
    - name: secret-volume
      secret:
        secretName: aws-creds-in-file
``` 

**note**: create the secrets and deploymnt and check the configuration "login with container

    check the "env", aws s3 ls


**key points:** above cases secreates delete or change the passwd any update u chage the updates on keys 

* any one can delete or change the passwd 
* kubenetes secrates supports to base64 encrypt 
* best practice perpose you can use cloude secrates (aws secrates, azure keyvaluts)


