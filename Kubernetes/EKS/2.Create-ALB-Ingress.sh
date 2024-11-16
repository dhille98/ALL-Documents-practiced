Make sure you have deleted old cloudformation stacks before deploying below commands.

curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.5.4/docs/install/iam_policy.json

aws iam create-policy \
    --policy-name AWSLoadBalancerControllerIAMPolicy \
    --policy-document file://iam_policy.json

eksctl create iamserviceaccount \
    --cluster=k8sb29-cluster-01 \
    --namespace=kube-system \
    --name=aws-load-balancer-controller \
    --role-name AmazonEKSLoadBalancerControllerRole \
    --attach-policy-arn=arn:aws:iam::009412611595:policy/AWSLoadBalancerControllerIAMPolicy \
    --approve --region=us-east-2

cd /usr/local/bin &&
    wget https://get.helm.sh/helm-v3.13.1-linux-amd64.tar.gz &&
    tar xzvf helm-v3.13.1-linux-amd64.tar.gz &&
    cp linux-amd64/helm . && rm -rf linux-amd64/ &&
    helm version

helm repo add eks https://aws.github.io/eks-charts
helm repo ls
helm repo update eks

helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
    -n kube-system \
    --set clusterName=k8sb29-cluster-01 \
    --set serviceAccount.create=false \
    --set serviceAccount.name=aws-load-balancer-controller

root@ip-10-40-1-85:~# kubectl get pods -n kube-system
NAME READY STATUS RESTARTS AGE
aws-load-balancer-controller-585b4d8dd9-j429d 1/1 Running 0 25s
aws-load-balancer-controller-585b4d8dd9-w9pbf 1/1 Running 0 25s

Create SSL/TLS Secrets:
kubectl create secret tls my-tls-secret --cert=tls.pem --key=tls.key
kubectl create secret tls my-tls-secret-nk --cert=tls.pem --key=tls.key
