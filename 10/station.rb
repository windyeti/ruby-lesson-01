require_relative 'instance_counter/instance_counter'
require_relative 'attr_accessor/attr_accessor'
require_relative 'validation/validation'

class Station
  include InstanceCounter
  include AttrAccesssor
  include Validation

  attr_reader :trains, :name

  validate :name, :presence
  validate :name, :type, String
  validate :name, :format, /^[A-Z]{1}[a-z]+$/

  # EMPTY_NAME_ERROR = "Name must not be empty!!!".freeze

  @stations = []

  class << self
    def all
      @stations
    end

    def add_station(station)
      @stations << station
    end
  end

  def initialize(name)
    @name = name
    @trains = []
    self.class.add_station(self)
    validate!
    register_instance
  end

  def each_train
    trains.each { |train| yield(train) }
  end

  def add_train(train)
    @trains << train
  end

  def delete_train(train)
    @trains.delete(train)
  end

  private

  def trains_of_type(type)
    @trains.select { |train| train.type == type }.size
  end
end
