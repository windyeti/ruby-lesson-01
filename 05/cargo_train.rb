class CargoTrain < Train
  def initialize(number)
    super
  end

  def attachable_wagon?(wagon)
    wagon.is_a?(CargoWagon)
  end
end
