require_relative 'manufacturer/manufacturer'
require_relative 'instance_counter/instance_counter'

class Train
  include InstanceCounter
  include Manufacturer

  NO_ROUTE = "No route!!!".freeze

  attr_reader :number, :route, :wagons

  # rubocop:disable Style/ClassVars
  @@trains = {}

  def self.find(number)
    @@trains[number.downcase]
  end

  def self.list_trains
    @@trains
  end

  def self.add_train(number, train)
    @@trains[number.downcase] = train
  end
  # rubocop:enable Style/ClassVars

  def each_wagon
    wagons.each { | wagon | yield(wagon) }
  end

  def initialize(number, manufacturer)
    @number = number
    @wagons = []
    @speed = 0
    @manufacturer = manufacturer
    self.class.add_train(number, self)
    validate!
    register_instance
  end

  def delete_wagon
    @wagons.pop
  end

  def route?
    !route.nil?
  end

  def route=(route)
    current_station.delete_train(self) unless @route.nil?
    @current_index_station = 0
    @route = route
    current_station.add_train(self)
  end

  def to_next_station
    raise NO_ROUTE unless route?
    return if next_station.nil?

    current_station.delete_train(self)
    next_station.add_train(self)
    @current_index_station += 1
  end

  def to_previous_station
    raise NO_ROUTE unless route?
    return if previous_station.nil?

    current_station.delete_train(self)
    previous_station.add_train(self)
    @current_index_station -= 1
  end

  def add_wagon(wagon)
    return unless speed.zero?
    return unless attachable_wagon?(wagon)

    @wagons << wagon
  end

  protected

  def current_station
    @route.stations[@current_index_station]
  end

  def next_station
    @route.stations[@current_index_station + 1]
  end

  def previous_station
    @route.stations[@current_index_station - 1] if @current_index_station > 0
  end

  private

  attr_reader :speed

  def speed_up(speed)
    @speed += speed
  end

  def speed_down(speed)
    @speed -= speed
    @speed = 0 if @speed < 0
  end

  def stop
    @speed = 0
  end
end
