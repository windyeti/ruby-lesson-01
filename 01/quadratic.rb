def user_input
  input = {}
  puts "Введите a"
  input[:a] = gets.chomp.to_f
  puts "Введите b"
  input[:b] = gets.chomp.to_f
  puts "Введите c"
  input[:c] = gets.chomp.to_f
  input
end

def get_roots(a:, b:, c:)
  result = {}
  d = get_D(a, b, c)

  if d == 0
    result[:x12] = quadr_formula(a,b,c)
  elsif d > 0
    result[:x1] = quadr_formula(a,b,c,Math.sqrt(d))
    result[:x2] = quadr_formula(a,b,c,-Math.sqrt(d))
  else
    result["D"] = "D < 0, корней нет."
  end
  result
end

def get_D(a, b, c)
  b**2 - 4*a*c
end

def quadr_formula(a,b,c,d = 0)
  (-1*b + d) / (2 * a)
end

def print_result
  roots = get_roots user_input
  roots_for_print = roots.map do |key, value|
    if key != 'D'
      "#{key} = #{value}"
    else
      "#{value}"
    end
  end
  puts "Решение: #{roots_for_print.join(", ")}"
end

print_result