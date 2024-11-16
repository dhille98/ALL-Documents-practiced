#!/bin/bash

command -v terraform
if test $? -eq 0; then
    echo 'terraform already installed'
else
    echo 'terraform is not installed'
fi
command -v $1 >>/dev/null
if [ $? -eq 0 ]; then
    echo "$1 Is Already Installed"
else
    echo "$1 is not installed"
fi


