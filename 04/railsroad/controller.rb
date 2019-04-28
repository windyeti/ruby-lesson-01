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
  #   @model.create_route(@model.stations["Bak"], @model.stations["Tre"])
  #   @model.add_station_into_route(@model.routes[0], @model.stations["Set"])
  #   @model.add_route_to_train(@model.routes[0], @model.trains[254])

  #   @model.add_wagon_to_train(@model.trains[254], "cargo")
  #   @model.add_wagon_to_train(@model.trains[311], "passenger")
  #   @model.add_wagon_to_train(@model.trains[311], "passenger")
  #   @model.delete_wagon_from_train(@model.trains[254])

  #   # @model.to_next_station(@model.trains[254])
  #   # @model.to_next_station(@model.trains[254])
  #   # @model.to_next_station(@model.trains[254])
  #   # @model.to_next_station(@model.trains[254])
  # end

  def show_menu
    puts Interface::TITLE
    Interface::MENU.each_with_index do | item, index |
      puts "( #{index} ) #{item}"
    end
  end

  def show_exist
    @interface.print_message(Interface::LIST_STATION_NAME)
    @interface.print_list(@model.show_list_station)

    @interface.print_message(Interface::LIST_TRAIN)
    @interface.print_list(@model.show_list_train)

    @interface.print_message(Interface::LIST_ROUTE)
    @interface.print_list(@model.show_list_route)

    @interface.print_message(Interface::LIST_TRAIN_IN_ROUTE)
    @interface.print_list(@model.show_list_train_in_station)
  end
  def run
    loop do
      puts "================================"
      show_exist
      puts "================================"
      show_menu
      action = gets.chomp
      case action
      when "1"
        @interface.print_message(Interface::QUESTION_STATION_NAME)
        name_station = gets.chomp.downcase.capitalize
        if name_station.empty?
          @interface.print_message(Interface::ERROR_ARGUMENT)
        else
          @model.create_station(name_station)
        end
      when "2"
        @interface.print_message(Interface::QUESTION_TRAIN_NUMBER)
        number_train = gets.chomp
        @interface.print_message(Interface::QUESTION_TRAIN_TYPE)
        type_train = gets.chomp.downcase
        if number_train.empty? || type_train.empty?
          @interface.print_message(Interface::ERROR_ARGUMENT)
        else
          @model.create_train(number_train.to_i, type_train)
        end
      when "3"
        @interface.print_message(Interface::QUESTION_START_STATION)
        start_station = @model.get_station_by_name(gets.chomp.downcase.capitalize)
        @interface.print_message(Interface::QUESTION_END_STATION)
        end_station = @model.get_station_by_name(gets.chomp.downcase.capitalize)
        if start_station.nil? || end_station.nil?
          @interface.print_message(Interface::ERROR_ARGUMENT)
        else
          @model.create_route(start_station, end_station)
        end
      when "4"
        @interface.print_message(Interface::QUESTION_INDEX_ROUTE)
        route = @model.get_route_by_index(gets.chomp.to_i)
        @interface.print_message(Interface::QUESTION_STATION_NAME)
        station = @model.get_station_by_name(gets.chomp.downcase.capitalize)
        if route.nil? || station.nil?
          @interface.print_message(Interface::ERROR_ARGUMENT)
        else
          @model.add_station_into_route(route, station)
        end
      when "5"
        @interface.print_message(Interface::QUESTION_INDEX_ROUTE)
        route = @model.get_route_by_index(gets.chomp.to_i)
        @interface.print_message(Interface::QUESTION_STATION_NAME)
        station = @model.get_station_by_name(gets.chomp.downcase.capitalize)
        if route.nil? || station.nil?
          @interface.print_message(Interface::ERROR_ARGUMENT)
        else
          @model.delete_station_in_route(route, station)
        end
      when "6"
        @interface.print_message(Interface::QUESTION_INDEX_ROUTE)
        route = @model.get_route_by_index(gets.chomp.to_i)
        @interface.print_message(Interface::QUESTION_TRAIN_NUMBER)
        train = @model.get_train_by_number(gets.chomp.to_i)
        if route.nil? || train.nil?
          @interface.print_message(Interface::ERROR_ARGUMENT)
        else
          @model.add_route_to_train(route, train)
        end
      when "7"
        @interface.print_message(Interface::QUESTION_TRAIN_NUMBER)
        train = @model.get_train_by_number(gets.chomp.to_i)
        @interface.print_message(Interface::QUESTION_WAGON_TYPE)
        type_wagon = gets.chomp.downcase
        wagon = if type_wagon == "passenger"
            PassengerWagon.new
          elsif type_wagon == "cargo"
            CargoWagon.new
          else
            @interface.print_message(Interface::ERROR_ARGUMENT)
            nil
          end
        @model.add_wagon_to_train(train, wagon)
      when "8"
        @interface.print_message(Interface::QUESTION_TRAIN_NUMBER)
        train = @model.get_train_by_number(gets.chomp.to_i)
        if train
          @model.delete_wagon_from_train(train)
        else
          @interface.print_message(Interface::ERROR_ARGUMENT)
        end
      when "9"
        @interface.print_message(Interface::QUESTION_TRAIN_NUMBER)
        train = @model.get_train_by_number(gets.chomp.to_i)
        if train && train.route
          @model.to_next_station(train)
        else
          @interface.print_message(Interface::ERROR_ARGUMENT)
        end
      when "10"
        @interface.print_message(Interface::QUESTION_TRAIN_NUMBER)
        train = @model.get_train_by_number(gets.chomp.to_i)
        if train && train.route
          @model.to_previous_station(train)
        else
          @interface.print_message(Interface::ERROR_ARGUMENT)
        end
      when "11"
        @interface.print_list(@model.show_list_station)
      when "12"
        @interface.print_list(@model.show_list_train_in_station)
      when "0"
        break
      end
    end
  end
end
