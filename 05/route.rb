require_relative 'instance_counter/instance_counter'

class Route
  include InstanceCounter

  attr_reader :stations, :start_point, :end_point

  inheritable_attributes :instances
  @instances = 0

  def initialize(start_point, end_point)
    @start_point = start_point
    @end_point = end_point
    @stations = [@start_point, @end_point]
    super
  end

  def add_station(station)
    @stations.insert(1, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end

  def show_stations
    @stations.map(&:name)
  end
end
