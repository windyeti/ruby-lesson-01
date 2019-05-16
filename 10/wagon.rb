require_relative 'manufacturer/manufacturer'
require_relative 'attr_accessor/attr_accessor'
require_relative 'validation/validation'

class Wagon
  include Manufacturer
  include AttrAccesssor
  include Validation

  attr_reader :amount

  NOT_FREE = "Not free places!!!".freeze

  def initialize(amount)
    @amount = amount
    @places = 0
    validate!
    change_type
  end

  def change_type
    amount = amount.to_f
    places = places.to_f
  end

  def load_place(value = 1)
    raise NOT_FREE if value > free_places

    @places += value
  end

  def free_places
    @amount - @places
  end

  def not_free_places
    @places
  end
end
