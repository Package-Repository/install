#!/bin/bash

while true;
do
    read -p "Enter repo name: " repository
    git clone git@github.com:Package-Repository/$repository.git
done
