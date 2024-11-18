### Jfrog server free congiureations urls 

[Jfrog installations steps](https://jfrog.com/start-free/install/) 

![perview](../images/jf-01.png)

```sh
    # 1. Download the installer
    wget -O jfrog-deb-installer.tar.gz "https://releases.jfrog.io/artifactory/jfrog-prox/org/artifactory/pro/deb/jfrog-platform-trial-prox/[RELEASE]/jfrog-platform-trial-prox-[RELEASE]-deb.tar.gz"

    # 2. Extract it
    tar -xvzf jfrog-deb-installer.tar.gz

    # 3.CD into directory
    cd jfrog-platform-trial-pro*

    # 4.Run the installer
    sudo ./install.sh

    # 5. Start Artifactory
    sudo systemctl start artifactory.service

    # 6. Start Xray
    sudo systemctl start xray.service

    # 7. Open your browser and go to:
    http://localhost:8082/
```

### create the jforg account deploy the jar/war file 
login that jforg account 
```
set up maven 
 libs-release-local 
  set me up 
 	* configure
	--> genarets token 
 	--> take that setting.xml file
		--> add user 
		--> add token
		--> copy that .m2 folder setting.xml file
	* deploy 
	copy the continent on pox.xml
		-->  add on properties section below and distribution Management above 
```

* create the jforg account and login [login](https://dhilli.jfrog.io/ui/login/)

* create the jfog account 
* step of the artifactory repo
* go to on `artifacts `
![perview](../images/jf-03.png)
* genarete the token on `set up me`
![perview](../images/jf-04.png)
![perview](../images/jf-05.png)
* copy the file on .m2/setting.xml file
![perview](../images/jf-02.png)
* copy the file on pom.xml file 
![perview](../images/jf-06.png)

## maven application deploy 
* frist type command `mvn install` 
* creates the `.m2` folder on home directory 
* create the a `settings.xml` file on dir and modify the `pom.xml` file on 
* enter the command on `mvn deploy`
![perview](../images/jf-07.png)
* check the aritifacts on 
![perview](../images/jf-08.png)

## Deploy the application JAR File INTO JFROG using Jenkins pipeline 

### Method 1: Using Secret File Credentials in Jenkins Pipeline
**1.Store the `settings.xml` file as a Secret File in Jenkins:**

  - Go to **Jenkins Dashboard > Manage Jenkins > Manage Credentials**.
  - Choose the appropriate domain (or create one if needed).
  - Click on **Add Credentials**.
  - Select **Secret file** as the type and upload your `settings.xml` file. Give it an ID like `maven-settings-file`.
**2.Copy the File to the Node in the Jenkins Pipeline:**

  - Use the withCredentials block to access the `settings.xml` file and copy it to the desired location on the node.
```Jenkinsfile
pipeline{
    agent any
    triggers {
        pollSCM('* * * * *') // Polls every 15 minutes
    }

    environment {
        MAVEN_SETTINGS_CRED_ID = 'maven-settings-file'  // Replace with your credential ID
    }
    
    
    stages{
        stage( 'git' ) {
            steps{
                git url :' https://github.com/dhille98/spring-petclinic.git ',
                  branch: 'pod'
            }
        }
         stage('build') {
             steps {
                 sh "mvn clean package"
                 archiveArtifacts artifacts: '**/spring-petclinic-*.jar'
                 junit testResults: '**/TEST-*.xml'
             }  
         }

        stage('Copy settings.xml') {
            steps {
                withCredentials([file(credentialsId: "${MAVEN_SETTINGS_CRED_ID}", variable: 'SETTINGS_FILE')]) {
                    // Copy to .m2 directory on the node
                    sh 'mkdir -p ~/.m2'
                    sh 'cp $SETTINGS_FILE ~/.m2/settings.xml || exit 1'
                }
            }
        }
        stage('deploythe-artifacts-jforg'){
            steps{
                sh 'mvn clean deploy -Dskiptest'
            }
        }
    }
        
 }


```
**Explanation:**

* **withCredentials:** Provides secure, temporary access to `settings.xml` as **SETTINGS_FILE**.
* **`sh 'cp $SETTINGS_FILE ~/.m2/settings.xml':`** Copies the `settings.xml` to the `.m2` folder in the user’s home directory on the node.