#!/usr/bin/env bash
gem install bundler \
  && bundle install --jobs 20 --retry 5 \
  && rake db:migrate \
  && rails server -b 0.0.0.0