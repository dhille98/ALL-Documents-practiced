# terraform 

* **terraform plugins**
    - provider
    - module
    - backend
    - provisionars 
### conseptes 
* terraform provider
* terraform resources 
* terraform work flow 
* terraform variables
    - input variables
    - output variables 
    - sensative version --> true
* terraform functions 
* terraform state file
* terraform remote backend
* terraform multi region deploy 
* terraform implicitly and explicitly
* terraform life cycle hooks 
    - create_before_destroy = true
    - prevent_destroy       = true
    - ignore_changes        = [tags, instance_type]
    - replace_triggered_by  = [aws_iam_role.example.name]
* terraform taints
* terrafom graph 
* terraform null_resources 
     - provisioners
     - file 
     - remote-exec
     - local-exec
     - trigger Terraform work-spaces 
* terraform import 
* terraform data sources
* terraform workspace 
* terraform modules 

**terraform most used commands**
```bash
    terraform init
    terraform fmt
    terraform validate
    terraform plan
    terraform apply 
    terraform destroy
    terraform state list
    terraform workspace list
    terraform workspace create
    terraform workspace select
    terraform taint 
    terraform apply --auto-aprove
    terraform apply --var-file='dev.tfvars'
    terraform validate 
    terraform inti --upgrading 
    terraform state rm 
    terraform destroy -target=aws_instance.example
    terraform apply -target=aws_instance.example
    terraform refresh
    terraform untaint <resource_type>.<resource_name>


```

* **terraform provider**
* take that provider version on 

```
- terraform provider version
		- =, !=, >, >= , < , < =, ~> 
  = Only the exact version 2.1.3 {version = 2.1.3}
  != means dont take on specific version take any version 
  > means take version more than {version > 3.28 }
  2.1 >= Any version 2.1 or higher 
  < means take version less than {version < 3.28} 
  2.1.3 <= Any version up to and including 2.1.3
  ~> means take on Allow minor version updates (patch and minor changes).
            Do not allow major version updates (which might introduce breaking changes) like on {version 3.28.0 to 3.28.9}
```
**terraform resources**
