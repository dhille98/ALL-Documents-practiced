* how to set up secrets in Jenkins 
* what are measure issue found in Jenkins 
* Jenkins jobs are ques, what is reason 
* how rollback on previous version on helm 
* in sonar qube found 100 vulnerabilities how to manage the Jenkins 
* how design the multi branch pipeline in Jenkins 


interview wipro 
===============

* tell me about your current DevOps Project and what are your daily roles and responsibilities  
* how do you identify and resolve the high CPU and memory usage in a Linux server 
* write a shell script to monitor a process to restart if it is not running 
* can you please explain me situation where you handle git merge conflict during a hot-fix in a live production branch.
* how do you enforce branch protection and code reviews in a GitHub CI/CD pipeline 
* 		code quality gates
		code quality profile 

* what are the strategies you have used to reduce a docker image size and speed up the build time 
	- optimise build 
	- reduce the layers
	-  speed up build process 

* how do you handle the persistent data in docker containers with real time 
* 		- docker volume 
		- backup the in side the container volume  

* how do you Argo CD fit to gitops fork flow in CI/CD pipeline 

* how do you configure hight availability and application on AWS using easy to ALB auto scaling 
* how do you monitor the infrastructure setup alerts in downtime 
* VPC peering 
* where you guys are maintaining sate files 
* how do you use the terraform provisioning vpc with public and private subnets 
* can you explain me difference between terraform taint / refresh / plan 
* how do you integrate SonarQube code quality checks and nexus artifactory with Jenkins pipeline 
* how did you handle situation where Kubernetes pod was going to crash loop back off state 
* what is your approach zero downtime deployments in Kubernetes 
* in production ENV one application pod was down, how do you troubleshoot  


----
* git cherry pick
* write docker file for spring boot application 
* what is different between COPY vs ADD
* what are types of networking 
* how to build the docker image (command )
* how to change the port on while running docker container 
* in your project how many microservices and nodes
* in deployment pod is schedule on 4 nodes out 15 nodes how 
* what is taint and tolerations
* what errors you see the Kubernetes 
* in Jenkins server issue with cpu and memory what you will have do 
* what are the Jenkins pipeline stages in your projects 
* terraform your using the resources or modules 
* in terraform with out using resources create a any resources by using modules 
* in aws console creating vpc but your not access on aws console ypur team lead giving the creadtionals giving task on creating 4 subnetes  how to do (terraform import/datasources)
* what are step need to creating MySQL data base 
* any sensitive information how to do in terraform 
* what is different between terraform vs ansible 
* write a shell scripting creating file 

---
1. How do you implement CI/CD for databases while ensuring data integrity and consistency?


2. What strategies do you use for database versioning and schema migrations in a CI/CD pipeline?


3. How do you handle database rollbacks in case of a failed deployment?


4. What are the best practices for automating database schema changes in CI/CD workflows?


5. How do you manage database state across different environments (dev, staging, production) in CI/CD?


6. What tools have you used for database CI/CD automation, and how do they work?


7. How do you ensure database migrations are applied safely in a zero-downtime deployment?


8. What are the common challenges in implementing CI/CD for databases, and how do you address them?


9. How do you integrate database tests into your CI/CD pipeline, and what types of tests do you run?


10. What role does Infrastructure as Code (IaC) play in database CI/CD, and how do you implement it?

---


Terraform
---------
* what if your terraform state file is deleted ?
* what if two engineers run terraform apply at the same time ?
* what if a terraform apply fails halfway ?
* what if AWS API rate limits are hit during deployment ?
* what if terraform plan shows no changes but some manually modified infra ?
* what if you remove a resource from your terraform config?
* what if a provider API changes between Terraform versions?
* what if your terraform modules have circular dependencies ?
* what if you exceed AWS service quotas during deployment 
* WHAT IF YOU LOSE ACCESS TO THE REMOTE BACKEND STORING YOUR TERRAFORM STATE? 

aws
---
* How does AWS IAM work, and how do you manage permissions?
* 
* What is the difference between EC2, Lambda, and ECS/EKS?
* 
* Explain AWS Transit Gateway and its use case.
* 
* Your application is running slow in AWS. How do you troubleshoot?
* You need to migrate a legacy application to AWS. How would you plan it?
* Your EC2 instance is suddenly terminated. How do you find out why?
* You need to restrict access to S3 buckets. What security measures will you take?
* You need to design a highly available architecture for an application. What services would you use?
* How would you automate patching for EC2 instances?
* Your EKS pods are failing. How do you debug the issue?
* Your Lambda function is taking too long to execute. How do you optimize it?

* How would you estimate the cost of implementing an AWS-based solution?

* Can you provide a quotation for deploying a Kubernetes cluster for a large-scale application?

* What factors would you consider when estimating the resources required for a cloud migration?

* Can you estimate how long it would take to set up a fully automated CI/CD pipeline for a microservices architecture?

* How much time would be required to migrate a web application from AWS to Azure?

* What would be your contingency plan if an AWS service goes down during deployment?

* How would you mitigate risks associated with containerization and orchestration using Kubernetes?

* How would you improve the deployment time for a project that's facing delays due to long CI/CD pipeline executions?

* Can you suggest improvements for an existing infrastructure setup that is manually provisioned?

