# shell scripting -7
1. User Automation
2. CUT, GREP, AWK, TR, SHUF, HEAD, TAIL, FOLD
3. Slack API
4. Crontab
5. Memory Monitoring with Slack Integration.
6. Multi User Creation Automation


user creation automations 

check the user in systems 
	- cat /etc/passwd

creating RENDAM passwd in shell scripting

```sh
for I in {1..10}
do 
echo '!@#$%^&*()_' | fold -1 | shuf | head -1
done
```

user-automation.sh
```sh
#Take input a username and check if the user exists in the system or not.
#If the user exists, then display the user is exist in the system.
#If the user does not exist, create a user with the given username.
#Generate a random password for the user and display the username and password.
#Post ID and Password in slack channel.
#Force user to reset the password on the first login.

#!/bin/bash
SLACK_WEB='https://hooks.slack.com/services/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'
if [ $# -gt 0 ]; then
    USERNAME=$1
    EXISTING_USER=$(cat /etc/passwd | grep -i -w ${USERNAME} | cut -d ':' -f1)
    if [ "${USERNAME}" = "${EXISTING_USER}" ]; then
        echo "User ${USERNAME} already exists in the system."
    else
        echo "User ${USERNAME} does not exist in the system and creating the user...."
        useradd -m ${USERNAME} -s /bin/bash
        SPEC=$(echo '!@#$%^&*()_' | fold -1 | shuf | head -1)
        PASSWORD="India@${RANDOM}${SPEC}"
        echo "${USERNAME}:${PASSWORD}" | sudo chpasswd
        passwd -e ${USERNAME}
        #echo "Username: ${USERNAME} and Password: ${PASSWORD}"
        curl -X POST ${SLACK_WEB} -sL -H 'Content-type: application/json' --data "{"text": \"Username is: ${USERNAME}\"}" >>/dev/null
        curl -X POST ${SLACK_WEB} -sL -H 'Content-type: application/json' --data "{"text": \"Temporary Password Is: ${PASSWORD}  Reset This Password Immediatly.\"}" >>/dev/null
    fi
else
    echo "Please provide the username as an argument."
fi

```


USERNAME=$1
USER_EXISTS=cat /etc/passwd | grep -I -w ${USERNAME} | cut -d ":" -f1


monitoring in your system 
```sh
#!/bin/bash
SLACK_WEB='https://hooks.slack.com/services/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'
CURRENT_MEMORY=$(free -h | grep -i Mi | awk -F " " '{print $7}' | tr -d 'Mi')
if [ ${CURRENT_MEMORY} -le 500 ]; then
    curl -X POST ${SLACK_WEB} -sL -H 'Content-type: application/json' --data "{"text": \"Current Memory Utilization Is: ${CURRENT_MEMORY} Which Is Less Than 500MB.\"}" >>/dev/null
fi
```

 

crontab -l
crontab -e

create a multi user creation 

```sh
#!/bin/bash
set +x
SLACK_WEB='https://hooks.slack.com/services/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'
if [ $# -gt 0 ]; then
    for USERNAME in $@; do
        EXISTING_USER=$(cat /etc/passwd | grep -i -w ${USERNAME} | cut -d ':' -f1)
        if [ "${USERNAME}" = "${EXISTING_USER}" ]; then
            echo "User ${USERNAME} already exists in the system."
        else
            echo "User ${USERNAME} does not exist in the system and creating the user...."
            useradd -m ${USERNAME} -s /bin/bash
            SPEC=$(echo '!@#$%^&*()_' | fold -1 | shuf | head -1)
            PASSWORD="India@${RANDOM}${SPEC}"
            echo "${USERNAME}:${PASSWORD}" | sudo chpasswd
            passwd -e ${USERNAME}
            #echo "Username: ${USERNAME} and Password: ${PASSWORD}"
            curl -X POST ${SLACK_WEB} -sL -H 'Content-type: application/json' --data "{"text": \"Username is: ${USERNAME}\"}" >>/dev/null
            curl -X POST ${SLACK_WEB} -sL -H 'Content-type: application/json' --data "{"text": \"Temporary Password Is: ${PASSWORD}  Reset This Password Immediatly.\"}" >>/dev/null
        fi
    done
else
    echo "Please provide the username as an argument."
fi
```

