## Sidecar Container

* types 
    --> main container 
    --> sidecar Container 
            1. init Container
            2. Adapter Container
            3. Ambassdar Container
# init container 
    * we can have multiple init containers in the pod
    * all init containers start and executation on squences and must complete
    * any dependices on main container we can configure the init container 
    * app container will start after completations of the all init containers
    * if init container fails main not start 

# adpter container:
   this excutaions on main contaners 


```
kubectl explain <kind-name> 

* check logs init container 
'ku logs <init-name>' -c <container-name> -f

ku run app1 --image nginx:latest 

ku expose pod app1 --port 80
```
## Q. what is init container vs adpter container


