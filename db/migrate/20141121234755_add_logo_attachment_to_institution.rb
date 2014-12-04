class AddLogoAttachmentToInstitution < ActiveRecord::Migration
  def up
    add_attachment :institutions, :logo

    i,v = Institution.find 1,2
    i.logo_file_name    = 'metro-boston.png'
    i.logo_content_type = 'image/png'
    i.logo_file_size    =  open(i.logo.url) { |f| f.read }.size
    i.logo_updated_at   =  Time.now
    i.save

    v.logo_file_name    = 'central-mass.png'
    v.logo_content_type = 'image/png'
    v.logo_file_size    =  open(i.logo.url) { |f| f.read }.size
    v.logo_updated_at   =  Time.now
    v.save
  end

  def down
    remove_attachment :institutions, :logo
  end
end
