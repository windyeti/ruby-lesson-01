class CargoTrain < Train
  def initialize(number)
    super
  end

  def add_wagon(wagon)
    return unless self.speed == 0
    return unless wagon.is_a?(CargoTrain)
    @wagons << wagon
  end
end
