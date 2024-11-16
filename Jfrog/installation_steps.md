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
