require_relative 'instance_counter/instance_counter'
require_relative 'attr_accessor/attr_accessor'
require_relative 'validation/validation'

class Route
  include InstanceCounter
  include AttrAccesssor
  include Validation

  attr_reader :stations, :start_point, :end_point

  validate :start_point, :presence
  validate :start_point, :type, Station

  validate :end_point, :presence
  validate :end_point, :type, Station

  WRONG_INDEX_STATION = "Index station is wrong!!!".freeze

  def initialize(start_point, end_point)
    @start_point = start_point
    @end_point = end_point
    @stations = [@start_point, @end_point]
    validate!
    register_instance
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
