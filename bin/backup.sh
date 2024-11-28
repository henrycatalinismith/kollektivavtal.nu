#!/bin/bash

fly -a kollektivavtal sftp get /rails/storage/production.sqlite3
fly -a kollektivavtal sftp get /rails/storage/production.sqlite3-shm
fly -a kollektivavtal sftp get /rails/storage/production.sqlite3-wal

timestamp=$(date +"%Y%m%d.%H%M%S")
zip -r "kollektivavtal.db.${timestamp}.zip" production.sqlite3 production.sqlite3-shm production.sqlite3-wal

rm production.sqlite3
rm production.sqlite3-shm
rm production.sqlite3-wal

for zip_file in db.*.zip; do
  mv "$zip_file" "/Volumes/Samsung/kollektivavtal"
done

files=(/Volumes/Samsung/666a/*)
if [ ${#files[@]} -gt 4 ]; then
  oldest_file=$(ls -t /Volumes/Samsung/kollektivavtal/* | tail -1)
  rm "$oldest_file"
fi

