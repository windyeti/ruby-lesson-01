class PassengerWagon < Wagon
  validate :amount, :presence
  validate :amount, :type, Fixnum
  validate :amount, :format, /^[0-9]+$/

  def initialize(amount)
    @amount = amount
    @places = 0
    validate!
    change_type
  end

  def change_type
    amount = amount.to_i
    places = places.to_i
  end
  def load_place(_value = 1)
    super(1)
  end
end
