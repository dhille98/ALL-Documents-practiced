## stateful set
-------------
##############Features Of StatefullSet##############
1. K8S StatefulSets are used to manage stateful applications like databases.
2. StatefulSets have a unique identity/name for each pod.
3. It follows ordinal indexing for each pod like mysql-0, mysql-1, mysql-2.
4. StatefulSets start in a sequential order.
5. StatefulSets assigned same volumes after restart.
6. StatefulSets gets the same IP address after restart.
7. StatefulSets gets the same name after restart. 

###############################TESTING-MONGO#######################
1. Deploy the manifest.
2. Also deploy a UTILS pods using the following command.
kubectl run utils --image sreeharshav/utils:latest
3. Exec in to the UTILS pod and perform nslookup mongodb.

------------