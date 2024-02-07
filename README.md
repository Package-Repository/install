# Install

This Repo is designed to help an environment get accustomed to the mechatronics software workflow. 

## Directories

- `install.sh` - Will add directory ~$HOME/ROBOT_LIB to computer for storage of robot related scripts
- `checkout.sh` - Will download appropriate package from the mechatronics github package repository
- `export.sh` - This can be sourced to export ROBOT_LIB to PATH and PYTHONPATH to run scripts from anywhere on the system

## Getting Started

Run these commands to set up your system with the mechatronics packages
    
    bash install.sh
    cat export.sh | tee -a ~/.bashrc > /dev/null

This will add ROBOT_LIB to your bashrc and create these first scripts.
Now you can use the checkout.sh command to see our github repos. 

