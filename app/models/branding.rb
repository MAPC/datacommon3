class Branding < ActiveRecord::Base
  belongs_to :institution

  def logos
    JSON.parse read_attribute(:logos)
  end

  def logo_count
    logos? ? logos.length : 1
  end

  def logos?
    logos.presence
  end

  alias_method :logo_length, :logo_count
end