#!/bin/bash

#Initial setup:
#git subtree add --prefix=public git@github.com:adrianmoya/adrianmoya.github.com.git master --squash
#git subtree pull --prefix=public git@github.com:adrianmoya/adrianmoya.github.com.git master --squash # to avoid merge conflicts

echo -e "\e[1m\e[7m\e[32mBuilding the project...\e[0m"
hugo

# Add changes to git.
echo -e "\e[1m\e[7m\e[32mCommitting updates to code branch...\e[0m"
git add -A

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin source

echo -e "\e[1m\e[7m\e[32mPushing the changes to master branch...\e[0m"
echo -e "\e[1m\e[7m\e[32mUpdating the website...\e[0m"

git subtree push --prefix=public git@github.com:adrianmoya/adrianmoya.github.com.git master
