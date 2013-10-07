class Fight
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :url

  validates_presence_of :url
  validates_format_of :url, :with => /http:\/\/www\.roswar\.ru\/fight\/(\d+)/i


  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end
end