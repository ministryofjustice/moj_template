#!/bin/sh

echo "Setting API Keys"

# Rubygems
touch ~/.gem/credentials
chmod 0600 ~/.gem/credentials
echo "---" >> ~/.gem/credentials
echo ":rubygems_api_key: $RUBYGEMS_API" >> ~/.gem/credentials

# PiPy
touch ~/.pypirc
chmod 0600 ~/.pypirc
echo "[distutils]" >> ~/.pypirc
echo "index-servers =" >> ~/.pypirc
echo "    pypi" >> ~/.pypirc
echo "" >> ~/.pypirc
echo "[pypi]" >> ~/.pypirc
echo "username:ministryofjustice" >> ~/.pypirc
echo "password:$PIPY_PASS" >> ~/.pypirc

# Github
git config credential.helper "store --file=.git/credentials"
echo "https://$GH_TOKEN:@github.com" > .git/credentials