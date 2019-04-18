def user_input
  puts "Вы готовы узнать Ваш идельный вес? (Нажмите Ввод)"
  user_ready = gets
  if user_ready == "\n"
    user_params = {}
    puts "Ваше имя?"
    user_params[:name] = gets.chomp
    puts "Ваш рост в см?"
    user_params[:height] = gets.to_i
    user_params
  else
    puts "Okey! Вы пока не готовы)"
  end
end

def ideal_weight(height)
  height - 110
end

def print_pretty_weight (name:, height:)
  weight = ideal_weight(height)
  puts "#{name}! Ваш идеальный вес #{weight}кг"
end

input = user_input
print_pretty_weight(user_input)
