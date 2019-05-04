require_relative 'instance_counter/instance_counter'

class Station
  include InstanceCounter

  attr_reader :trains, :name

  @@stations = []

  inheritable_attributes :instances
  @instances = 0

  class << self
    def all
      @@stations
    end

    def add_station(station)
      @@stations << station
    end
  end

  def initialize(name)
    @name = name
    @trains = []
    super
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
