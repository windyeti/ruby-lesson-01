class Model
  attr_reader :stations, :trains, :routes

  TRAIN_TYPE = %w[PassengerTrain CargoTrain].freeze
  NOT_CORRECT_TYPE_TRAIN = "Type of train not correct!!!".freeze
  WRONG_INDEX_ROUTE = "Index route is wrong!!!".freeze
  WRONG_INDEX_TRAIN = "Index train is wrong!!!".freeze
  WRONG_INDEX_STATION = "Index station is wrong!!!".freeze
  WRONG_INDEX_WAGON = "Index wagon is wrong!!!".freeze
  NO_WAGONS = "No wagons!!!".freeze

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
    route.add_station(station)
  end

  def stations_in_route(route)
    route.stations
  end

  def station_by_index(stations, index)
    raise WRONG_INDEX_STATION if stations[index].nil?

    stations[index]
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
    train.to_next_station
  end

  def to_previous_station(train)
    train.to_previous_station
  end

  def take_place_in_wagon(wagon, value)
    wagon.load_place(value)
  end

  def find_station(index)
    raise WRONG_INDEX_STATION if stations[index].nil?

    stations[index]
  end

  def find_route(index)
    raise WRONG_INDEX_ROUTE if routes[index].nil?

    routes[index]
  end

  def find_train(index)
    raise WRONG_INDEX_TRAIN if trains[index].nil?

    trains[index]
  end

  def find_wagon(train, index)
    raise WRONG_INDEX_WAGON if train.wagons[index].nil?

    train.wagons[index]
  end
end
