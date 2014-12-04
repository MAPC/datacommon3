class AddPermissionToVisualizations < ActiveRecord::Migration
  def up
    add_column :weave_visualization, :permission, :string, default: "private"
    
    Visualization.unscoped.find_each do |v|
      query = <<-ENDSQL
        SELECT COUNT(*) 
        FROM core_genericobjectrolemapping
          WHERE role_id = 7 AND object_id = #{v.id}
      ENDSQL
      
      result = ActiveRecord::Base.connection.execute(query)
      count  = result.map {|r| r['count']}.first.to_i

      v.update_attribute(:permission, "public") if count == 2
    end
  end

  def down
    remove_column :weave_visualization, :permission
  end
end
