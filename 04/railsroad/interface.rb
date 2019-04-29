class Interface
  TITLE = "\nВыберите ( пунк ) действия:\n"
  MENU = [
    "Выход",
    "Создать станцию",
    "Создать поезд",
    "Создать маршрут",
    "Добавить станцию в маршрут",
    "Удалить станцию из маршрута",
    "Назначать маршрут поезду",
    "Добавить вагон к поезду",
    "Удалить вагон у поезда",
    "Переместить поезд вперед",
    "Переместить поезд назад",
    "Список станций",
    "Список поездов на станции"
  ]
  QUESTION_STATION_NAME = "Введите название станции:"
  QUESTION_INDEX_STATION = "Введите индекс станции:"
  QUESTION_TRAIN_NUMBER = "Введите номер поезда:"
  QUESTION_TRAIN_TYPE = "Введите тип поезда (passenger or cargo):"
  QUESTION_INDEX_TRAIN = "Введите индекс поезда:"
  QUESTION_START_STATION = "Введите индекс начальной станции:"
  QUESTION_END_STATION = "Введите индекс конечной станции:"
  QUESTION_INDEX_ROUTE = "Введите номер маршрута:"
  QUESTION_WAGON_TYPE = "Введите тип вагона (passenger or cargo):"
  LIST_STATION_NAME = "Список созданных станций:"
  LIST_TRAIN = "Список созданных поездов:"
  LIST_ROUTE = "Список созданных маршрутов:"
  LIST_TRAIN_IN_ROUTE = "Список поездов на станции:"

  ERROR_ARGUMENT = "> > > > Ошибка аргумента < < < <"


  def show_menu
    puts Interface::TITLE
    Interface::MENU.each_with_index do | item, index |
      puts "( #{index} ) #{item}"
    end
  end

  def show_message(message)
    puts message
  end

  def show_list(list)
    puts list
  end

  def chooser_index
    gets.chomp.to_i
  end

  def print_delimeter
      puts "================================"
  end

  def input_name_station
    gets.chomp.downcase.capitalize
  end

  def input_number
    gets.chomp.to_i
  end

  def input_type
    gets.chomp.downcase
  end




  def show_list_station(stations)
    puts stations.each_with_index.map { |station, index| "#{index} : #{station.name}" }.join(" | ")
  end

  def show_list_train(trains, routes)
    list = trains.each_with_index.map do |train, index|
      "[ #{index} : №: #{train.number}, Тип: #{train.class}, \
Кол. вагонов: #{train.wagons.size}, \
№ маршрута: #{routes.index(train.route)} ]\n"
    end
    puts list.join("")
  end

  def show_list_route(routes)
    routes = routes.each_with_index.map do |route, index|
      "[ № маршрута #{index} : #{route.start_point.name} <=> #{route.end_point.name}, \
#{route.show_stations} ]"
      end
      puts routes.join(" | ")
  end

  def show_list_train_in_station(stations)
    train_on_station = stations.each.map do |station|
      "[ #{station.name} : #{station.trains.map { |train| train.number }.join(" | ") } ]"
    end
    puts train_on_station.join(" | ")
  end
end
