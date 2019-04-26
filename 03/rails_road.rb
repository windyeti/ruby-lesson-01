class RailsRoad
  attr_reader :stations, :trains, :routes

  def seed
    # создадим пару станций
    self.add_station("Bak")
    self.add_station("Nem")
    self.add_station("Tre")
    self.add_station("Set")

    # создадим маршрут
    self.add_route("Bak", "Set")

    # создадим поезд Cargo
    self.add_train(311, 'cargo')
    self.add_train(254, 'passenger')

    # добавить вагон
    self.add_wagon_to_train("254", 'passenger')
    self.add_wagon_to_train("254", 'passenger')
    self.add_wagon_to_train("254", 'passenger')
    self.add_wagon_to_train("311", 'cargo')
    self.delete_wagon_from_train("254")

    # добавить станцию в маршрут
    self.add_station_into_route("0", "Tre")
    self.add_station_into_route("0", "Nem")

    # удалить станцию из маршрута
    self.delete_station_in_route("0", "Tre")

    # добавить маршрут поезду
    self.add_route_to_train("0", "311")

    # переместить вперед поезд
    self.to_next_station("311")
  end

  def add_station(name)
    @stations[name] = Station.new(name)
  end

  def add_route(start_station_name, end_station_name)
    start_station = get_station_by_name(start_station_name)
    end_station = get_station_by_name(end_station_name)
    return unless start_station && end_station
    @routes << Route.new(start_station, end_station)
  end

  def add_station_into_route(index_route, name_station)
    route = get_route_by_index(index_route)
    station = get_station_by_name(name_station)
    return unless route && station
    route.add_station(station)
  end

  def delete_station_in_route(index_route, name_station)
    route = get_route_by_index(index_route)
    station = get_station_by_name(name_station)
    return unless route && station
    route.stations.delete(station)
  end

  def add_train(number, type_train)
    @trains[number] = PassengerTrain.new(number) if type_train == 'passenger'
    @trains[number] = CargoTrain.new(number) if type_train == 'cargo'
  end

  def add_route_to_train(index_route, number_train)
    route = get_route_by_index(index_route)
    train = get_train_by_number(number_train)
    train.route = route
  end

  def add_wagon_to_train(number_train, type_wagon)
    train = get_train_by_number(number_train)
    train.add_wagon(PassengerWagon.new) if type_wagon == 'passenger'
    train.add_wagon(CargoWagon.new) if type_wagon == 'cargo'
  end

  def delete_wagon_from_train(number_train)
    train = get_train_by_number(number_train)
    train.delete_wagon
  end

  def to_next_station(number_train)
    train = get_train_by_number(number_train)
    train.to_next_station
  end

  def to_previous_station(number_train)
    train = get_train_by_number(number_train)
    train.to_previous_station
  end

  def show_list_station
    @stations.each.map { |index, station| "#{station.name}" }.join(" | ")
  end

  def show_list_trains
    @trains.each.map { |number, train|
      "[ №: #{number}, Тип: #{train.type}, Кол. вагонов: #{train.wagons.size}, № маршрута: #{@routes.index(train.route)} ]" }.join(" | ")
  end

  def show_list_routes
    @routes.each_with_index.map { |route, index| "[ № маршрута #{index} : #{route.start_point.name} <=> #{route.end_point.name}, #{route.show_stations} ]" }.join(" | ")
  end

  def show_list_train_in_station
    @stations.each { |name, station| puts "#{name} : #{station.trains.map { |train| train.number }.join(", ") }"  }
  end

  private
  # эти методы вне нигде не вызываются

  def initialize(stations = {}, routes = [], trains = {})
    @stations = stations
    @routes = routes
    @trains = trains
  end

  def get_station_by_name(name)
    @stations[name]
  end

  def get_route_by_index(index)
    @routes[index]
  end

  def get_train_by_number(number)
    @trains[number]
  end
end
