class PassengerTrain < Train
  def initialize(number, manufacturer)
    super
  end

  def attachable_wagon?(wagon)
    wagon.is_a?(PassengerWagon)
  end
end
