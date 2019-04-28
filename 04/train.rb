class Train
  attr_reader :number, :route, :wagons

  def initialize(number)
    @number = number
    @wagons = []
  end

  def delete_wagon
    @wagons.pop
  end

  def route=(route)
    current_station.delete_train(self) unless @route.nil?
    @current_index_station = 0
    @route = route
    current_station.add_train(self)
  end

  def to_next_station
    return if next_station.nil?
    current_station.delete_train(self)
    next_station.add_train(self)
    @current_index_station += 1
  end

  def to_previous_station
    return if previous_station.nil?
    current_station.delete_train(self)
    previous_station.add_train(self)
    @current_index_station -= 1
  end

  protected
  # эти методы используются наследниками внутри классов для премещения по станциям,
  # но нигде не вызываются вне классов
  def current_station
    @route.stations[@current_index_station]
  end

  def next_station
    @route.stations[@current_index_station + 1]
  end

  def previous_station
    @route.stations[@current_index_station - 1] if @current_index_station > 0
  end

  private

  # изменение speed и количества вагонов делается другими методами,
  # то есть обращение speed напрямую из других мест не востребованно
  # в рамках этого задания

  attr_reader :speed

  def speed_up(speed)
    @speed += speed
  end

  def speed_down(speed)
    @speed -= speed
    @speed = 0 if @speed < 0
  end

  def stop
    @speed = 0
  end

end
