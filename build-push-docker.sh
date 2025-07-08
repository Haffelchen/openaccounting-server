#!/bin/bash

VERSION_FILE=".version"

if [ -z "$1" ]; then
  echo "You must specify the new version."
  exit 1
fi

if [ -z "$2" ]; then
  echo "You must specify the name."
  exit 1
fi

PACKAGE_NAME="$2"
NEW_VERSION="$1"

if [ -f "$VERSION_FILE" ]; then
  CURRENT_VERSION=$(sed -n '2p' "$VERSION_FILE")
else
  echo "Version file not found. Assuming no current version."
  CURRENT_VERSION="none"
fi

echo "Package name: $PACKAGE_NAME"
echo "Current version: $CURRENT_VERSION"
echo "New version: $NEW_VERSION"

echo -e "Harbor KTP Docker versioning\n$NEW_VERSION" > "$VERSION_FILE"

docker build -t harbor.kindle-techprojects.com/ktp-homelab/$PACKAGE_NAME:$NEW_VERSION .

docker tag harbor.kindle-techprojects.com/ktp-homelab/$PACKAGE_NAME:$NEW_VERSION \
  harbor.kindle-techprojects.com/ktp-homelab/$PACKAGE_NAME:latest

docker push harbor.kindle-techprojects.com/ktp-homelab/$PACKAGE_NAME:$NEW_VERSION
docker push harbor.kindle-techprojects.com/ktp-homelab/$PACKAGE_NAME:latest
