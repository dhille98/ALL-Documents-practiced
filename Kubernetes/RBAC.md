## Kubernetes RBAC

* Managed k8s (EKS,AKS, GKE): Native RBAC
* Like AWS-IAM AZURE-ENTRA, Google IAM
* Role-Based Access Control (RBAC) in Kubernetes is a critical framework that regulates 
  
  access to resources based on the roles assigned to users, groups, or service accounts 
  
  within a cluster. This mechanism enhances security by ensuring that users can only 
  
  perform actions that are necessary for their roles, thereby adhering to the principle of least privilege.

**Permissions**
- Role -At Namespace
- ClusterRole -cluster Scop
**Bindings**
- RoleBindings - Namespace Scoped
- ClusterRole Bindigs -Cluster Scoped

* all keys and crt keys in kubernetes in this path 

```
/etc/kubernetes/pki
```

```
    mkdir RBAC
    # import certifacts above path
    sudo apt update && apt install direnv

        echo 'eval "$(direnv hook bash)"' >>~/.bashrc

# create two namespaces 

    kubectl create ns developemnt 
    kubectl create ns production

# create openssl gersa
    cd RBAC
    openssl genrsa -out anand.key 2048
openssl req -new -key anand.key -out anand.csr -subj "/CN=anand/O=development"

openssl genrsa -out bala.key 2048
openssl req -new -key bala.key -out bala.csr -subj "/CN=bala/O=production"

    ls 
# create ca.key and sign in keys

    openssl genrsa -out anand.key 2048
openssl req -new -key anand.key -out anand.csr -subj "/CN=anand/O=development"

    openssl genrsa -out bala.key 2048
openssl req -new -key bala.key -out bala.csr -subj "/CN=bala/O=production"

create a two dirctors

    mkdir /anand
    mkdir /bala
    cp /RBAC/anand* /anand
    cp /RBAC/bala* /bala



# create two users
    echo 'export KUBECONFIG=/home/ubuntu/anand/kubeconfig' >.envrc

cat .envrc

direnv allow .

direnv status
```



` kubectl get po`
Error from server (Forbidden): pods is forbidden: User "bala" cannot list resource "pods" in API group "" in the namespace "production"

` cd .. `
 unloading


delete role on 

`ku delete role -n development anand-role`
`ku delete rolebindings` 

in bala directory executive this commands 

 
echo 'export KUBECONFIG=/bala/kubeconfig' >.envrc

cat .envrc
direnv allow .
direnv status

`kubectl get po`
Error from server (Forbidden): pods is forbidden: User "bala" cannot list resource "pods" in API group "" in the namespace "production"


