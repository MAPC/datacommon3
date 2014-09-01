class Subregion < GeometryModel
  def self.default_scope
    where("subunit_ids IS NOT NULL").order(:name)
  end
end
