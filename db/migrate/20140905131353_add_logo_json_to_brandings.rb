class AddLogoJsonToBrandings < ActiveRecord::Migration
  def up
    add_column :brandings, :logos, :text, default: "[]"

    Branding.find(1).update_attribute(:logos, "[{\"src\":\"http://metrobostondatacommon.org/media/mbdc/img/logo-indicators.png\",\"alt\":\"The Boston Indicators Project\"},{\"src\":\"http://www.mapc.org/sites/default/files/mapc_logo.png\",\"alt\":\"MAPC\"},{\"src\":\"http://metrobostondatacommon.org/media/mbdc/img/logo-tbf.png\",\"alt\":\"The Boston Foundation\"}]")
    Branding.find(2).update_attribute(:logos, "[{\"src\":\"logos/cmrpc.png\",\"alt\":\"Central Massachusetts Regional Planning Commission\"},{\"src\":\"logos/montachusett.png\",\"alt\":\"Montachusett Regional Planning Commission\"},{\"src\":\"http://www.mapc.org/sites/default/files/mapc_logo.png\",\"alt\":\"MAPC\"},{\"src\":\"http://media-cache-ec0.pinimg.com/736x/63/bb/3f/63bb3f075abae4db6308f9ad707777be.jpg\",\"alt\":\"The Boston Foundation\"}]")
  end

  def down
    remove_column :brandings, :logos
  end
end
