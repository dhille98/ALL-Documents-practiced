## k8s-deployment



in Kubernetes cluster control plane by default taints 

execute this command 

	# kubectl describe no <no-name>


ex: Taints:             node-role.kubernetes.io/control-plane:NoSchedule

create the deployment in impetrative commands
	# ku create deployment <name-dp> --image <> --replicas 3 --dry-run -o yaml --> generate the manifest  
	#  ku create deployment <name-dp> --image <> --replicas 3

* how many ways we can restart a container 

	# ku rollout history deployment <dep-name>
	# ku rollout undo deployment <dep-name>

* scale out 

	# ku scale deployment <app> -- replicaset 6

* difference between maxsurge and maxunavalabile 

* kubectl patch env  
	# kubectl set env RESOURCE/NAME KEY_1=VAL_1

* patch image 
	
in ymal file
 
---
spec:
  terminationGracePeriodSeconds: 30
  containers:
    - name: yoga
      image: dhillevajja/school:1.0
      imagePullPolicy: "Always"
---

 --> below command patch command
       # ku patch deployment <name-dp > --patch-file <path-file>
	   # ex: "ku patch deployment app1 --patch-file /tmp/patch.yml"

after pause the rollout 
	# ku rollout pause
cheking the port forwarding

	# ku rollout resume  


* set command line 
	# kubectl set image deployment/my-deployment mycontainer=myimage:latest

* in deployment mandatory to  "resources "
	--> limites --> in maxmum
	--> request --> set the base

* watch the pods 
	# watch -n 1 | kubectl get pod



deployment : 

kubectl set image deployment/my-deployment mycontainer=myimage:latest


