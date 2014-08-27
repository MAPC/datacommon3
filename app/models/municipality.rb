class Municipality < GeometryModel
  default_scope { where("subunit_ids IS NULL").order(:name) }
end
