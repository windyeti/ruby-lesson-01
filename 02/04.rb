vowels = %w(a e i o u)
alphabet = ('a'..'z').to_a
vowels_number = {}
alphabet.each.with_index(1) do |letter, index|
  vowels_number[letter] = index if vowels.include?(letter)
end
puts vowels_number
