goods = {}

def print_list_good(goods_with_price, total_price)
  puts "Все товары: #{goods_with_price}"
  puts "Стоимость всех товаров: #{total_price}"
end

def get_goods_with_price(goods)
  goods.each { |name, value| goods[name][:cost] = value[:price] * value[:quantity] }
end

def get_total_price(goods_with_price)
  goods_with_price.reduce(0) { |acc, (key, value)| acc + value[:cost] }
end

loop do
  puts "Введите название товара:"
  name = gets.chomp

  if name.dowcase == "stop"
    goods_with_price = get_goods_with_price(goods)
    total_price = get_total_price(goods_with_price)
    print_list_good(goods_with_price, total_price)
    break
  end

  goods[name] = {}
  puts "Введите цена за единицу товара:"
  goods[name][:price] = gets.chomp.to_f
  puts "Введите количество товара:"
  goods[name][:quantity] = gets.chomp.to_i
end
