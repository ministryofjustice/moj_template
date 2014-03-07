#!/bin/sh

## Setup creds
# Rubygems
touch ~/.gem/credentials
chmod 0600 ~/.gem/credentials
echo "---" >> ~/.gem/credentials
echo ":rubygems_api_key: $RUBYGEMS_API_KEY" >> ~/.gem/credentials
# PiPy
touch ~/.pypirc
chmod 0600 ~/.pypirc
echo "[distutils]" >> ~/.pypirc
echo "index-servers =" >> ~/.pypirc
echo "    pypi" >> ~/.pypirc
echo "" >> ~/.pypirc
echo "[pypi]" >> ~/.pypirc
echo "username:$PYPI_USER" >> ~/.pypirc
echo "password:$PYPI_PASS" >> ~/.pypirc

# Run release command
bundle exec rake release