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
  roots = []
  d = get_d(a, b, c).to_f

  if d == 0
    roots << quadr_formula(a,b,c)
  elsif d > 0
    roots << quadr_formula(a,b,c,Math.sqrt(d))
    roots << quadr_formula(a,b,c,-Math.sqrt(d))
  end
  roots
end

def get_d(a, b, c)
  b**2 - 4 * a * c
end

def quadr_formula(a,b,c,d = 0)
  (-b + d) / (2.0 * a)
end

def print_result(roots)
  message = "Решение: "
  if roots.length == 0
    message += "D < 0, корней нет."
  else
    message += roots.each_with_index.map { |el, i| "x#{i + 1} = #{el}" }.join(", ")
  end
  puts "#{message}"
end

input = user_input
roots = get_roots(input)
print_result(roots)
