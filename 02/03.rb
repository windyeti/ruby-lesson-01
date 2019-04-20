current_max = 1
sequence_fiboanachi = [0, 1]

while (current_max = sequence_fiboanachi[-1] + sequence_fiboanachi[-2]) <= 100 do
  sequence_fiboanachi << current_max
end

puts sequence_fiboanachi.join(", ")
