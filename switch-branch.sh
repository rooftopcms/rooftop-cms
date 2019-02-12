#!/bin/sh

if [[ "$1" == "" ]]
then
  echo "Specify a branch to switch to"
fi

echo "Switching to ${1}"

git checkout $1

current=`pwd`
cd public/web/app/mu-plugins/
for dir in rooftop-*/; do echo $dir && cd $dir && git checkout $1 ; cd .. ; done 
cd $current

cd public/web/app/mu-plugins/
for dir in rooftop-*/; do echo $dir && cd $dir && git checkout $1 ; cd .. ; done 
cd $current

cd public/web/app/themes/
for dir in rooftop-*/; do echo $dir && cd $dir && git checkout $1 ; cd .. ; done 
cd $current

