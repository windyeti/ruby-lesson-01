class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end

  def delete_train(train)
    @trains.delete(train)
  end

  def get_trains_of_type(type)
    # не понятно из условий задачи что нужно выводить: список или кол-во?
    @trains.map { |train| train.type == type }.size
  end

  def go_train(train)
    train.speed(5)
    @trains.delete(train)
  end
end

class Route
  attr_reader :start_point

  def initialize(start_point, end_point)
    @start_point = start_point
    @end_point = end_point
    @stations = [@start_point, @end_point]
  end

  def add_station(station)
    @stations.insert(1, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end

  def show_stations
    @stations.each { |station| puts station.name }
  end

  def to_start_station(train)
    @stations.each { |station| station.trains.delete(train) }
    @stations[0].add_train(train)
  end

  def to_next_station(train)
    index_station = get_index_station(train)
    @stations.each { |station| station.trains.delete(train) }
    @stations[index_station + 1].add_train(train) unless @stations[index_station + 1].nil?
  end

  def to_previous_station(train)
    index_station = get_index_station(train)
    @stations.each { |station| station.trains.delete(train) }
    @stations[index_station - 1].add_train(train) unless @stations[index_station - 1].nil?
  end

  def get_index_station(train)
    @stations.index { |station| station.trains.include?(train) }
  end

  def show_station(train)
    index_station = get_index_station(train)
    puts @stations[index_station].name
  end

  def show_next_station(train)
    index_station = get_index_station(train)
    puts @stations[index_station + 1].name unless @stations[index_station + 1].nil?
  end

  def show_previous_station(train)
    index_station = get_index_station(train)
    puts @stations[index_station - 1].name unless @stations[index_station - 1].nil?
  end
end

class Train
  attr_accessor :speed
  attr_reader :wagons

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
  end

  def stop
    self.speed = 0
  end

  def increment_wagon
    @wagons += 1
  end

  def decrement_wagon
    @wagons -= 1
  end

  def route=(route)
    @route = route
    @route.to_start_station(self)
  end

  def to_next_station
    @route.to_next_station(self)
  end

  def to_previous_station
    @route.to_previous_station(self)
  end

  def show_station
    @route.show_station(self)
  end

  def show_nex_station
    @route.show_next_station(self)
  end

  def show_previous_station
    @route.show_previous_station(self)
  end
end
