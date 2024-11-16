# shell scripting -5
-------------------
**1. Data Operators**
**2. Logical Operators**
**3. Comparison Operators**
**5. grep & awk**
**6. how to pars logs based on above commands**


    - grep -I -n | wc -l

    - grep -v | wc -l

* Multipul events in the CloudTrail logs
	- egrep nam1|name2 or grep -E name1|name2


### Data  Operators 
Additions
Subtraction
Multiplication 
modules 

any inputs on pass shell scripting's

read -p "Enter a number: " num 


Scripting runs multipool time 

### example-1: 
```sh
for I in {1..10}; 
do 
echo $I
done
```
### example-2:
```sh
    I=0
    while [$I -lt 10 ]
    do
    echo $I
    I=$(($I+1))
    done
```
* referhere cls room notes on day-5

```
root@shellscripting:/tmp# cat auth.json | jq ".Records[].eventName" -r | grep -i AssumeRole | wc -l
26
root@shellscripting:/tmp# cat auth.json | jq ".Records[].eventName" -r | grep -i -v AssumeRole | wc -l
50
root@shellscripting:/tmp# cat auth.json | jq ".Records[].eventName" -r | grep -i -n AssumeRole | wc -l
26
root@shellscripting:/tmp# cat auth.json | jq ".Records[].eventName" -r | grep -i -n AssumeRole
```
 
* challenge in grep or awk 
* below cases find the diffrence on cut vs awk 
```sh
root@shellscripting:~# cat /etc/passwd | grep -i demouser | cut -d ":" -f6
/home/demouser-1
/home/demouser-2
/home/demouser-3
/home/demouser-4
/home/demouser-5
root@shellscripting:~# cat /etc/passwd | grep -i demouser | cut -d ":" -f6 -f5
cut: only one type of list may be specified
Try 'cut --help' for more information.
root@shellscripting:~# cat /etc/passwd | grep -i demouser | cut -d ":" -f6 -f7
cut: only one type of list may be specified
Try 'cut --help' for more information.
```
```sh
root@shellscripting:~# cat /etc/passwd | grep -i demouser | awk -F : '{print $6}'
/home/demouser-1
/home/demouser-2
/home/demouser-3
/home/demouser-4
/home/demouser-5
root@shellscripting:~# cat /etc/passwd | grep -i demouser | awk -F : '{print $6 $7}'
/home/demouser-1/bin/bash
/home/demouser-2/bin/bash
/home/demouser-3/bin/bash
/home/demouser-4/bin/bash
/home/demouser-5/bin/bash
root@shellscripting:~# cat /etc/passwd | grep -i demouser | awk -F : '{print $7 $6}'
/bin/bash/home/demouser-1
/bin/bash/home/demouser-2
/bin/bash/home/demouser-3
/bin/bash/home/demouser-4
/bin/bash/home/demouser-5
```

```
    cat /etc/passwd | grep -I user | cut -d ":" -f6,1

    cat /etc/passwd | grep -I user | awk -F ':' '{print $1 $7}'
```

## cut vs awk

**Overview**
**cut:**
A simple utility designed specifically to extract sections from each line of input based on specified delimiters or byte positions.
It is generally faster for straightforward tasks due to its focused functionality.
**awk:**
A full-fledged programming language designed for pattern scanning and processing. It can perform complex text manipulations, calculations, and control structures.
More versatile than cut, allowing for advanced data processing and scripting capabilities.

**conclusion:**
    - types of data types 
    - how to use data types 
    - how to retrive information on json formate or logs
    - using grep or awk commands 
    - writing a scripting useing data types 