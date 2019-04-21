next_number = 1
sequence_fiboanachi = [0, 1]

while next_number <= 100 do
  sequence_fiboanachi << next_number
  next_number = sequence_fiboanachi[-1] + sequence_fiboanachi[-2]
end

puts sequence_fiboanachi.join(", ")
