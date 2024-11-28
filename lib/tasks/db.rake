namespace :db do
  desc "Download production database"
  task download: :environment do
    files = {
      "production.sqlite3" => "development.sqlite3",
      "production.sqlite3-wal" => "development.sqlite3-wal",
      "production.sqlite3-shm" => "development.sqlite3-shm"
    }
    files.each do |source, destination|
      exists = system("gsutil ls 'gs://kollektivavtal-private/#{source}'")
      if exists
        sh "gsutil cp -r 'gs://kollektivavtal-private/#{source}' storage/#{destination}"
      end
    end
  end
end
