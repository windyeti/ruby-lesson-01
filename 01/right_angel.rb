def user_input
  puts "Введите размеры трех сторон через пробел\n
  Например, 12 7 19"
  size_sides = gets
end    

def get_message_about_triangel(size_sides)
  message = []
  sides = size_sides.split(" ").map { |s| s.to_f }.sort

  if is_right_angel? sides
      message << "прямоугольный"
      message << "равнобедренный" if is_two_equil? sides
  elsif is_all_equil? sides
      message << "равносторонний"
      message << "равнобедренный"
      message << "но не прямоугольный"
  elsif is_two_equil? sides
      message << "равнобедренный"
      message << "но не прямоугольный"
  else
      message << "не прямоугольный"
  end
  message
end

def is_all_equil? sides
  sides[0] == sides[1] && sides[0] == sides[2]
end

def is_two_equil? sides
  sides[0] == sides[1] || sides[0] == sides[2] || sides[1] == sides[2]
end

def is_right_angel? sides
  sides[0]**2 + sides[1]**2 == sides[2]**2
end

def print_info_triangel
  puts "Треугольник по вашим размерам #{get_message_about_triangel(user_input).join(', ')}"
end

print_info_triangel

# puts "#{get_message_about_triangel("3 4 5").join(', ')}"
# puts "#{get_message_about_triangel("8 9 8").join(', ')}"
# puts "#{get_message_about_triangel("8 9 7").join(', ')}"
# puts "#{get_message_about_triangel("7 7 7")}"