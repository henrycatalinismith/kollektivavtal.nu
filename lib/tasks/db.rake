namespace :db do
  desc "Download production database"
  task download: :environment do
    sh "fly sftp get /rails/storage/production.sqlite3"
    sh "fly sftp get /rails/storage/production.sqlite3-shm"
    sh "fly sftp get /rails/storage/production.sqlite3-wal"
    sh "mv production.sqlite3 storage/development.sqlite3"
    sh "mv production.sqlite3-shm storage/development.sqlite3-shm"
    sh "mv production.sqlite3-wal storage/development.sqlite3-wal"
  end
end
