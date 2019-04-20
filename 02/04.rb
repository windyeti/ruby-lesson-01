a_u = %w(a e i o u)
alphabet = ('a'..'z').to_a
vowels_number = {}
alphabet.each.with_index(1) { |letter, index| vowels_number[letter] = index if a_u.include?(letter) }
puts vowels_number
