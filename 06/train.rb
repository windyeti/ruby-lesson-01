require_relative 'manufacturer/manufacturer'
require_relative 'instance_counter/instance_counter'

class Train
  include InstanceCounter
  include Manufacturer

  TRAIN_NUMBER = /^[a-z0-9]{3}-?[a-z0-9]{2}$/i
  EMPTY_MANUFACTURER_ERROR = "Manufacturer must not be empty!!!"
  NOT_CORRECT_NUMBER = "Number not correct!!!"
  NO_ROUTE = "No route!!!"

  attr_reader :number, :route, :wagons

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

  def initialize(number, manufacturer)
    @number = number
    @wagons = []
    @speed = 0
    @manufacturer = manufacturer
    self.class.add_train(number, self)
    validate!
    register_instance
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def validate!
    raise EMPTY_MANUFACTURER_ERROR if manufacturer.empty?
    raise NOT_CORRECT_NUMBER if number !~ TRAIN_NUMBER
  end

  def delete_wagon
    @wagons.pop
  end

  def has_route?
    !route.nil?
  end

  def route=(route)
    current_station.delete_train(self) unless @route.nil?
    @current_index_station = 0
    @route = route
    current_station.add_train(self)
  end

  def to_next_station
    raise NO_ROUTE unless has_route?
    return if next_station.nil?
    current_station.delete_train(self)
    next_station.add_train(self)
    @current_index_station += 1
  end

  def to_previous_station
    raise NO_ROUTE unless has_route?
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
