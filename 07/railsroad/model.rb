class Model
  attr_reader :stations, :trains, :routes

  TRAIN_TYPE = ['PassengerTrain', 'CargoTrain']
  NOT_CORRECT_TYPE_TRAIN = "Type of train not correct!!!"
  WRONG_INDEX_ROUTE = "Index route is wrong!!!"
  WRONG_INDEX_TRAIN = "Index train is wrong!!!"
  WRONG_INDEX_STATION = "Index station is wrong!!!"
  NO_WAGONS = "No wagons!!!"

  def initialize(stations = [], routes = [], trains = [])
    @stations = stations
    @routes = routes
    @trains = trains
  end

  def create_station(name)
    @stations << Station.new(name)
  end

  def create_train(number, manufacturer, type_train)
    raise NOT_CORRECT_TYPE_TRAIN if type_train.nil?
    if type_train == 'PassengerTrain'
      train = PassengerTrain.new(number, manufacturer)
      @trains << train
    elsif type_train == 'CargoTrain'
      train = CargoTrain.new(number, manufacturer)
      @trains << train
    end
    train
  end

  def create_route(start_station, end_station)
    @routes << Route.new(start_station, end_station)
  end

  def add_station_into_route(route, station)
    raise WRONG_INDEX_ROUTE if route.nil?
    raise WRONG_INDEX_STATION if station.nil?
    route.add_station(station)
  end

  def stations_in_route(route)
    route.stations
  end

  def delete_station_in_route(route, station)
    raise WRONG_INDEX_ROUTE if route.nil?
    raise WRONG_INDEX_STATION if station.nil?
    route.stations.delete(station)
  end

  def add_route_to_train(route, train)
    raise WRONG_INDEX_ROUTE if route.nil?
    raise WRONG_INDEX_TRAIN if train.nil?
    train.route = route
  end

  def wagons_train?(train)
    raise NO_WAGONS if train.wagons.empty?
  end

  def add_wagon_to_train(train, wagon)
    raise WRONG_INDEX_TRAIN if train.nil?
    train.add_wagon(wagon)
  end

  def delete_wagon_from_train(train)
    raise WRONG_INDEX_TRAIN if train.nil?
    train.delete_wagon
  end

  def to_next_station(train)
    raise WRONG_INDEX_TRAIN if train.nil?
    train.to_next_station
  end

  def to_previous_station(train)
    raise WRONG_INDEX_TRAIN if train.nil?
    train.to_previous_station
  end

  def take_place_in_wagon(wagon, value = 1)
    wagon.load_place(value)
  end
end
