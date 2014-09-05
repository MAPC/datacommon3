class Branding < ActiveRecord::Base
  belongs_to :institution

  def logos
    JSON.parse read_attribute(:logos)
  end

  def logo_count
    logos.length
  end

  alias_method :logo_length, :logo_count
end