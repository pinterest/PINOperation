#!/bin/bash
set -ex

echo "Tagging release branch"
TAG=v$(echo "$BRANCH" | sed 's/release-//')

echo "RELEASE_TAG=$TAG" >> $GITHUB_ENV
git tag $TAG
git push origin --tags

echo "Setting Release Notes"
cat CHANGELOG.md | awk '/^#/{f=1} f; /^#/ && ++c==3{exit}' | sed '$ d' > RELEASE_NOTES.md
