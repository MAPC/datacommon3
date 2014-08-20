class Page < ActiveHash::Base
  include ActiveHash::Associations

  belongs_to :institution

  self.data = [
    { 
      id: 1,
      institution_id: 1,
      content: "<h2>MBDC</h2> Some kinda...page thing<hr><em>i think metroboston owns me</em>"
    },
    { 
      id: 2,
      institution_id: 2,
      content: "<h2>CMRPC</h2> Some kinda...page thing<hr><em>i think centralmass owns me</em>"
    }
  ]
end
