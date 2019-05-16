require_relative 'attr_accessor/attr_accessor'
require_relative 'validation/validation'

class CargoTrain < Train
  include AttrAccesssor
  include Validation

  validate :number, :presence
  validate :number, :type, String
  validate :number, :format, /^[a-z0-9]{3}-?[a-z0-9]{2}$/i

  validate :manufacturer, :presence
  validate :manufacturer, :type, String
  validate :manufacturer, :format, /^[A-Z0-9]{1}[a-z0-9]+$/

  def initialize(number, manufacturer)
    super
  end

  def attachable_wagon?(wagon)
    wagon.is_a?(CargoWagon)
  end
end
