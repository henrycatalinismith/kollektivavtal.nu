namespace :db do
  desc "Download production database"
  task download: :environment do
    sh "gsutil cp -r 'gs://kollektivavtal-private/production.sqlite3' storage/development.sqlite3"
    sh "gsutil cp -r 'gs://kollektivavtal-private/production.sqlite3-wal' storage/development.sqlite3-wal"
    sh "gsutil cp -r 'gs://kollektivavtal-private/production.sqlite3-shm' storage/development.sqlite3-shm"
  end
end
