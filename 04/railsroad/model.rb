class Model
  attr_reader :stations, :trains, :routes

  def initialize(stations = {}, routes = [], trains = {})
    @stations = stations
    @routes = routes
    @trains = trains
  end

  def create_station(name)
    @stations[name] = Station.new(name)
  end

  def create_train(number, type_train)
    @trains[number] = PassengerTrain.new(number) if type_train == 'passenger'
    @trains[number] = CargoTrain.new(number) if type_train == 'cargo'
  end

  def create_route(start_station, end_station)
    @routes << Route.new(start_station, end_station)
  end

  def add_station_into_route(route, station)
    route.add_station(station)
  end

  def delete_station_in_route(route, station)
    route.stations.delete(station)
  end

  def add_route_to_train(route, train)
    train.route = route
  end

  def add_wagon_to_train(train, wagon)
    train.wagons << wagon
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




  def show_list_station
    @stations.each.map { |index, station| "#{station.name}" }.join(" | ")
  end

  def show_list_train
    list = @trains.each.map do |number, train|
      "[ №: #{number}, Тип: #{train.class},
Кол. вагонов: #{train.wagons.size},
№ маршрута: #{@routes.index(train.route)} ]"
    end
    list.join(" | ")
  end

  def show_list_route
    routes = @routes.each_with_index.map do |route, index|
      "[ № маршрута #{index} : #{route.start_point.name} <=> #{route.end_point.name},
      #{route.show_stations} ]"
      end
      routes.join(" | ")
  end

  def show_list_train_in_station
    train_on_station = @stations.each.map do |name, station|
      "[ #{name} : #{station.trains.map { |train| train.number }.join(" | ") } ]"
    end
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
