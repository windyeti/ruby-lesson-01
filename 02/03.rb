last_at_sequence_fiboanachi = 1
sequence_fiboanachi = [0, 1]

while last_at_sequence_fiboanachi <= 100 do
  sequence_fiboanachi << last_at_sequence_fiboanachi
  last_at_sequence_fiboanachi = sequence_fiboanachi[-1] + sequence_fiboanachi[-2]
end

puts sequence_fiboanachi.join(", ")
