def user_input
  triangle = {}
  puts "Вычисляем площадь треугольника"
  puts "Введите основание в см:"
  triangle[:a] = gets.to_f
  puts "Введите высоту в см:"
  triangle[:h] = gets.to_f
  triangle
end

def get_square_triangle(a:, h:)
  (a * h) / 2
end

def print_square_triangle
  square_triangle = get_square_triangle user_input
  puts "Площадь треугольника #{square_triangle} см кв"
end

print_square_triangle