class PassengerWagon < Wagon
  validate :amount, :presence
  validate :amount, :type, Fixnum
  validate :amount, :format, /^[0-9]+$/

  def initialize(amount)
    @amount = amount.to_i
    @places = 0.to_i
    validate!
  end

  def load_place(_value = 1)
    super(1)
  end
end
