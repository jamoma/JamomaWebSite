#!/bin/sh

# $1 is the path
# $2 is the branch
# but we'll simply trigger an .sh in another folder

# touch it_worked
cd /Groups/Jamoma/Sites/JamomaWebSite
touch output/__hook/compiling.lock
( git pull && nanoc compile && rm -rf output/__hook/compiling.lock) > /dev/null &

#cd $1
#git pull origin $2
