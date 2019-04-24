class Route
  attr_reader :start_point, :end_point, :stations

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
end
