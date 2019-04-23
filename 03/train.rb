class Train
  attr_reader :speed, :wagons, :number

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
  end

  def speed_up
    self.speed += 5
  end

  def speed_down
    self.speed -= 5
    self.speed = 0 if speed < 0
  end

  def stop
    self.speed = 0
  end

  def go
    self.speed = 5
    @route.stations.each { |station| station.trains.delete(self) }
  end

  def increment_wagon
    @wagons += 1 if speed == 0
  end

  def decrement_wagon
    @wagons -= 1 if speed == 0 && wagons > 0
  end

  def route=(route)
    @route = route
    @current_index_station = 0
    to_start_station(self)
  end

  def to_start_station(train)
    @route.stations.each { |station| station.trains.delete(train) }
    @route.stations[0].add_train(train)
  end

  def to_next_station
    unless @route.stations[@current_index_station + 1].nil?
      p @route.stations[@current_index_station + 1]
      @current_index_station += 1
      @route.stations.each { |station| station.trains.delete(self) }
      @route.stations[@current_index_station].add_train(self)
    end
  end

  def to_previous_station
    unless @route.stations[@current_index_station - 1].nil?
      @current_index_station -= 1
      @route.stations.each { |station| station.trains.delete(self) }
      @route.stations[@current_index_station].add_train(self)
    end
  end

  def show_current_station
    @route.stations[@current_index_station]
  end

  def show_next_station
    @route.stations[@current_index_station + 1]
  end

  def show_previous_station
    @route.stations[@current_index_station - 1]
  end
end
