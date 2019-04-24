class Train
  attr_reader :speed, :wagons, :number

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
  end

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

  def increment_wagon
    @wagons += 1 if @speed == 0
  end

  def decrement_wagon
    @wagons -= 1 if @speed == 0 && wagons > 0
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

  def current_station
    @route.stations[@current_index_station]
  end

  def next_station
    @route.stations[@current_index_station + 1]
  end

  def previous_station
    @route.stations[@current_index_station - 1] if @current_index_station > 0``
  end
end
