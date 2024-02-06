#!/bin/bash

# @Zix Checkout Script to Easily Download Mechatronics Code

PACKAGE_REPO="https://github.com/Package-Repository"

check_jq_install()
{
    if ! command -v jq &> /dev/null; then
    echo "Error: jq is not installed. Please install jq to run this script."
    exit 1
    fi
}

get_repo_names()
{
    ORG_NAME="Package-Repository"
    response=$(curl -s "https://api.github.com/orgs/$ORG_NAME/repos")
    repo_names=$(echo "$response" | jq -r '.[].name')
    echo "$repo_names"
}

tool_introduction() 
{
    echo "Hello! Welcome to the Mechatronics checkout tool! This is meant to help you download the package(s) you would like to utilize on the robot"
    echo "Here is the list of available packages"
    get_repo_names
}

get_repo_loop()
{
    while true;
    do
        echo "Enter repo name: " 
        read REPOSITORY
        if [ $? -eq 0 ]; then
            git clone $PACKAGE_REPO/$REPOSITORY.git
            install.sh
        else
            echo "Error: Cloning repository failed."
        fi
    done
}

handle_all_flag()
{
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -a|--all)
                REPOS=($repo_names)
                for REPO in $REPOS; do
                    git clone $PACKAGE_REPO/$REPO.git
                    install.sh
                done
                exit 0
                ;;
        esac
        shift
    done
}

main()
{
    tool_introduction
    get_repo_loop
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi