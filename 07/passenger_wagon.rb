class PassengerWagon < Wagon
  def initialize(amount)
    @amount = amount.to_i
    @places = 0.to_i
  end
  def load_place(value = 1)
    super(1)
  end

end
