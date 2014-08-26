# #snapshots returns an array of one DynamicVisualization
# for each topic in IssueArea.all

class SnapshotFacade

  attr_accessor :snapshots

  def initialize(geography)
    DynamicVisualization.find_by(regiontype_id: geography.regiontype_id)
  end

end