class Route
  attr_reader :start_point, :stations

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

  # def to_next_station(train)
  #   index_station = get_index_station(train)
  #   @stations.each { |station| station.trains.delete(train) }
  #   @stations[index_station + 1].add_train(train) unless @stations[index_station + 1].nil?
  # end

  # def to_previous_station(train)
  #   index_station = get_index_station(train)
  #   @stations.each { |station| station.trains.delete(train) }
  #   @stations[index_station - 1].add_train(train) unless @stations[index_station - 1].nil?
  # end

  # def get_index_station(train)
  #   @stations.index { |station| station.trains.include?(train) }
  # end

  # def show_station(train)
  #   index_station = get_index_station(train)
  #   puts @stations[index_station].name
  # end

  # def show_next_station(train)
  #   index_station = get_index_station(train)
  #   puts @stations[index_station + 1].name unless @stations[index_station + 1].nil?
  # end

  # def show_previous_station(train)
  #   index_station = get_index_station(train)
  #   puts @stations[index_station - 1].name unless @stations[index_station - 1].nil?
  # end
end
