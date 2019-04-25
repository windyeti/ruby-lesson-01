class PassengerTrain < Train
  TYPE = "passenger"

  protected

  def initialize(number, wagons)
    super(number, wagons)
  end
end
