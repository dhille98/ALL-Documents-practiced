## AWS Secrates 

1.	Create a IAM User with **SecretsManagerReadWrite Permissions**. Generate Access & Secreys Keys.

2.	Create two sample Secrets in secret manager using Cloudshell using above AWS creds.

[referhere](https://github.com/external-secrets/kubernetes-external-secrets) Kubernetes external secrates with configuration link

# Kubernetes External Secrets

Kubernetes External Secrets allows you to use external secret management systems, like **AWS Secrets Manager** or **HashiCorp Vault**, 

to securely add 

secrets in Kubernetes. Read more about the design and motivation for Kubernetes External Secrets on the GoDaddy Engineering Blog.

The community and maintainers of this project and related Kubernetes secret management projects use the # external-secrets channel on the

 Kubernetes slack for discussion and brainstorming.

[referhere](https://github.com/external-secrets/kubernetes-external-secrets/raw/master/architecture.png) images

![images](https://github.com/external-secrets/kubernetes-external-secrets/raw/master/architecture.png)

```sh
aws secretsmanager create-secret \
 	--name aws-access-key \
 	--secret-string ******* \
 	--region us-east-1
aws secretsmanager create-secret \
 	--name aws-secret-key \
 	--secret-string ******* \
 	--region us-east-1
aws secretsmanager create-secret \
	 --name aws-default-region \
	 --secret-string us-east-1 \
	 --region us-east-1
```

3.	create a key on genaric with use on secratestore this is key will commincate with aws-secrets any chages on key update 
    
	 the secrets store with suppotring form external-secrets 

```
kubectl create secret generic aws-secret --from-literal=access-key=******* --from-literal=secret-key=*******
```
step-4

```sh
	helm repo add external-secrets https://charts.external-secrets.io
	helm repo ls
	helm repo update

	helm install external-secrets \
	   external-secrets/external-secrets \
	   -n external-secrets \
	   --create-namespace 

```

### create a secrate store 
```yaml
---
apiVersion: external-secrets.io/v1beta1
kind: SecretStore
metadata:
  name: aws-secret-store
spec:
  provider:
    aws:
      service: SecretsManager
      region: us-east-1
      auth:
        secretRef:
          accessKeyIDSecretRef:
            name: aws-secret
            key: access-key  
          secretAccessKeySecretRef:
            name: aws-secret
            key: secret-key
```
**create extenal-secrates with referal form secret-store**

```yaml
---
apiVersion: external-secrets.io/v1alpha1
kind: ExternalSecret
metadata:
  name: aws-external-secret-from-secretmanager
spec:
  refreshInterval: 30s
  secretStoreRef:
    name: aws-secret-store
    kind: SecretStore
  target:
    name: aws-credentials-from-secret-manager
  data:
  - secretKey: aws-access-key-from-secretmanager
    remoteRef:
      key: aws-access-key
  - secretKey: aws-secret-key-from-secretmanager
    remoteRef:
      key: aws-secret-key
```
```
	ku get externalsecrets.external-secrets.io
```

excute this commands
```
	kubectl describe externalsecrets.external-secrets.io aws-external-secret-from-secretmanager

```
* create on deployment on checking purpose 
  
```yaml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: app1
  name: app1
spec:
  replicas: 1
  selector:
    matchLabels:
      app: app1
  template:
    metadata:
      labels:
        app: app1
    spec:
      containers:
      - image: sreeharshav/utils:latest
        name: utils
        env:
        - name: AWS_ACCESS_KEY_ID
          valueFrom:
            secretKeyRef:
              name: aws-credentials-from-secret-manager
              key: aws-access-key-from-secretmanager
        - name: AWS_SECRET_ACCESS_KEY
          valueFrom:
            secretKeyRef:
              name: aws-credentials-from-secret-manager
              key: aws-secret-key-from-secretmanager
        
```

**key points:**

* Delete Secret and it will be automatically created.
```
	kubectl delete secrets aws-credentials-from-secret-manager
```
* delete secrets automaticaly create secrets 

* Alter secret still the secret will be synced from the Secrets Manager.
```
	kubectl edit secrets aws-credentials-from-secret-manager
```
* edit the secrets in k8s automatically update the default keys

* if any changes secrets on k8s cluster automtaicaly change on defaul key not updated 
* if want to chages key go on AWS account 