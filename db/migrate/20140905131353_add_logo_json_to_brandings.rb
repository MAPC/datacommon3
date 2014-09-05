class AddLogoJsonToBrandings < ActiveRecord::Migration
  def change
    add_column :brandings, :logos, :text, default: "[]"
  end
end
