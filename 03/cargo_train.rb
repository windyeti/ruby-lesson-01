class CargoTrain < Train
  TYPE = "cargo"

  private
  # так как пока нет наследников, а доступ к инициализвции извне вреден
  def initialize(number, wagons)
    super(number, wagons)
  end
end
