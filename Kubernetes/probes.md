## probes 
-------

create deployment and services 
---
dell@instance-20240711-050432:~$ I=0
dell@instance-20240711-050432:~$ while true
> do
>  curl -sL http://34.173.9.220:32246/ | grep -i 'ip A'
> echo " the intertion is $I "
> I=$(( $I + 1 ))
> sleep 1s
> done
---
