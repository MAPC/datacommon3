class Layer < ActiveRecord::Base
  belongs_to :institution

  def self.default_scope
    order(:title)
  end

  include InstitutionScope

  def description
    read_attribute(:descriptn).titleize
  end

  alias_method :desc, :description

  paginates_per 8

  def to_param
    title.parameterize
  end
  
end

