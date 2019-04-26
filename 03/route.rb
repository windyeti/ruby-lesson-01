class Route
  attr_reader :stations, :start_point, :end_point

  def add_station(station)
    @stations.insert(1, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end

  def show_stations
    @stations.map {|station| station.name}.join(" <> ")
  end

  private
  # только этот метод не вызывается вне
  def initialize(start_point, end_point)
    @start_point = start_point
    @end_point = end_point
    @stations = [@start_point, @end_point]
  end
end
