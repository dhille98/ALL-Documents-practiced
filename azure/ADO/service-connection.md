# connecting two azure ADO to azure portial

- azure ci/cd tool connect on azure-cloud / AWS account to use azure service connection in this azure service connection 
- azure can talk to connecting to other add the service connection like (Docker-hub, Sonar-Scanner ..etc)

### connecting on azure portal 

* in azure ADO go to **service connection** 
* in this service connection select on **AZURE RESOURCE MANAGER**
* In AZURE RESOURCE MANAGER add the below arrgumnets 
        - Subscriptions id
        - subscription name
        - Tenat ID 
        - Service Principal Id 
        - Service Principal Key
after that we will go verify 

**Step-1**
* above cases in `Service Principal` Id 
* go to **Azure Entra ID** --> **App registrations** --> **New_registrations**
* after create a **App registrations** take the **service princepal id/Application (client) ID** and **Directory (tenant) ID**
* create a *Certificates & secrets* in App registrations --> take **value**

**Step-2**

* go to *Subscriptions* in this Subscriptions **Access control (IAM)** -->  **Role assignments** 
* add the `Contributor` role --> add `App registrations name ` and svae it 


after that configure in azure ADO above steps 