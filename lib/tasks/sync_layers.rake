namespace :ckan do
  desc "Upload layers from _geo* tables as CKAN DataProxy resources"
  task upload: :environment do
    CKANUpload::Activator.new(CKANUpload::DEFAULT_BASE_URL).perform
  end
end
