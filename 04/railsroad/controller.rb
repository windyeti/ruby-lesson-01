require_relative 'model'
require_relative 'interface'

class Controller
  def initialize
    @model = Model.new
    @interface = Interface.new
  end

  # def seed
  #   # создать станции
  #   @model.create_station("bak".downcase.capitalize)
  #   @model.create_station("set".downcase.capitalize)
  #   @model.create_station("tre".downcase.capitalize)

  #   # создать маршрут
  #   @model.create_train(254, "cargo")
  #   @model.create_train(311, "passenger")
  #   @model.create_route(@model.stations[0], @model.stations[2])
  #   @model.add_station_into_route(@model.routes[0], @model.stations[1])
  #   @model.add_route_to_train(@model.routes[0], @model.trains[0])

  #   @model.add_wagon_to_train(@model.trains[0], CargoWagon.new)
  #   @model.add_wagon_to_train(@model.trains[1], PassengerWagon.new)
  #   @model.add_wagon_to_train(@model.trains[1], PassengerWagon.new)
  #   @model.delete_wagon_from_train(@model.trains[1])

  #   @model.to_next_station(@model.trains[0])
  #   @model.to_next_station(@model.trains[0])
  #   @model.to_next_station(@model.trains[0])
  #   @model.to_next_station(@model.trains[0])
  # end

  def run
    loop do
      show_exist
      @interface.show_menu
      action = @interface.chooser_index
      case action
      when 1
        create_station
      when 2
        create_train
      when 3
        create_route
      when 4
        add_station_in_route
      when 5
        delete_station_in_route
      when 6
        add_route_to_train
      when 7
        add_wagon_to_train
      when 8
        delete_wagon_from_train
      when 9
        to_next_station
      when 10
        to_previous_station
      when 11
        print_list_station
      when 12
        print_list_train_in_station
      when 0
        break
      end
    end
  end

  def show_exist
    @interface.print_delimeter
    @interface.print_delimeter
    @interface.show_message(Interface::LIST_STATION_NAME)
    @interface.show_list_station(@model.stations)

    @interface.show_message(Interface::LIST_TRAIN)
    @interface.show_list_train(@model.trains, @model.routes)

    @interface.show_message(Interface::LIST_ROUTE)
    @interface.show_list_route(@model.routes)

    @interface.show_message(Interface::LIST_TRAIN_IN_ROUTE)
    @interface.show_list_train_in_station(@model.stations)
    @interface.print_delimeter
    @interface.print_delimeter
  end

  def create_station
    @interface.show_message(Interface::LIST_STATION_NAME)
    @interface.show_list_station(@model.stations)
    @interface.print_delimeter
    @interface.show_message(Interface::QUESTION_STATION_NAME)
        name_station = @interface.input_name_station
        if name_station.empty?
          @interface.show_message(Interface::ERROR_ARGUMENT)
        else
          @model.create_station(name_station)
        end
  end

  def create_train
    @interface.show_message(Interface::LIST_TRAIN)
    @interface.show_list_train(@model.trains, @model.routes)
    @interface.print_delimeter
    @interface.show_message(Interface::QUESTION_TRAIN_NUMBER)
    number_train = @interface.input_number
    @interface.show_message(Interface::QUESTION_TRAIN_TYPE)
    type_train = @interface.input_type
    if number_train.empty? || type_train.empty?
      @interface.show_message(Interface::ERROR_ARGUMENT)
    else
      @model.create_train(number_train.to_i, type_train)
    end
  end

  def create_route
    @interface.show_message(Interface::LIST_STATION_NAME)
    @interface.show_list_station(@model.stations)
    @interface.show_message(Interface::LIST_ROUTE)
    @interface.show_list_route(@model.routes)
    @interface.print_delimeter
    @interface.show_message(Interface::QUESTION_START_STATION)
    start_station = @model.stations[@interface.input_number]
    @interface.show_message(Interface::QUESTION_END_STATION)
    end_station = @model.stations[@interface.input_number]
    if start_station.nil? || end_station.nil?
      @interface.show_message(Interface::ERROR_ARGUMENT)
    else
      @model.create_route(start_station, end_station)
    end
  end

  def add_station_in_route
    @interface.show_message(Interface::LIST_STATION_NAME)
    @interface.show_list_station(@model.stations)
    @interface.show_message(Interface::LIST_ROUTE)
    @interface.show_list_route(@model.routes)
    @interface.print_delimeter
    @interface.show_message(Interface::QUESTION_INDEX_ROUTE)
    route = @model.routes[@interface.input_number]
    @interface.show_message(Interface::QUESTION_INDEX_STATION)
    station = @model.stations[@interface.input_number]
    if route.nil? || station.nil?
      @interface.show_message(Interface::ERROR_ARGUMENT)
    else
      @model.add_station_into_route(route, station)
    end
  end

  def delete_station_in_route
    @interface.show_message(Interface::LIST_STATION_NAME)
    @interface.show_list_station(@model.stations)
    @interface.show_message(Interface::LIST_ROUTE)
    @interface.show_list_route(@model.routes)
    @interface.print_delimeter
    @interface.show_message(Interface::QUESTION_INDEX_ROUTE)
    route = @model.routes[@interface.input_number]
    @interface.show_message(Interface::QUESTION_INDEX_STATION)
    station = @model.stations[@interface.input_number]
    if route.nil? || station.nil?
      @interface.show_message(Interface::ERROR_ARGUMENT)
    else
      @model.delete_station_in_route(route, station)
    end
  end

  def add_route_to_train
    @interface.show_message(Interface::LIST_ROUTE)
    @interface.show_list_route(@model.routes)
    @interface.show_message(Interface::LIST_TRAIN)
    @interface.show_list_train(@model.trains, @model.routes)
    @interface.print_delimeter
    @interface.show_message(Interface::QUESTION_INDEX_ROUTE)
    route = @model.routes[@interface.input_number]
    @interface.show_message(Interface::QUESTION_INDEX_TRAIN)
    train = @model.trains[@interface.input_number]
    if route.nil? || train.nil?
      @interface.show_message(Interface::ERROR_ARGUMENT)
    else
      @model.add_route_to_train(route, train)
    end
  end

  def add_wagon_to_train
    @interface.show_message(Interface::LIST_TRAIN)
    @interface.show_list_train(@model.trains, @model.routes)
    @interface.print_delimeter
    @interface.show_message(Interface::QUESTION_INDEX_TRAIN)
    train = @model.trains[@interface.input_number]
    @interface.show_message(Interface::QUESTION_WAGON_TYPE)
    type_wagon = @interface.input_type
    wagon = if type_wagon == "passenger"
        PassengerWagon.new
      elsif type_wagon == "cargo"
        CargoWagon.new
      else
        @interface.show_message(Interface::ERROR_ARGUMENT)
        nil
      end
    @model.add_wagon_to_train(train, wagon)
  end

  def delete_wagon_from_train
    @interface.show_message(Interface::LIST_TRAIN)
    @interface.show_list_train(@model.trains, @model.routes)
    @interface.print_delimeter
    @interface.show_message(Interface::QUESTION_INDEX_TRAIN)
    train = @model.trains[@interface.input_number]
    if train
      @model.delete_wagon_from_train(train)
    else
      @interface.show_message(Interface::ERROR_ARGUMENT)
    end
  end

  def to_next_station
    @interface.show_message(Interface::LIST_TRAIN)
    @interface.show_list_train(@model.trains, @model.routes)
    @interface.print_delimeter
    @interface.show_message(Interface::QUESTION_INDEX_TRAIN)
    train = @model.trains[@interface.input_number]
    if train && train.route
      @model.to_next_station(train)
    else
      @interface.show_message(Interface::ERROR_ARGUMENT)
    end
  end

  def to_previous_station
    @interface.show_message(Interface::LIST_TRAIN)
    @interface.show_list_train(@model.trains, @model.routes)
    @interface.print_delimeter
    @interface.show_message(Interface::QUESTION_INDEX_TRAIN)
    train = @model.trains[@interface.input_number]
    if train && train.route
      @model.to_previous_station(train)
    else
      @interface.show_message(Interface::ERROR_ARGUMENT)
    end
  end

  def print_list_station
    @interface.show_list_station(@model.stations)
  end

  def print_list_train_in_station
    @interface.show_list_train_in_station(@model.stations)
  end
end
