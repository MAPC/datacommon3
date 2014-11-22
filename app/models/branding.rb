class Branding < ActiveRecord::Base
  belongs_to :institution

  def logos
    JSON.parse read_attribute(:logos)
  end

  def logos?
    logos.presence
  end
end