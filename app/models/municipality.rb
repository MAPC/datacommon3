class Municipality < GeometryModel
  def self.default_scope
    where("subunit_ids IS NULL").order(:name)
  end
end
