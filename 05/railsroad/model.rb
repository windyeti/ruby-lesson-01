class Model
  attr_reader :stations, :trains, :routes

  TRAIN_TYPE = ['PassengerTrain', 'CargoTrain']

  def initialize(stations = [], routes = [], trains = [])
    @stations = stations
    @routes = routes
    @trains = trains
  end

  def create_station(name)
    station = Station.new(name)
    @stations << station
    Station.add_station(station)
  end

  def create_train(number, type_train)
    if type_train == 'PassengerTrain'
      train = PassengerTrain.new(number)
      @trains << train
    end
    if type_train == 'CargoTrain'
      train = CargoTrain.new(number)
      @trains << train
    end
    Train.add_to_list_trains(train)
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

  def delete_station_in_route(route, station)
    route.stations.delete(station)
  end

  def add_route_to_train(route, train)
    train.route = route
  end

  def wagons_train?(train)
    train.wagons.empty?
  end

  def add_wagon_to_train(train, wagon)
    train.add_wagon(wagon)
  end

  def delete_wagon_from_train(train)
    train.delete_wagon
  end




  def to_next_station(train)
    train.to_next_station
  end

  def to_previous_station(train)
    train.to_previous_station
  end
end
