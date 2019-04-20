n = 3
fibo = [0, 1]

until n > 100 do
  fibo << (fibo.last + fibo[-2])
  n += 1
end

puts "#{fibo} >>> #{fibo.size}"
