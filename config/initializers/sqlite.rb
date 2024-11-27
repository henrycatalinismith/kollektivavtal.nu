require "sqlite_ulid"

puts "Listing contents of /rails/storage"
Dir.foreach(Rails.root.join("storage")) do |item|
  puts item
end
puts "End of listing contents of /rails/storage"

module UlidExtension
  def configure_connection
    super
    @raw_connection.enable_load_extension(true)
    SqliteUlid.load(@raw_connection)
    @raw_connection.enable_load_extension(false)
  end
end

ActiveSupport.on_load(:active_record_sqlite3adapter) do
  ActiveRecord::ConnectionAdapters::SQLite3Adapter.prepend(UlidExtension)
end

if !Rails.env.test?
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end
