a_u = ["a", "e", "i", "o", "u"]
alf = ('a'..'z').to_a
vowels_number = alf.each_with_index.map { |ch, ind| { ch => ind + 1 } if a_u.include?(ch) }.compact
puts "#{vowels_number}"
