require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'wagon'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'rails_road'

rr = RailsRoad.new
# rr.seed

loop do
puts "\nВыберите ( пунк ) действия (выход: 's'):\n__________________________________________
\n ( 1 ) Создать станцию
Список созданных: #{rr.stations.any? ? rr.show_list_station : 'еще не созданы'}
\n ( 2 ) Создать поезд
Список созданных: #{rr.trains.any? ? rr.show_list_trains : 'еще не созданы'}
\n ( 3 ) Создать маршрут
Список созданных: #{rr.routes.any? ? rr.show_list_routes : 'еще не созданы'}
\n ( 4 ) Добавить станцию в маршрут
\n ( 5 ) Удалить станцию из маршрута
\n ( 6 ) Назначать маршрут поезду
\n ( 7 ) Добавить вагон к поезду
\n ( 8 ) Удалить вагон у поезда
\n ( 9 ) Переместить поезд вперед
\n ( 10 ) Переместить поезд назад
\n ( 11 ) Список станций
\n ( 12 ) Список поездов на станции
"
action = gets.chomp
  case action
  when "1"
    puts "Введите имя станции:"
    name_station = gets.chomp.downcase.capitalize
    rr.add_station(name_station)
  when "2"
    puts "Введите номер поезда:"
    number = gets.chomp.to_i
    puts "Введите тип поезда (passenger or cargo):"
    type_train = gets.chomp.downcase
    rr.add_train(number, type_train)
  when "3"
    puts "Введите начальную станцию маршрута:"
    start_station = gets.chomp.downcase.capitalize
    puts "Введите конечную станцию маршрута:"
    end_station = gets.chomp.downcase.capitalize
    rr.add_route(start_station, end_station)
  when "4"
    puts "Введите номер маршрута:"
    index_route = gets.chomp.to_i
    puts "Введите название станции:"
    name_station = gets.chomp.downcase.capitalize
    rr.add_station_into_route(index_route, name_station)
  when "5"
    puts "Введите номер маршрута:"
    index_route = gets.chomp.to_i
    puts "Введите название станции:"
    name_station = gets.chomp.downcase.capitalize
    rr.delete_station_in_route(index_route, name_station)
  when "6"
    puts "Введите номер маршрута:"
    index_route = gets.chomp.to_i
    puts "Введите номер поезда:"
    number_train = gets.chomp.to_i
    rr.add_route_to_train(index_route, number_train)
  when "7"
    puts "Введите номер поезда:"
    number_train = gets.chomp.to_i
    puts "Введите тип вагона (passenger or cargo):"
    type_wagon = gets.chomp.downcase
    rr.add_wagon_to_train(number_train, type_wagon)
  when "8"
    puts "Введите номер поезда:"
    number_train = gets.chomp.to_i
    rr.delete_wagon_from_train(number_train)
  when "9"
    puts "Введите номер поезда:"
    number_train = gets.chomp.to_i
    rr.to_next_station(number_train)
  when "10"
    puts "Введите номер поезда:"
    number_train = gets.chomp.to_i
    rr.to_previous_station(number_train)
  when "11"
    puts rr.show_list_station
  when "12"
    rr.show_list_train_in_station
  when "s"
    # puts "You press 's'"
    break
  end
end
