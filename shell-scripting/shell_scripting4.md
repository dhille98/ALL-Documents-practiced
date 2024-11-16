# shell scripting -4


1.output Redirection
  - options --->   >, >>, |, tee stdin, stout, stderr 
2.$?, $@, $*, $# what purpose of use this commands 

## output redirections 

* standard Input --> 0
* Standard Output --> 1
* Standard Error --> 2
* null file > /dev/null 

```sh
#!/bin/bash
uname -a
megastar
free -h
superstar
df -h
powerstar
cat /etc/passwd
```
we want redirect to erros in file use `2 means std erros`
	- ./shell.sh 2>dev/null
	- print only sucess fully commands 

we want redirect to successfully in use `1 means stdin`
	- ./shell.sh 1>dev/null
	- print only std errors


	- ./shell.sh 2>&1
redirect standard output and standard error to the same file if file is exiting the file was overwrite  
	- ./shell.sh > /dev/null 2>&1
Redirect Standard output and standard error to same file if is exiting append the data
	- ./shell.sh >> /dev/null 2>&1

* above cases in > used on store the output in file and if it is exiting overwrite the file
* use the >> exiting data append 

* standard output and standard ERROR and print on the console
	- ./shell.sh  | tee /tmp/file
#Redirect Standard Output and Standard Error to the same file. Existing data will be overwritten.
bash 2.demo_std.sh >/dev/null 2>&1

#Redirect Standard Output and Standard Error to the same file. Existing data will be appended.
bash 2.demo_std.sh >>/tmp/file1 2>&1

#Redirect Standard Output and Standard Error and print on the console, overwrite the file.
bash 2.demo_std.sh | tee /tmp/file1
bash 2.demo_std.sh 2>/dev/null | tee /tmp/file1
bash 2.demo_std.sh 1>/dev/null | tee /tmp/file1

#Redirect Standard Output and Standard Error and print on the console and append the file.
bash 2.demo_std.sh | tee -a /tmp/file1
bash 2.demo_std.sh 2>/dev/null | tee -a /tmp/file1

#Capturing IP & Port details from /var/log/auth.log
cat /var/log/auth.log | grep -i 'authenticating' | tee -a /tmp/log1
cat /tmp/log1 | cut -d ' ' -f13,15 >/tmp/ipdetails

cat /var/log/auth.log | grep -i 'authenticating' | cut -d ' ' -f13,15 >/tmp/ipdetails

bash Class-4/2.output_redirect_demo.sh 2>/tmp/hello1 | tee /tmp/hello2
  

## find logs 

cat /tmp/logs | cut -d ' ' -f13,f14

## output Redirects 

**$? - Exit code of last command**
**$@ & $* - All arguments passed to the script with spaces as separators.**
**"$*" - All arguments passed to the script as a single string.**
**$# - Number of arguments passed to the script.**
**$$ - Process ID of the current shell.**


## conditions in shell scripting 

```sh
#!/bin/bash
command -v terraform 
if test $? -eq 0: then
	echo 'terraform already installed'
else:
	echo 'terraform is not installed'
fi
command -v $1 >> /dev/null
if test $? -eq 0: then
	echo '$1 already installed'
else:
	echo '$1 is not installed'
fi
```
* pass the number of params use $1, $2, $3 .. $n
* pass the unlimited params use `$@ or $*`
*
```sh
#!/bin/bash

ITEM="$@"
echo "$ITEM"
command -v "$ITEM" >> /dev/null
if [ $? -eq 0 ]; then
    echo "$ITEM is already installed"
else
    echo "$ITEM is not installed"
fi



```
**Q. what is $@ vs $***

both are working on same way but when we give coats working on different ways 
when we give the quotes all arguments pass in singe variables  

**$@ vs $***
The main difference between $@ and $* in shell scripts is how they handle command-line arguments:
**$*-** treats all the arguments as a single string, separating them by the first character of the $IFS variable (which defaults to a space).
**$@** preserves the original structure of the arguments and treats each argument as a separate entity.
For example, if you run a script with the arguments "one two" "three four", then:
**"$*"** expands to "one two three four" (a single string)
**"$@"** expands to "one two" "three four" (two separate strings)
Key differences:
**$@** preserves the original number of arguments, while **$*-** collapses them into a single argument.
**"$@"** is the only form that can be used to access all the arguments separately within a loop or in a function call.
Using **"$@"** is safer and more flexible when working with command-line arguments because it preserves the original argument structure.

## counting params 
```sh
#!/bin/bash
echo "$# Arguments Passed To This Script."
if [ $# -gt 0 ]; then
    for ITEM in $@; do
        command -v $ITEM >>/dev/null
        if [ $? -eq 0 ]; then
            echo "$ITEM Is Already Installed"
        else
            echo "$ITEM is not installed"
        fi
    done
else
    echo "No Arguments Passed To This Script. Please provide at least one argument."
fi

```

## poke man API 

Q. print the poke man APIS on json format print on particular name