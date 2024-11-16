## EKS cluster set up on AWS 

**key points:**
* managed kubernetes services manage the  controll plan companates 

**1. Create EKS Cluster**
**2. Deploy AWS Load Balancer Controller.**
**3. Create a Service with type LoadBalacer and check NLB is deployed.**
**4. Create Ingress Service and check ALB Deployed with SSL Termination.**
**5. Create testuser01 and provide role mapping.**
**6. Deploy Jenkins on the EKS Cluster.**
**7. Configure Jenkins Pipeline & execute it.**

* Make sure you have deleted old cloudformation stacks before deploying below commands.
  
# Dependencies
--------------
* Ubuntu 22.04 EC2 Machine
* install unzip & aws cli install 
* install dependeciees 
* 
```sh
    apt update && apt install -y unzip
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    aws version 
	aws configure
```

* IAM User with Access and Secret Key with Administator Access
* install kubectl && eksctl
  
```sh
    aws configure 
    ## Kubectl
    curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo mv ./kubectl /usr/local/bin/kubectl
    chmod 777 /usr/local/bin/kubectl
    kubectl version --short
    
    ## Download eksctl
    curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
    sudo mv /tmp/eksctl /usr/local/bin
    sudo chmod 700 /usr/local/bin/eksctl
    eksctl version
```

### The below cluster needs 25 mins for creation.

* file name eksctl-ipv4-cluster.yml 
* by run root user `sudo -i`
* create key `ssh-keygen`
```yaml
---
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig

metadata:
  name: k8sb29-cluster-01 # cluster-name
  region: ap-south-1
  version: "1.29"

kubernetesNetworkConfig:
  ipFamily: IPv4
addons:
  - name: vpc-cni
    version: latest
  - name: coredns
    version: latest
  - name: kube-proxy
    version: latest
  - name: aws-ebs-csi-driver
    version: latest
  - name: aws-efs-csi-driver
    version: latest

iam:
  withOIDC: true

managedNodeGroups:
  - name: nodegroup1
    instanceType: t3.large
    minSize: 2
    desiredCapacity: 3
    maxSize: 4
    availabilityZones: ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
    volumeSize: 10
    ssh:
      allow: true
      publicKeyPath: /root/.ssh/id_rsa.pub
```
```sh
#Cluster Creation
    eksctl get cluster --region=ap-south-1
    eksctl create cluster -f eksctl-ipv4-cluster.yml &

# after the create EKS cluster 
    kubectl get nodes
    kubectl get po -A
```
**2. Deploy AWS Load Balancer Controller.**

* aws loadblancer useing EKS CLUSTER suporting own ingress controoler
* installations steps 
   
*Make sure you have deleted old cloudformation stacks before deploying below commands.*
```sh
#  download the iam policy 
curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.5.4/docs/install/iam_policy.json

# create a iam policy useing aws cli 
aws iam create-policy \
    --policy-name AWSLoadBalancerControllerIAMPolicy \
    --policy-document file://iam_policy.json

# creating service account 
eksctl create iamserviceaccount \
    --cluster=k8sb29-cluster-01 \
    --namespace=kube-system \
    --name=aws-load-balancer-controller \
    --role-name AmazonEKSLoadBalancerControllerRole \
    --attach-policy-arn=arn:aws:iam::009412611595:policy/AWSLoadBalancerControllerIAMPolicy \
    --approve --region=us-east-2

# instaling helm repositary 

cd /usr/local/bin &&
    wget https://get.helm.sh/helm-v3.13.1-linux-amd64.tar.gz &&
    tar xzvf helm-v3.13.1-linux-amd64.tar.gz &&
    cp linux-amd64/helm . && rm -rf linux-amd64/ &&
    helm version

# adding the EKS charts 

helm repo add eks https://aws.github.io/eks-charts
helm repo ls
helm repo update eks

# aws loadblancer install useing helm repo

helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
    -n kube-system \
    --set clusterName=k8sb29-cluster-01 \
    --set serviceAccount.create=false \
    --set serviceAccount.name=aws-load-balancer-controller

# after cheking the pods all namespaces 

    ku get po -A
    kubectl get pods -n kube-system
```

###  create secrets WC and NK Create SSL/TLS Secrets:
```

    kubectl create secret tls my-tls-secret --cert=tls.pem --key=tls.key
    kubectl create secret tls my-tls-secret-nk --cert=tls.pem --key=tls.key
```
* checking deployment testing 

* in **aws certificates manager** impottes to certificates
* copy the arn and give on ingerss controller **Annotations**  


```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  namespace: default
  name: votingapp-ingress
  annotations:
    #kubernetes.io/ingress.class: alb - Deprecated
    alb.ingress.kubernetes.io/scheme: internet-facing
    alb.ingress.kubernetes.io/target-type: instance
    alb.ingress.kubernetes.io/healthcheck-protocol: HTTP
    alb.ingress.kubernetes.io/ssl-redirect: '443'
    alb.ingress.kubernetes.io/listen-ports: '[{"HTTP": 80}, {"HTTPS": 443}]'
    alb.ingress.kubernetes.io/healthcheck-timeout-seconds: "5"
    alb.ingress.kubernetes.io/success-codes: "200"
    alb.ingress.kubernetes.io/unhealthy-threshold-count: "2"
    #Make sure our SSL Cert and Cluster is in same AWS Account. and configure the aws certificates 
    alb.ingress.kubernetes.io/certificate-arn: 'arn:aws:acm:us-east-2:009412611595:certificate/dc5b9c13-0169-40bb-8a68-8f7870ce461c' 
spec:
  ingressClassName: alb
  tls:
  - hosts:
    - "vote.dhille.shop"
    - "result.dhille.shop"
    - "www.dhille.shop"
    secretName: my-tls-secret
  rules:
  - host: vote.dhille.shop
    http:
      paths:
        - path: /
          pathType: Prefix
          backend:
            service:
              name: vote
              port:
                number: 80
  - host: result.dhille.shop
    http:
      paths:
        - path: /
          pathType: Prefix
          backend:
            service:
              name: result
              port:
                number: 80
  - host: www.dhille.shop
    http:
      paths:
        - path: /
          pathType: Prefix
          backend:
            service:
              name: vote
              port:
                number: 80
```
  
* all its works fine we need to usethe eks cluster 

