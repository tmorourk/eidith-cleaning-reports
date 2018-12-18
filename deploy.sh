#!/bin/sh

set -e
set -x

# Set git config information
git config --global user.name "Noam Ross (Travis-CI)"
git config --global user.email "ross@ecohealthalliance.org"

# Clone the gh-pages repository
git clone -b outputs \
  https://${GITHUB_PAT}@github.com/${CIRCLE_PROJECT_USERNAME}/${CIRCLE_PROJECT_REPONAME}.git \
  to_deploy

# Change to the gh-page clone book-output directory
cd to_deploy

# Copy generated output to the deploy directory
cp -r ../outputs/* ./

# Add all files to the repo
git add *
git commit  --no-verify -a -m "Auto-generated outputs (${CIRCLE_BUILD_NUM})" || true
git push -q origin gh-pages
