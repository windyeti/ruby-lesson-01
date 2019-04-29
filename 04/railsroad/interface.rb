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
  QUESTION_TRAIN_TYPE = "Введите тип поезда (passenger => 1 or cargo => 2):"
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
    gets.to_i
  end

  def print_delimeter
      puts "================================"
  end

  def input_name_station
    gets.chomp.downcase.capitalize
  end

  def input_number
    gets.to_i
  end

  def input_type
    gets.chomp.downcase
  end




  def show_stations(stations)
    stations.each.with_index(1) { |station, index| puts "#{index} : #{station.name}" }
  end

  def show_trains(trains, routes)
    trains.each.with_index(1) do |train, index|
      puts "[ #{index} : №: #{train.number}, Тип: #{train.class}, \
Кол. вагонов: #{train.wagons.size}, \
№ маршрута: #{routes.index(train.route)} ]\n"
    end
  end

  def show_routes(routes)
    routes.each.with_index(1) do |route, index|
      puts "[ Индекс: #{index} : #{route.start_point.name} <=> #{route.end_point.name}, \
#{route.show_stations} ]"
      end
  end

  def show_trains_station(stations)
    stations.each do |station|
      puts "[ #{station.name} : #{station.trains.map { |train| train.number }.join(" | ") } ]"
    end
  end
end
