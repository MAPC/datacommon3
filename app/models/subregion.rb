class Subregion < GeometryModel
  default_scope { where("subunit_ids IS NOT NULL").order(:name) }
end
