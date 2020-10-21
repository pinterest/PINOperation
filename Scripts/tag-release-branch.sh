#!/bin/bash
set -e

BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ $(echo "$BRANCH" | sed -E 's/release-[0-9]+\.[0-9]+\.[0-9]/true/') != "true" ]; then
    echo "Bad release branch"
    exit 1
fi

echo "Tagging release branch"
TAG=v$(echo "$BRANCH" | sed 's/release-//')
echo "RELEASE_TAG=$TAG" >> $GITHUB_ENV
git tag "$TAG"
git push origin --tags

echo "Merging release branch into master"
git checkout master
git pull --rebase origin master
git merge "$BRANCH"
git push origin master

echo "Deleting release branch"
git branch -d "$BRANCH"
git push origin --delete "$BRANCH"

echo "Setting changelog"
CHANGELOG=$(cat CHANGELOG.md | awk '/^#/{f=1} f; /^#/ && ++c==3{exit}' | sed '$ d')
echo "CHANGELOG=$CHANGELOG" >> $GITHUB_ENV
