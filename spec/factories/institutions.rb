FactoryGirl.define do
  factory :institution do
    long_name  "Metropolitan Boston"
    short_name "Metro Boston"
    subdomain  "metroboston"

    logo_file_name    'a_logo_upload.png'
    logo_content_type 'image/png'
    logo_file_size     1024
    logo_updated_at    Time.now
  end

end
