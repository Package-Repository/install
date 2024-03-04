#!/bin/bash

# @Zix Checkout Script to Easily Download Mechatronics Code
# DEPENDENCIES: Assumes you have a script called install.sh on computer as well as a json parsing package called jq for the github request
# The script should hopefully handle the cases where these dependencies aren't met

PACKAGE_REPO="https://github.com/Package-Repository"
JSON_PARSE_PACKAGE="jq" # DEPENDENCY

check_install_script_exists()
{
    if [ -e "$SCRIPT_PATH" ]; then
        echo "install.sh exists, continuing..."
    else
        echo "install.sh does not exist"
        exit 0
    fi
}

# Use this to install dependency jq
install_package()
{
    if ! dpkg -l | grep -qw $1; then
        echo "$1 is not installed. Installing..."
        sudo apt-get update
        sudo apt-get install -y $1
    else
        echo "$1 is already installed; continuing."
    fi
}

# Uses Github API to get names of our packages
get_repo_names()
{
    ORG_NAME="Package-Repository"
    response=$(curl -s "https://api.github.com/orgs/$ORG_NAME/repos")
    repo_names=$(echo "$response" | jq -r '.[].name')
    echo "$repo_names"
}

tool_introduction() 
{
    echo -e "\n"
    echo -e "Hello! Welcome to the Mechatronics checkout tool! This is meant to help you download the package(s) you would like to utilize on the robot. \n"
    echo -e "If you want to download all packages run this script with this format checkout.sh -a \n"
    echo -e "Remember you can press q to quit at any time. Here is the list of available packages: \n"
    echo "------------------------------------------"
    get_repo_names
    echo -e "\n"
}

get_repo_loop()
{
    while true;
    do
        echo -e "\n Enter the name of a package you would like to download to this computer: " 
        read REPOSITORY
        status=$? 
        if [ $REPOSITORY == 'q' ]; then
            break
        elif [ $status -eq 0 ]; then
            git clone $PACKAGE_REPO/$REPOSITORY.git --recurse-submodules
            install.sh
        else
            echo "Error: Cloning repository failed."
        fi
    done
}

# Script should download all packages when called like this checkout.sh -a
handle_a_flag()
{
    REPOS=($(get_repo_names))
    for REPO in "${REPOS[@]}"; do
        git clone "$PACKAGE_REPO/$REPO.git" --recurse-submodules
        install.sh
    done
    exit 0
}

main()
{
    install_package $JSON_PARSE_PACKAGE
    while [[ $# -gt 0 ]]; do
        case "$1" in -a|--all)
            handle_a_flag 
        esac
        shift
    done
    tool_introduction
    get_repo_loop
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi