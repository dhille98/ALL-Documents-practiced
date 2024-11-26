To grant specific permissions to an IAM user in an Amazon EKS (Elastic Kubernetes Service) cluster, you need to configure both AWS IAM and Kubernetes Role-Based Access Control (RBAC). Here’s a step-by-step guide on how to achieve this:

## Steps to Grant Permissions

### 1. Create an IAM Policy

First, define an IAM policy that specifies the permissions you want to grant. This policy will allow the user to interact with the EKS cluster.

- **Example Policy** (JSON format):

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "eks:DescribeCluster",
                "eks:ListClusters"
            ],
            "Resource": "*"
        }
    ]
}
```

### 2. Attach the IAM Policy to the User

Attach the created IAM policy to the specific IAM user who needs access to the EKS cluster.

1. Go to the **IAM console**.
2. Select **Users** and choose the user.
3. Click on **Add permissions** and attach the policy you just created.

### 3. Update aws-auth ConfigMap

You need to modify the `aws-auth` ConfigMap in your EKS cluster to map the IAM user to Kubernetes RBAC roles.

1. **Retrieve Current ConfigMap**:

   ```bash
   kubectl get configmap aws-auth -n kube-system -o yaml > aws-auth.yaml
   ```

2. **Edit aws-auth.yaml**: Add the IAM user under the `mapUsers` section.

   ```yaml
   apiVersion: v1
   data:
     mapUsers: |
       - userarn: arn:aws:iam::<AWS_ACCOUNT_ID>:user/<IAM_USER_NAME>
         username: <K8S_USERNAME>
         groups:
           - system:masters  # or a custom group with specific permissions
   ```

   Replace `<AWS_ACCOUNT_ID>`, `<IAM_USER_NAME>`, and `<K8S_USERNAME>` with appropriate values.

3. **Apply Changes**:

   ```bash
   kubectl apply -f aws-auth.yaml
   ```

### 4. Define Kubernetes RBAC Roles

If you want to give more granular permissions rather than full access, define Kubernetes RBAC roles and role bindings.

- **Create a Role** (e.g., `read-only-role.yaml`):

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: default  # specify your namespace
  name: read-only-role
rules:
- apiGroups: [""]
  resources: ["pods", "services"]
  verbs: ["get", "list"]
```

- **Create a RoleBinding**:

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: read-only-binding
  namespace: default  # specify your namespace
subjects:
- kind: User
  name: <K8S_USERNAME>  # same as above
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: read-only-role
  apiGroup: rbac.authorization.k8s.io
```

- **Apply RBAC Policies**:

```bash
kubectl apply -f read-only-role.yaml
kubectl apply -f read-only-binding.yaml
```

### 5. Verify Access

Log in as the IAM user and verify that they can access the EKS cluster using `kubectl`. You can test this by running:

```bash
kubectl get pods --namespace default
```

If everything is configured correctly, the user should be able to see the pods in the specified namespace based on their assigned roles.

## Conclusion

By following these steps, you can effectively grant specific permissions to an IAM user for accessing resources in your Amazon EKS cluster. This process involves creating an IAM policy, updating the `aws-auth` ConfigMap, and defining Kubernetes RBAC roles for fine-grained access control.

Citations:
[1] https://repost.aws/knowledge-center/amazon-eks-cluster-access
[2] https://antonputra.com/kubernetes/add-iam-user-and-iam-role-to-eks/
[3] https://docs.aws.amazon.com/eks/latest/userguide/cluster-auth.html
[4] https://docs.aws.amazon.com/eks/latest/userguide/grant-k8s-access.html
[5] https://docs.aws.amazon.com/eks/latest/userguide/cluster-iam-role.html
[6] https://cloud.theodo.com/en/blog/aws-eks-cluster
[7] https://aws.github.io/aws-eks-best-practices/security/docs/iam/
[8] https://docs.aws.amazon.com/eks/latest/userguide/security-iam.html