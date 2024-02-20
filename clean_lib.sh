echo "Let's Start ROBOT_LIB From Scratch"

shopt -s extglob
rm -v $HOME/ROBOT_LIB/!("install.sh"|"checkout.sh"|"export.sh"|"see_lib.sh"|"clean_lib.sh")