# Azure Container Registry (ACR)
**Azure Container Registry (ACR)** is a managed private registry service for Docker container images. It provides a secure and scalable environment to store, manage, and deploy container images. ACR is a fundamental component of the Azure cloud platform, offering features that streamline container-based application development and deployment.

**Use Cases:**

* **Container Image Storage:** Storing and managing Docker container images for your applications.
* **Continuous Integration/Continuous Deployment (CI/CD):** Integrating ACR into your CI/CD pipelines for automated image building and deployment.
* **Application Deployment:** Deploying containerized applications to various environments using ACR as the image repository.
* **Private Package Repository:** Storing and managing other types of packages (e.g., npm, NuGet) within ACR.

### lab set up on 

- create one linux vm 
- install docker on linux server
```
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    sudo usermod -aG docker <username>

```
- build the docker image on server 
```
    git clone https://github.com/mavrick202/dockertest1.git
```
- create docker file on above code 
```Dockerfile
FROM nginx:latest 
MAINTAINER mavrick202@gmail.com 
RUN apt install -y curl
COPY index.html /usr/share/nginx/html/
COPY scorekeeper.js /usr/share/nginx/html/
COPY style.css /usr/share/nginx/html/
#HEALTHCHECK CMD curl --fail http://localhost || exit 1
CMD ["nginx", "-g", "daemon off;"]
```
- build the docker image `docker image build -t test:1.0 .`
- after build is success fully excute the step on `docker images`

![Preview](/images/image-01.png)
- run the docker image on container 
```
    docker container run -d -P --name test test:1.0
```
![PreView](/images/image-02.png)


* create ACR in Azure name is *Create container registry*

![Perview](/images/image-03.png)

* createing the __container registry__
- checkthe bleow image
![Perview](/images/image-04.png)
* login into ACR container on where the docker image build the server
* docker login <acr-url>
* Enter the `username` and `password`
![Preview](/images/image-05.png)

* password click on  `Access keys` on azure container registry click `admin`

* docker image tag `docker tag <your-image> <your-acr-name>.azurecr.io/<your-image>:<tag>`
![Perview](/images/image-06.png)
* push the image on `docker push <your-acr-name>.azurecr.io/<your-image>:<tag>`
![Perview](/images/image-07.png)
![Perview](/images/image-08.png)