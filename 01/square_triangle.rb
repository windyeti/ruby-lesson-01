def user_input
  triangle = {}
  puts "Вычисляем площадь треугольника"
  puts "Введите основание в см:"
  triangle[:base] = gets.to_f
  puts "Введите высоту в см:"
  triangle[:height] = gets.to_f
  triangle
end

def get_area_triangle(base: input[:base], height: input[:height])
  0.5 * base * height
end

def print_area_triangle(area_triangle)
  puts "Площадь треугольника #{area_triangle} см кв"
end

input = user_input
area_triangle = get_area_triangle(input)
print_area_triangle(area_triangle)
