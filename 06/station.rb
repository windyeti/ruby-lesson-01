require_relative 'instance_counter/instance_counter'

class Station
  include InstanceCounter

  attr_reader :trains, :name

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
    self.register_instance
    validate!
  end

  def validate!
    raise "Name must not be empty!!!" if name.empty?
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
