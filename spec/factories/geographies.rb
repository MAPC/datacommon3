FactoryGirl.define do

  factory :geography do
    name   Faker::Address.city
    unitid Faker::Number.number(2).to_s
    slug   { name.parameterize }
    regiontype_id  1
    type           'municipality'
    subunit_ids    nil
    institution_id 1

    trait :municipality do
      type 'municipality'
      subunit_ids nil
      regiontype_id  1
    end

    trait :subregion do
      name Faker::Address.city << " Region"
      type 'subregion'
      subunit_ids "1,2,3"
      regiontype_id  1
    end
    
    geometry RGeo::WKRep::WKTParser.new.parse("MULTIPOLYGON (((208390.5036000015 919542.8108999318, 208914.37359999606 917369.8708999272, 209453.31360000014 917111.0608999254, 202949.86359999914 911098.5008999294, 200111.34359999766 912575.690899934, 202175.87359999868 916626.6208999326, 204607.11360000307 917612.6908999231, 205341.7835999996 919067.8108999297, 205883.54359999654 919810.6908999205, 206264.93359999807 919518.940899927, 208257.29360000146 920384.120899922, 208390.5036000015 919542.8108999318)))")
    short_desc Faker::Lorem.sentence(40)
    short_desc_markup_type "html"
    _short_desc_rendered { short_desc }

    factory :municipality, traits: [:municipality]
    factory :subregion,    traits: [:subregion]
  end
end
