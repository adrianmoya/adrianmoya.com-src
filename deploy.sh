#!/bin/bash

#Check state of the repo
PENDING=`git diff --cached --numstat | wc -l`
if [ $PENDING -ne 0 ];
then
  echo -e "\033[0;31mYou have pending changes, please commit them before deploying\033[0m"
  exit 1
fi

# Go To Public folder
cd public

#If not on master branch, switch to master branch
CURRENT_BRANCH=`git rev-parse --abbrev-ref HEAD`
if [ $CURRENT_BRANCH -ne "master" ]
then
  git checkout master
fi

# Update public to latest version deployed
echo -e "\033[0;32mPulling latest version of site from GitHub...\033[0m"
git pull origin master

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Add changes to git.
git add -A

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master

# Come Back
cd ..

# Add new version of public to source
echo -e "\033[0;32mUpdating public submodule reference on source repo\033[0m"
git add public
git commit -m "Updating public submodule to latest commit"
git push origin master
