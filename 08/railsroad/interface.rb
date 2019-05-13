class Interface
  TITLE = "\nВыберите ( пунк ) действия:\n".freeze
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
  ].freeze
  QUESTION_STATION_NAME = "Введите название станции:".freeze
  QUESTION_INDEX_STATION = "Введите индекс станции:".freeze
  QUESTION_TRAIN_NUMBER = "Введите номер поезда:".freeze
  QUESTION_TRAIN_MANUFACTURER = "Введите производителя поезда:".freeze
  QUESTION_TRAIN_TYPE = "Введите тип поезда " \
  "(passenger => 1 or cargo => 2):".freeze
  QUESTION_INDEX_TRAIN = "Введите индекс поезда:".freeze
  QUESTION_START_STATION = "Введите индекс начальной станции:".freeze
  QUESTION_END_STATION = "Введите индекс конечной станции:".freeze
  QUESTION_INDEX_ROUTE = "Введите номер маршрута:".freeze
  QUESTION_WAGON_TYPE = "Введите тип вагона (passenger or cargo):".freeze
  QUESTION_WAGON_MANUFACTURER = "Введите производителя вагона:".freeze
  LIST_STATION_NAME = "Список созданных станций:".freeze
  LIST_TRAIN = "Список созданных поездов:".freeze
  LIST_ROUTE = "Список созданных маршрутов:".freeze
  LIST_WAGON = "Список вагонов:".freeze
  LIST_TRAIN_IN_STATION = "Список поездов на станции:".freeze

  NOT_CORRECT_NAME = "Name not correct!!!".freeze
  NOT_CORRECT_ARGUMENT = "Argument not correct!!! Attampt ".freeze
  OF_ATTAMPTS = " of 6".freeze
  QUESTION_VALUE_WAGON = "Вместимость вагона:".freeze
  QUESTION_WAGON_VALUE = "Сколько добавить:".freeze
  QUESTION_INDEX_WAGON = "Введите № вагона:".freeze

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
      wagons = train.wagons.each.with_index(1).map do |wagon, index_wagon|
        "№: #{index_wagon}, Общий объем: #{wagon.amount}, "\
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
        "#{station.join(' <> ')} ]\n"
      puts route
    end
  end

  def show_trains_station(stations)
    stations.each do |station|
      trains = station.trains.map do |train|
        type =
          if train.is_a?(PassengerTrain)
            'PassengerTrain'
          elsif train.is_a?(CargoTrain)
            'CargoTrain'
          end
        "[ №: #{train.number}, Тип: #{type}, " \
        "Количество вагонов: #{train.wagons.size}]"
      end
      station = "[ #{station.name} : #{trains.join(' | ')} ]"
      puts station
    end
  end

  def show_wagons(wagons)
    wagons_map = wagons.each.with_index(1).map do |wagon, index|
      "Индекс вагона: #{index}, Общий объем: #{wagon.amount}, "\
      "Свободно: #{wagon.free_places}, Занято: #{wagon.not_free_places}; "
    end
    puts wagons_map.join(", ")
  end
end
