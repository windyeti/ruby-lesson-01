class Model
  attr_reader :stations, :trains, :routes

  TRAIN_TYPE = ['PassengerTrain', 'CargoTrain']

  def initialize(stations = [], routes = [], trains = [])
    @stations = stations
    @routes = routes
    @trains = trains
  end

  def create_station(name)
    @stations << Station.new(name)
  end

  def create_train(number, manufacturer, type_train)
    raise "Type of train not correct!!!" if type_train.nil?
    if type_train == 'PassengerTrain'
      train = PassengerTrain.new(number, manufacturer)
      @trains << train
    else type_train == 'CargoTrain'
      train = CargoTrain.new(number, manufacturer)
      @trains << train
    end
    train
  end

  def create_route(start_station, end_station)
    @routes << Route.new(start_station, end_station)
  end

  def add_station_into_route(route, station)
    raise "Index route is wrong!!!" if route.nil?
    raise "Index station is wrong!!!" if station.nil?
    route.add_station(station)
  end

  def stations_in_route(route)
    route.stations
  end

  def delete_station_in_route(route, station)
    raise "Index route is wrong!!!" if route.nil?
    raise "Index station is wrong!!!" if station.nil?
    route.stations.delete(station)
  end

  def add_route_to_train(route, train)
    raise "Index route is wrong!!!" if route.nil?
    raise "Index train is wrong!!!" if train.nil?
    train.route = route
  end

  def wagons_train?(train)
    raise "There are no wagons!!!" if train.wagons.empty?
  end

  def add_wagon_to_train(train, wagon)
    raise "Index train is wrong!!!" if train.nil?
    train.add_wagon(wagon)
  end

  def delete_wagon_from_train(train)
    raise "Index train is wrong!!!" if train.nil?
    train.delete_wagon
  end

  def route_train?(train)
    raise "No train route!!!" if train.route.nil?
  end




  def to_next_station(train)
    raise "Index train is wrong!!!" if train.nil?
    train.to_next_station
  end

  def to_previous_station(train)
    raise "Index train is wrong!!!" if train.nil?
    train.to_previous_station
  end
end
