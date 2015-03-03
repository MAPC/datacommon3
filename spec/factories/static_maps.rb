FactoryGirl.define do
  factory :map, class: StaticMap do
    title 'Map title'
    abstract 'A long enough abstract, I hope.'
    month 1
    year  2015
    map_file_name    'a_map_upload.pdf'
    map_content_type 'application/pdf'
    map_file_size     1024
    map_updated_at    Time.now
    institution_id    1
    pdf_page          'legacy_pdf_location.pdf'
    thumbnail         'thumbnail/path'

    factory :map_without_attachment do
      map_file_name    nil
      map_content_type nil
      map_file_size    nil
      map_updated_at   nil
    end
  end
end
