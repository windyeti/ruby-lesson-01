require_relative 'model'
require_relative 'interface'
require_relative '../train'

class Controller
  def initialize
    @model = Model.new
    @interface = Interface.new
  end

  def seed
    # создать станции
    @model.create_station("bak".downcase.capitalize)
    @model.create_station("set".downcase.capitalize)
    @model.create_station("tre".downcase.capitalize)
    @model.create_station("nem".downcase.capitalize)
    @model.create_station("kun".downcase.capitalize)

    # создать маршрут
    @model.create_train('dfg-45', 'Cargo & Co', 'PassengerTrain')
    @model.create_train('3r4-C7', 'Cargo & Co', 'PassengerTrain')
    @model.create_train('456-90', 'Cargo & Co', 'CargoTrain')
    @model.create_train('WR3-C7', 'Cargo & Co', 'CargoTrain')
    @model.create_route(@model.stations[0], @model.stations[2])
    @model.add_station_into_route(@model.routes[0], @model.stations[1])
    @model.add_station_into_route(@model.routes[0], @model.stations[3])
    @model.add_route_to_train(@model.routes[0], @model.trains[0])

    @model.add_wagon_to_train(@model.trains[2], CargoWagon.new(24.0))
    @model.add_wagon_to_train(@model.trains[0], PassengerWagon.new(56.0))
    @model.add_wagon_to_train(@model.trains[0], PassengerWagon.new(64.0))
    @model.delete_wagon_from_train(@model.trains[1])

    @model.to_next_station(@model.trains[0])
    @model.to_next_station(@model.trains[0])
    @model.to_next_station(@model.trains[0])
    @model.to_next_station(@model.trains[0])
  end

  def run
    loop do
      show_exist
      @interface.show_menu
      action = @interface.input_index + 1
      case action
      when 1 then create_station
      when 2 then create_train
      when 3 then create_route
      when 4 then add_station_in_route
      when 5 then delete_station_in_route
      when 6 then add_route_to_train
      when 7 then add_wagon_to_train
      when 8 then delete_wagon_from_train
      when 9 then to_next_station
      when 10 then to_previous_station
      when 11 then print_list_station
      when 12 then print_list_train_in_station
      when 13 then take_place_in_wagon
      when 0 then break
      end
    end
  end

  def show_exist
    @interface.print_delimeter
    @interface.print_delimeter
    @interface.show_message(Interface::LIST_STATION_NAME)
    @interface.show_stations(@model.stations)

    @interface.show_message(Interface::LIST_TRAIN)
    @interface.show_trains(@model.trains)

    @interface.show_message(Interface::LIST_ROUTE)
    @interface.show_routes(@model.routes)

    @interface.show_message(Interface::LIST_TRAIN_IN_STATION)
    @interface.show_trains_station(@model.stations)
    @interface.print_delimeter
    # @interface.show_list(Station.instances)
    # @interface.show_list(PassengerTrain.instances)
    # @interface.show_list(CargoTrain.instances)
    # @interface.show_list(Route.instances)
    @interface.print_delimeter
  end

  def create_station
    @interface.show_message(Interface::LIST_STATION_NAME)
    @interface.show_stations(@model.stations)
    @interface.print_delimeter
    @interface.show_message(Interface::QUESTION_STATION_NAME)
    name_station = @interface.input_string
    @model.create_station(name_station)
  rescue StandardError
    @interface.show_message(Interface::NOT_CORRECT_NAME)
  end

  def create_train
    attempt = 0
    begin
      @interface.show_message(Interface::LIST_TRAIN)
      @interface.show_trains(@model.trains)
      @interface.print_delimeter
      @interface.show_message(Interface::QUESTION_TRAIN_NUMBER)
      number_train = @interface.input_string
      @interface.show_message(Interface::QUESTION_TRAIN_TYPE)
      type_train = Model::TRAIN_TYPE[@interface.input_index]
      @interface.show_message(Interface::QUESTION_TRAIN_MANUFACTURER)
      manufacturer_train = @interface.input_string
      train = @model.create_train(number_train, manufacturer_train, type_train)
    rescue StandardError
      attempt += 1
      @interface.show_attampt(Interface::NOT_CORRECT_ARGUMENT, attempt, Interface::OF_ATTAMPTS)
      retry if attempt < 6
    else
      @interface.show_train(train)
    end
  end

  def create_route
    @interface.show_message(Interface::LIST_STATION_NAME)
    @interface.show_stations(@model.stations)
    @interface.show_message(Interface::LIST_ROUTE)
    @interface.show_routes(@model.routes)
    @interface.print_delimeter
    @interface.show_message(Interface::QUESTION_START_STATION)
    start_station = @model.stations[@interface.input_index]
    @interface.show_message(Interface::QUESTION_END_STATION)
    end_station = @model.stations[@interface.input_index]
    @model.create_route(start_station, end_station)
  rescue StandardError
    @interface.show_message(Interface::WRONG_INDEX_STATION)
  end

  def add_station_in_route
    @interface.show_message(Interface::LIST_STATION_NAME)
    @interface.show_stations(@model.stations)
    @interface.show_message(Interface::LIST_ROUTE)
    @interface.show_routes(@model.routes)
    @interface.print_delimeter
    @interface.show_message(Interface::QUESTION_INDEX_ROUTE)
    route = @model.routes[@interface.input_index]
    @interface.show_message(Interface::QUESTION_INDEX_STATION)
    station = @model.stations[@interface.input_index]
    @model.add_station_into_route(route, station)
  rescue StandardError
    @interface.show_message(Interface::WRONG_INDEX_ROUTE_OR_STATION)
  end

  def delete_station_in_route
    @interface.show_message(Interface::LIST_ROUTE)
    @interface.show_routes(@model.routes)
    @interface.print_delimeter
    @interface.show_message(Interface::QUESTION_INDEX_ROUTE)
    route = @model.routes[@interface.input_index]
    @interface.print_delimeter
    @interface.show_stations(route.stations)
    @interface.show_message(Interface::QUESTION_INDEX_STATION)
    stations = @model.stations_in_route(route)
    station = stations[@interface.input_index]
    @model.delete_station_in_route(route, station)
  rescue StandardError
    @interface.show_message(Interface::WRONG_INDEX_ROUTE_OR_STATION)
  end

  def add_route_to_train
    @interface.show_message(Interface::LIST_ROUTE)
    @interface.show_routes(@model.routes)
    @interface.show_message(Interface::LIST_TRAIN)
    @interface.show_trains(@model.trains)
    @interface.print_delimeter
    @interface.show_message(Interface::QUESTION_INDEX_ROUTE)
    route = @model.routes[@interface.input_index]
    @interface.show_message(Interface::QUESTION_INDEX_TRAIN)
    train = @model.trains[@interface.input_index]
    @model.add_route_to_train(route, train)
  rescue StandardError
    @interface.show_message(Interface::WRONG_INDEX_ROUTE_OR_TRAIN)
  end

  def add_wagon_to_train
    @interface.show_message(Interface::LIST_TRAIN)
    @interface.show_trains(@model.trains)
    @interface.print_delimeter
    @interface.show_message(Interface::QUESTION_INDEX_TRAIN)
    train = @model.trains[@interface.input_index]
    @interface.show_message(Interface::QUESTION_VALUE_WAGON)
    value_wagon = @interface.input_value
    wagon =
      if train.is_a?(PassengerTrain)
        PassengerWagon.new(value_wagon)
      else
        CargoWagon.new(value_wagon)
      end
    @model.add_wagon_to_train(train, wagon)
  rescue StandardError
    @interface.show_message(Interface::WRONG_INDEX_TRAIN)
  end

  def delete_wagon_from_train
    @interface.show_message(Interface::LIST_TRAIN)
    @interface.show_trains(@model.trains)
    @interface.print_delimeter
    @interface.show_message(Interface::QUESTION_INDEX_TRAIN)
    train = @model.trains[@interface.input_index]
    @model.wagons_train?(train)
    @model.delete_wagon_from_train(train)
  rescue StandardError
    @interface.show_message(Interface::WRONG_INDEX_TRAIN_OR_NO_WAGON)
  end

  def to_next_station
    @interface.show_message(Interface::LIST_TRAIN)
    @interface.show_trains(@model.trains)
    @interface.print_delimeter
    @interface.show_message(Interface::QUESTION_INDEX_TRAIN)
    train = @model.trains[@interface.input_index]
    @model.to_next_station(train)
  rescue StandardError
    @interface.show_message(Interface::WRONG_INDEX_TRAIN_OR_NO_ROUTE)
  end

  def to_previous_station
    @interface.show_message(Interface::LIST_TRAIN)
    @interface.show_trains(@model.trains)
    @interface.print_delimeter
    @interface.show_message(Interface::QUESTION_INDEX_TRAIN)
    train = @model.trains[@interface.input_index]
    @model.to_previous_station(train)
  rescue StandardError
    @interface.show_message(Interface::WRONG_INDEX_TRAIN_OR_NO_ROUTE)
  end

  def print_list_station
    @interface.show_stations(@model.stations)
  end

  def print_list_train_in_station
    @interface.show_trains_station(@model.stations)
  end

  def take_place_in_wagon
    @interface.show_message(Interface::LIST_TRAIN)
    @interface.show_trains(@model.trains)
    @interface.print_delimeter
    @interface.show_message(Interface::QUESTION_INDEX_TRAIN)
    train = @model.trains[@interface.input_index]
    @interface.show_message(Interface::LIST_WAGON)
    @interface.show_wagons(train.wagons)
    @interface.show_message(Interface::QUESTION_INDEX_WAGON)
    wagon = train.wagons[@interface.input_index]
    type_wagon = wagon.class
    case type_wagon.to_s
    when 'CargoWagon'
      @interface.show_message(Interface::QUESTION_WAGON_VALUE)
      value = @interface.input_value
      @model.take_place_in_wagon(wagon, value)
    when 'PassengerWagon'
      @model.take_place_in_wagon(wagon, 1)
    end
  rescue
    @interface.show_message(Interface::WRONG_INDEX_TRAIN_OR_NO_WAGON_OR_NOT_FREE)
  end
end
