require_relative 'manufacturer/manufacturer'
require_relative 'instance_counter/instance_counter'

class Train
  include InstanceCounter
  include Manufacturer

  TRAIN_MANUFACTURER = /^[a-z0-9]{3}-?[a-z0-9]{2}$/i

  attr_reader :number, :route, :wagons

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  def self.list_trains
    @@trains
  end

  def self.add_train(number, train)
    @@trains[number] = train
  end

  def initialize(number, manufacturer)
    @number = number
    @wagons = []
    @speed = 0
    @manufacturer = manufacturer
    self.class.add_train(number, self)
    self.register_instance
    validate!
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def validate!
    raise "Number must not be empty!!!" if number.empty?
    raise "Manufacturer not correct!!!" if manufacturer !~ TRAIN_MANUFACTURER
  end

  def delete_wagon
    @wagons.pop
  end

  def route=(route)
    current_station.delete_train(self) unless @route.nil?
    @current_index_station = 0
    @route = route
    current_station.add_train(self)
  end

  def to_next_station
    return if next_station.nil?
    current_station.delete_train(self)
    next_station.add_train(self)
    @current_index_station += 1
  end

  def to_previous_station
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
