#!/bin/sh
if [ -f "test/dummy/tmp/pids/server.pid" ]; then
  rm -f test/dummy/tmp/pids/server.pid
fi

if [ -f "Gemfile" ]; then
  bundle install --quiet
  bundle exec rake app:log:clear
  bundle exec rake app:tmp:clear
  bundle exec rake app:db:migrate
  bundle exec rake app:about
  bundle exec rails s -b 0.0.0.0
fi

exec "$@"
