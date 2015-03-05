class AddActiveToIssueAreas < ActiveRecord::Migration
  def change
    add_column :mbdc_topic, :active, :boolean, null: false, default: false
  end
end
