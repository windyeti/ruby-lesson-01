require_relative 'instance_counter/instance_counter'

class Station
  include InstanceCounter

  attr_reader :trains, :name

  EMPTY_NAME_ERROR = "Name must not be empty!!!"

  @@stations = []

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
    self.class.add_station(self)
    validate!
    register_instance
  end

  def trains_in_station
    self.trains.each { |train| yield(train) }
  end

  def validate!
    raise EMPTY_NAME_ERROR if name.empty?
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
