class PassengerTrain < Train
  def initialize(number)
    super
  end

  def add_wagon(wagon)
    return unless speed.zero?
    return unless wagon.is_a?(PassengerTrain)
    @wagons << wagon
  end
end
