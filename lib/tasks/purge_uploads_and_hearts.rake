namespace :purge do
  desc 'Purge Uploads and Hearts to simplify addition of Project model'
  task uploads_and_hearts: :environment do
    Heart.destroy_all
    ActiveRecord::Base.connection.execute("TRUNCATE hearts")

    Upload.destroy_all
    ActiveRecord::Base.connection.execute("TRUNCATE uploads")
  end
end
