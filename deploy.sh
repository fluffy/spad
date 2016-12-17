#!/bin/bash
set -e
set -x # debug 

USER=`git show --format="%aE" HEAD | head -1`

if [ "$USER" == "travis@example.org" -o "$TRAVIS_BRANCH" != "master" -o "$TRAVIS_PULL_REQUEST" != "false"  ]; then
    echo "skip deploy as not on master branch."
    exit 0
fi

# Save some useful information
REPO=`git config remote.origin.url`

git config user.name "Travis CI"

# add a timestampe to changes
echo  -n "Generate docs from github commit "  > docs/date.txt
git rev-parse --verify HEAD >> docs/date.txt
date >> docs/date.txt

# add the stuff to commit 
git add docs
git commit -m "Generate docs from deploy script"

# set up SSH 
openssl aes-256-cbc -K $encrypted_d39e10db38ff_key -iv $encrypted_d39e10db38ff_iv -in deploy_key.enc -out deploy_key -d
chmod go-rwx deploy_key
eval `ssh-agent -s`
ssh-add deploy_key

# Push the changes
git push ${REPO/https:\/\/github.com\//git@github.com:} HEAD:master