* Can you provide a solution for integrating AWS Lambda with a Kubernetes cluster for event-driven architecture?

* How would you set up monitoring and alerting for an Azure-based Kubernetes cluster?

* Can you provide a quotation for setting up security best practices for a production environment in AWS/Azure?

1. What is the role of IAM roles and policies?
2. Can you explain the Terraform plan and its purpose?
3. What is AWS Lambda, and how does it work?
4. How do you invoke a Lambda function, and where do you configure it?
5. Can you describe how Lambda handles scaling and event-based invocations?
6. What is Amazon CloudWatch, and have you configured any custom metrics?
7. What metrics are available on your CloudWatch dashboard?
8. How do you configure CPU utilization on your CloudWatch dashboard?
9. How do you attach an SSL certificate to an S3 bucket?
10. What type of encryption have you implemented in your project?
11. If an S3 bucket has a read-only policy, can you modify objects in the bucket?
12. Why did you choose Terraform over Boto3 for infrastructure provisioning?
13. What is a Content Delivery Network (CDN), and how does it work?
14. Have you created a Jenkins pipeline for your project?
15. How do you attach policies to IAM users, either individually or by group?
16. What type of deployment strategies are you using in your project?
17. Have you used any tools to create customized Amazon Machine Images (AMIs)?
18. What is connection draining, and how does it work?
19. How does an Elastic Load Balancer (ELB) distribute traffic?
20. What is auto-scaling, and how does it work?
21. Can you describe the different types of Load Balancers and provide examples?
22. What is the maximum runtime for a Lambda function?
23. What is the maximum memory size for a Lambda function?
24. How can you increase the runtime for a Lambda function?
25. What automations have you performed using Lambda in your project?
26. Why did you choose Terraform over Boto3 for infrastructure provisioning?
27. What modules have you used in your Lambda function?
28. Have you created an SNS topic for your project?
29. If you've exhausted IP addresses in your VPC, how would you provision new resources?
30. What is Groovy, and how is it used in Jenkins?
31. Why do you use Groovy in Jenkins, and where do you save Jenkins files?
32. What is Ansible, and what is its purpose?
33. What language do you use in Ansible?
34. Where do you run Terraform code, remotely or locally?
35. What is the purpose of access keys and secret keys in AWS?
36. What are Terraform modules, and have you used any in your project?
37. What environments have you set up for your project?
38. Do you use the same AWS account for all environments?
39. Do you have separate Jenkins servers for each environment?
40. Where do you write and save your Lambda function code?





kubernetes
----------
How do you scale a Kubernetes application?
What is ClusterIP, NodePort, LoadBalancer, and Ingress?
How does Kube-proxy work?
Explain Service Discovery in Kubernetes.

What is a Persistent Volume (PV) and Persistent Volume Claim (PVC)?
Difference between emptyDir vs. hostPath vs. PV/PVC?
How does StorageClass help in dynamic volume provisioning?

How do you automate Kubernetes deployments using Jenkins, Azure DevOps, or GitHub Actions?

How does ArgoCD work?

How to mount ConfigMaps and Secrets into a Pod?

What is a Custom Resource Definition (CRD)?
What is the difference between a Controller and an Operator?

What are PodSecurityPolicies (PSP) and PodSecurity Admission (PSA)?
What is a SecurityContext?
How do you implement container runtime security?

Difference between Role vs. ClusterRole?
How to restrict access to Kubernetes resources?
What are Network Policies in Kubernetes?

How do you store and manage secrets in Kubernetes?
Integrating HashiCorp Vault or AWS Secrets Manager with K8s?

How does Kubernetes handle auto-scaling (HPA vs. VPA vs. Cluster Autoscaler)?
What happens when a worker node fails?


How do you troubleshoot a pod stuck in CrashLoopBackOff?
How do you check the logs of a failing pod? (kubectl logs)
How do you debug networking issues inside a Kubernetes cluster?
1. Real-time Scenarios & Troubleshooting
✅ Scenario-based Questions

A pod is failing to start, how do you troubleshoot?
Your application is not accessible via Ingress, what steps will you take?
A pod is stuck in ‘Terminating’ state, how do you force delete it?
How do you upgrade a Kubernetes cluster without downtime?
Mock Interview Questions
How does Kubernetes handle service discovery?
How do you enforce security best practices in a Kubernetes environment?
What happens when you run kubectl delete pod <pod-name>?
How do you implement multi-tenancy in Kubernetes?
What are the different types of Kubernetes load balancers?


* what is on flow when kubectl apply is run 
* what is ingress what routing it done 
* how does kube proxy helps 
* what is kubelet do 
* default namespaces 
* explain of services 

Git 
----
* what is git merge vs git rebase 
* GIT semantics 
* how will you resolve merge conflicts 
* Branches stages 

Docker 
-------
* write docker file on install python 
* diff b/w COPY vs ADD 
* diff b/w CMD VS ENTERYPOINT 
* how to know ports on docker containers







interview qs
------------
* what is Dast? 
* how to secure the code 
* what is devops 5 pilers
* what is Devops 3 components
* how to integrated with DevSecOps tools on azure pipeline 
* what is Blue green deployment 
* what is Continuous Delivery vs Continuous Deployment  
* what is DevSecOps 
* what is shif left    
