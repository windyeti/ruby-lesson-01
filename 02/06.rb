goods = {}

def print_list_good(goods)
  puts "Все товары: #{goods}"
  list_price = get_list_prices(goods)
  puts "Стоимость: #{list_price.map { |g| "#{g[0]} = #{g[1]}" }.join(', ')}"
  puts "Стоимость всех товаров: #{total_price(list_price)}"
end

def get_list_prices(goods)
  goods.each.map { |g| [g[0], g[1][:price] * g[1][:quantity]] }
end

def total_price(list_price)
  list_price.reduce(0) { |acc, g| acc + g[1] }
end

loop do
  puts "Введите название товара:"
  name = gets.chomp

  if name == "stop"
    print_list_good(goods)
    break
  end

  goods[name] = {}
  puts "Введите цена за единицу товара:"
  goods[name][:price] = gets.chomp.to_f
  puts "Введите количество товара:"
  goods[name][:quantity] = gets.chomp.to_i
end
