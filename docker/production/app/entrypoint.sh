#!/bin/ash
set -e

cmd="$@"

# PostgreSQL の準備完了後まで待機
count=$(($count+1))
until nc -z $POSTGRES_HOST 5432; do
  echo "PostgreSQL is unavailable - sleeping"
  test $count -ge 30 && exit 1
  sleep 1
  let count++
done

bin/rails db:prepare
bin/rails assets:precompile

exec $cmd
