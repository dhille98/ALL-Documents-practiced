# VNG Set up on azure 
creating on vnet on subnet name is gateway subnet 


step-1:

- create a vng 
![perview](images/image-1.png)
- create a monitor --> Diagnostic settings --> select on all logs 
![perview](images/image-2.png)
- create a log anlatics 
![perview](images/image-3.png)
  
## aws create vpc 
step-2
- create vpc on aws and subnets 
![perview](images/image-4.png) 
- launch window server on aws 

- and install ad on that windows server
```powershell
ipconfig
ipconfig/all
ncpa.cpl
firewall.cpl

``` 


step-3

* create custmore gateway
![perview](images/image-5.png) 


* create a VPG on aws 
* ![perview](images/image-6.png)
* set up on vpn conncetions on site to site 
* create on site to site connection
* ![perview](images/image-7.png)
* download the configurations 


step-3

create vms on azure on windows servers 
```powershell
ipconfig
ipconfig/all
ncpa.cpl
firewall.cpl

``` 

step-4

* create a local netwok gate way 
* ![Perview](images/image-8.png)
* BEST pritice two lng setup 

goto on vng on connections 

![perview](images/image-9.png)

![perview](images/image-10.png)
* edit the routing table in in aws add the azure vnet work address
* ![perview](images/image-11.png)

* every thing was correctly configured two tunnels are up 
  ![perview](images/image-12.png)
  ![perview](images/image-13.png)
* after set up on azure 
* check the firewall status
* after the `sysdm.cpl` chenge to workgroup to domain


  