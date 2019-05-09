require_relative 'manufacturer/manufacturer'

class Wagon
  include Manufacturer

  attr_reader :amount

  NOT_FREE = "Not free places!!!"

  def initialize(amount)
    @amount = amount
    @places = 0.to_f
  end

  def load_place(value = 1)
    return if @places + value > @amount
    @places += value
  end

  def free_places
    @amount - @places
  end

  def not_free_places
    @places
  end
end
