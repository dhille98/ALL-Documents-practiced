### Steps to Push Docker Images to Docker Hub Using Jenkins
# 1. Prerequisites
1. **Install Docker on Jenkins Agent:** Ensure the Jenkins agent where the job will run has Docker installed and configured.

2. **Install Required Jenkins Plugins:**

  * **Docker Pipeline** plugin.
  * **Pipeline: Job** plugin.
3. Create Docker Hub Credentials in Jenkins:

Go to **Manage Jenkins > Manage Credentials**.
  * Add credentials with:
      - **Username:** Your Docker Hub username.
       - **Password:** Your Docker Hub password or personal access token.
       - Note the Credential ID (e.g., docker-hub-credentials).
4. **Prepare Your Dockerfile:** Ensure the project repository contains a `Dockerfile`.

## jenkins pipeline scripting 

```pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'your-dockerhub-username/your-image-name'
        IMAGE_TAG = 'latest'
        CREDENTIALS_ID = 'docker-hub-credentials' // Replace with your Jenkins Credential ID
    }
    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:${IMAGE_TAG}")
                }
            }
        }
        stage('Login to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('', CREDENTIALS_ID) {
                        echo 'Logged in to Docker Hub'
                    }
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.image("${DOCKER_IMAGE}:${IMAGE_TAG}").push()
                }
            }
        }
    }
    post {
        always {
            echo 'Cleaning up local Docker images...'
            sh "docker rmi ${DOCKER_IMAGE}:${IMAGE_TAG} || true"
        }
    }
}

```
## 3. Explanation of the Pipeline Script
**1. Environment Variables:**

  - **DOCKER_IMAGE:** The Docker image name in Docker Hub (username/repository-name).
  - **IMAGE_TAG:** The tag for your Docker image (e.g., latest).
  - **CREDENTIALS_ID:** The ID of your Docker Hub credentials in Jenkins.