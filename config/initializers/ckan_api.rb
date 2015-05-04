base_url = ENV.fetch('CKAN_BASE_URL') { "demo.ckan.org" }
CKAN::API.api_url = "http://#{ base_url }/api/3/"