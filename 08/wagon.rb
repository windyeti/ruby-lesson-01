require_relative 'manufacturer/manufacturer'

class Wagon
  include Manufacturer

  attr_reader :amount

  NOT_FREE = "Not free places!!!".freeze

  def initialize(amount)
    @amount = amount.to_f
    @places = 0.to_f
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
