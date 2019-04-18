def user_input
  puts "Введите размеры трех сторон через пробел\nНапример, 12 7 19"
  size_sides = gets.split(" ").map { |s| s.to_f }.sort
end    

def get_message_about_triangel(sides)
  message = []

  if right_angel?(sides)
    message << "прямоугольный"
    message << "равнобедренный" if two_equil?(sides)
  elsif all_equil?(sides)
    message << "равносторонний"
    message << "равнобедренный"
    message << "но не прямоугольный"
  elsif two_equil?(sides)
    message << "равнобедренный"
    message << "но не прямоугольный"
  else
    message << "не прямоугольный"
  end
  message
end

def all_equil?(sides)
  sides[0] == sides[1] && sides[0] == sides[2]
end

def two_equil?(sides)
  sides[0] == sides[1] || sides[0] == sides[2] || sides[1] == sides[2]
end

def right_angel?(sides)
  sides[0]**2 + sides[1]**2 == sides[2]**2
end

def print_triangel(message)
  message_for_print = message.join(', ')
  puts "Треугольник по вашим размерам #{message_for_print}"
end

input = user_input
message = get_message_about_triangel(input)
print_triangel(message)
