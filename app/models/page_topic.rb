class PageTopic < ActiveHash::Base
  include ActiveHash::Associations

  # self.primary_key = :slug

  has_many :pages, foreign_key: :slug

  self.data = [
    {
      id:          1,
      title:      'About the DataCommon',
      slug:       'about',
      page_slugs: ["what-is", "faq", "tools", "partners", "contact"]
    },
    {
      id:          2,
      title:      'Resources',
      slug:       'resources',
      page_slugs: ["training-guides-tutorials", "data-resources", "user-profiles"]
    },
    {
      id:          3,
      title:      'Learning Community',
      slug:       'community',
      page_slugs: ["2009", "2012", "2013"]
    }
  ]

end
