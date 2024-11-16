## jenkins instalations 
[referhere](https://chatgpt.com/c/06bb7593-4b1a-4bed-8b1d-d9407cb2f328)
[referhere](https://www.jenkins.io/doc/book/installing/linux/)

```sh
# create ubuntu server / are using same server in k8s cluster 

    sudo apt update & sudo apt install openjdk-17-jdk -y
    apt update && apt install -y openjdk-11-jdk jq net-tools

    # Docker install 
    curl https://get.docker.com | sudo bash
    # kubectl
    # aws cli 

    # service jenkins status
    sysetmctl status jenkins.service 
```
### open github configure the webhooks 
* go to GitHub 
* create repository with *private*
* add the key on `deploy-keys` on git hub > settings 
* we need to upload to the key what ever key in jenkins `ssh-keygen`
* in github give on `public-key (id_rsa.pub)`

* in jenkins manage jenkins give on key  `private-key(id_rsa)`
```
    su Jenkins
    ssh-keygen 
    manage Jenkins > crearditinal 
```
* add cread
```
security -- git host 
git hub triggers 
webhooks activate
``` 
  given url of Jenkins in webhooks configurations : `http://55.77.708.75:8080/github-webhook`

```sh
    ku get cm -n kube-system 

    ku get cm aws-auth -n kube-system -o yaml 
    ku edit cm aws-auth -n kube-system -o yaml 
```

**update aws-auth key**

```yaml
--- 
apiVersion: v1
data:
  mapRoles: |
    - groups:
      - system:bootstrappers
      - system:nodes
      rolearn: arn:aws:iam::009412611595:role/eksctl-k8sb29-cluster-01-nodegroup-NodeInstanceRole-Gp9OrbfQnJgm
      username: system:node:{{EC2PrivateDNSName}}
    - rolearn: arn:aws:iam::009412611595:role/k8sb29-mgmt-role  
      username: k8sb29-mgmt-role
      groups:
      - system:masters
  mapUsers: |
    - userarn: arn:aws:iam::009412611595:user/eks-admin
      username: eks-admin
      groups:
      - system:masters
kind: ConfigMap
```
**Note:** abvoe yaml file change the role-name on what ever attached on ubuntu/EC2 instances role 

export KUBE_EDITOR=nano 

### Jenkins file in sample 

[ReferHere](https://www.jenkins.io/doc/book/pipeline/syntax/) this jenkinsfile syntax 

```Jenkinsfile

pipeline {
   agent any
   environment {
      PROJECT = 'WELCOME TO K8S B29 BATCH - Jenkins Class'
      DESTROY = "TRUE"
   }
   stages {
      stage('Check The Kubernetes Access') {
         when {
            expression {
                 env.DESTROY == 'FALSE'
            }
         }
         steps {
            sh 'aws eks --region us-east-2 update-kubeconfig --name k8sb29-cluster-01'
            sh 'kubectl get pods -A'
            sh 'kubectl get ns'
         }
      }
      stage('Deploy Voting App') {
         when {
            expression {
                 env.DESTROY == 'FALSE'
            }
         }
         steps {
            sh 'ls -al'
            sh 'kubectl apply -f 1.votingapp.yml'
            sh 'kubectl get pods,svc'
         }
      }
      stage('Deploy Ingress for Vote & Result') {
         when {
            expression {
                 env.DESTROY == 'FALSE'
            }
         }
         steps {
            sh 'kubectl apply -f 2.ingress.yml'
            sh 'kubectl apply -f 3.ingress-nk.yml'
            sh 'kubectl get ingress'
         }
      }
      stage('Validating Deployment') {
         when {
            expression {
                 env.DESTROY == 'FALSE'
            }
         }
         steps {
            sh 'kubectl get pods,deployment,svc,ing'
         }
      }
      stage('Perform Kubectl Destroy') {
         when {
            expression {
                 env.DESTROY == 'TRUE'
            }
         }
         steps {
            sh 'kubectl delete -f 1.votingapp.yml || exit 0'
            sh 'kubectl delete -f 2.ingress.yml || exit 0'
            sh 'kubectl delete -f 3.ingress-nk.yml || exit 0'
         }
      }
   }
}
```
**Note Points:** 
    * `when` conditions used run particalar stage on jenkins pipeline
    * if you exit on step on force fully use  on `|| exit 1`
    * jenkins file in steps any step fail excute on pipeline use on `|| exit 0`