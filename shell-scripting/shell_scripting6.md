# shell scripting -6
-> write terraform code
-> write shell scripting
-> k8s manifest
-> Jenkins/azure devops ymal pipeline starcher 
-> write a scripts inputs pass get and update other files 

1. find

Q,  how can I list the files which are changed last on week? 
Q. find the file between sizes 10mb to 50mb 
Q find the files gate then 50MB
Q find the file name certain pattern? 


## search the log files
	find /var/log -name *.log

	-mtime 7 --> last 7 days or mmin 5

	find <path> -name <file_name> <options>

## sizes 
 
check the disk usage of file --> `du -h`
	du -h <name_file>

find out the file sizes on more or less 

	find / -name *.zip -size +10M -size -30M
* find the sizes in xargs 
	find / -name *.zip -size +10M -size -30M | xargs du -h


write 

grep ^<start>
grep end$

```sh
cat /tmp/nginx.log | grep -i '404' | grep -i 'rebelstar' | cut -d " " -f1 | grep ^49 | grep 121$
cat /tmp/nginx.log | awk -F " " '{print $1,$9,$7}'

cat /tmp/nginx.log | awk -F " " '{print $1,$9,$7}' | tr " " "," | tr -d '/' > /tmp/data.csv

```

## what is tr 


 