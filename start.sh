#!/bin/bash

cd /home/app
rails db:setup
rails db:migrate
bundle exec rake tracker:import_data['bustracker.csv']
rails server
