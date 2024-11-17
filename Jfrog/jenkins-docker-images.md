## in Jenkins pipeline 

* install *jforg* plugin 
![Perview](../images/jf-09.png)
* set creadtional on *creadtional* section 
![perview](../images/jf-10.png)
* configure the *jenkins plugin* on systems
![perview](../images/jf-11.png)
* Configure JFrog CLI as a *Jenkins Tool*section 
![perview](../images/jf-12.png)

* write jenkin file 
```Jenkinsfile
pipeline {
	agent any
	tools {
		jfrog 'jfrog-cli'
	}
	environment {
		DOCKER_IMAGE_NAME = "dhilli.jfrog.io/<repo-name>/<image-name>"
	}
	stages {
		stage('Clone') {
			steps {
				git branch: 'master', url: "https://github.com/jfrog/project-examples.git"
			}
		}

		stage('Build Docker image') {
			steps {
				script {
					docker.build("$DOCKER_IMAGE_NAME", 'docker-oci-examples/docker-example')
				}
			}
		}

		stage('Scan and push image') {
			steps {
				dir('docker-oci-examples/docker-example/') {
					// Scan Docker image for vulnerabilities
					jf 'docker scan $DOCKER_IMAGE_NAME'

					// Push image to Artifactory
					jf 'docker push $DOCKER_IMAGE_NAME'
				}
			}
		}

		stage('Publish build info') {
			steps {
				jf 'rt build-publish'
			}
		}
	}
}
```

## docker image push on jfrog on manuvally

* excute this steps `docker login -u <name_of_jf_user>` 

![preview](../images/jf-13.png)
![perview](../images/jf-14.png)

* tag the docker image on blow the commands 
```sh
docker tag <IMAGE_ID> dhilli.jfrog.io/docker-hub-docker-local/<DOCKER_IMAGE>:<DOCKER_TAG>
docker push dhilli.jfrog.io/docker-hub-docker-local/<DOCKER_IMAGE>:<DOCKER_TAG>
```
![perview](../images/jf-15.png)

**Note:** you want to pull the docker image on jfrog repo 
* `docker pull <artifactory-url>/<repository-key>/<image-name>:<tag>` url means --> *dhilli.jforg.io*
* check the image in *artifact>>repo-name> image name*

![Perview](../images/jf-16.png)

### how to access on Kubernetes on jf account on docker images

* create a secret on k8s cluster 

```sh
kubectl create secret docker-registry regcred \
  --docker-server=<JFROG-HOSTNAME> \  # dhilli.jfrog.io
  --docker-username=<JFROG-USERNAME> \ 
  --docker-password=<PASSWORD> \  # create genaretive key
  --docker-email=<EMAIL> \ # optional
  --namespace=<NAMESPACE> # optional
```