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
    "Список поездов на станции",
    "Занять место в вагоне"
  ]
  QUESTION_STATION_NAME = "Введите название станции:"
  QUESTION_INDEX_STATION = "Введите индекс станции:"
  QUESTION_TRAIN_NUMBER = "Введите номер поезда:"
  QUESTION_TRAIN_MANUFACTURER = "Введите производителя поезда:"
  QUESTION_TRAIN_TYPE = "Введите тип поезда (passenger => 1 or cargo => 2):"
  QUESTION_INDEX_TRAIN = "Введите индекс поезда:"
  QUESTION_START_STATION = "Введите индекс начальной станции:"
  QUESTION_END_STATION = "Введите индекс конечной станции:"
  QUESTION_INDEX_ROUTE = "Введите номер маршрута:"
  QUESTION_WAGON_TYPE = "Введите тип вагона (passenger or cargo):"
  QUESTION_WAGON_MANUFACTURER = "Введите производителя вагона:"
  LIST_STATION_NAME = "Список созданных станций:"
  LIST_TRAIN = "Список созданных поездов:"
  LIST_ROUTE = "Список созданных маршрутов:"
  LIST_WAGON = "Список вагонов:"
  LIST_TRAIN_IN_STATION = "Список поездов на станции:"

  ERROR_ARGUMENT = "> > > > Ошибка аргумента < < < <"

  NOT_CORRECT_NAME = "Name not correct!!!"
  NOT_CORRECT_ARGUMENT= "Argument not correct!!! Attampt "
  OF_ATTAMPTS = " of 6"
  WRONG_INDEX_STATION = "Index station is wrong!!!!"
  WRONG_INDEX_ROUTE_OR_STATION = "Index route or station - is wrong!!!"
  WRONG_INDEX_ROUTE_OR_TRAIN = "Index route or train - is wrong!!!"
  WRONG_INDEX_TRAIN = "Index train is wrong!!!"
  WRONG_INDEX_TRAIN_OR_NO_WAGON = "Index train is wrong or there are no wagon!!!"
  WRONG_INDEX_TRAIN_OR_NO_ROUTE = "Index train is wrong or there are no route!!!"
  QUESTION_VALUE_WAGON = "Вместимость вагона:"
  QUESTION_WAGON_VALUE = "Сколько добавить:"
  QUESTION_INDEX_WAGON = "Введите № вагона:"
  WRONG_INDEX_TRAIN_OR_NO_WAGON_OR_NOT_FREE =
  "Index train is wrong or no wagon or no free!!!"



  def show_menu
    puts Interface::TITLE
    Interface::MENU.each_with_index do | item, index |
      puts "( #{index} ) #{item}"
    end
  end

  def show_message(message)
    puts message
  end

  def show_attampt(start_message, attampt, end_message)
    puts "#{start_message} #{attampt} #{end_message}"
  end

  def show_list(list)
    puts list
  end

  def print_delimeter
    puts "================================"
  end

  def input_value
    gets.to_f
  end

  def input_index
    gets.to_i - 1
  end

  def input_string
    gets.chomp.downcase.capitalize
  end

  def show_stations(stations)
    stations.each.with_index(1) do |station, index|
      puts "#{index} : #{station.name}"
    end
  end

  def show_trains(trains)
    trains.each.with_index(1) do |train, index|
      number = train.number
      wagons = train.wagons.each.with_index(1).map do |wagon, index|
        "№: #{index}, Общий объем: #{wagon.amount}, "\
        "Свободно: #{wagon.free_places}, Занято: #{wagon.not_free_places}; "
      end
      manufacturer = train.manufacturer
      volum = "мест" if train.is_a?(PassengerTrain)
      volum = "м куб." if train.is_a?(CargoTrain)

      route =
        if train.route.nil?
          "нет маршрута"
        else
          start = train.route.start_point.name
          finish = train.route.end_point.name
          "#{start} - #{finish}"
        end

      train_info = "[ #{index} : №: #{number}, Тип: #{train.class}, " \
        "Производитель поезда: #{manufacturer}, " \
        "Вагоны (#{volum}): #{wagons} Маршрут: #{route} ]"
      puts train_info
    end
  end

  def show_train(train)
    train_info = "[ №: #{train.number}, Тип: #{train.class}, " \
        "Производитель поезда: #{train.manufacturer} ]"
      puts train_info
  end

  def show_routes(routes)
    routes.each.with_index(1) do |route, index|
      start = route.start_point.name
      finish = route.end_point.name
      station = route.show_stations
      route = "[ Индекс: #{index} : #{start} <=> #{finish}, " \
        "#{station.join(" <> ")} ]\n"
      puts route
      end
  end

  def show_trains_station(stations)
    stations.each do |station|
      trains = station.trains.map do |train|
        type = if train.is_a?(PassengerTrain)
          'PassengerTrain'
        elsif train.is_a?(CargoTrain)
          'CargoTrain'
        end
        "[ №: #{train.number}, Тип: #{type}, Количество вагонов: #{train.wagons.size}]"
      end
      station = "[ #{station.name} : #{trains.join(" | ")} ]"
      puts station
    end
  end

  def show_wagons(wagons)
    wagonsMap = wagons.each.with_index(1).map do |wagon, index|
      "Индекс вагона: #{index}, Общий объем: #{wagon.amount}, "\
      "Свободно: #{wagon.free_places}, Занято: #{wagon.not_free_places}; "
    end
    puts wagonsMap.join(", ")
  end
end
