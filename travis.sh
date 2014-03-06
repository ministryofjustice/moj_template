#!/bin/sh

if [ "$TRAVIS_BRANCH" == "travis" ]; then
  touch ~/.gem/credentials
  chmod 0600 ~/.gem/credentials
  echo "---" >> ~/.gem/credentials
  echo ":rubygems_api_key: $(RUBYGEMS)" >> ~/.gem/credentials
fi