class PassengerTrain < Train
  TYPE = "passenger"

  protected

  # так как пока нет наследников, а доступ к инициализвции извне вреден
  def initialize(number)
    super(number)
  end
end
