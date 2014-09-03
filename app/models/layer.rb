class Layer < ActiveRecord::Base
  belongs_to :institution
  self.primary_key = :title

  def self.default_scope
    order(:title)
  end

  include InstitutionScope

  def description
    read_attribute(:descriptn)
  end

  alias_method :desc, :description

  paginates_per 8

  def to_param
    tablename
  end

  def to_s
    title
  end
  
end

