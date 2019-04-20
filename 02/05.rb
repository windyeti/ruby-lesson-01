def input_date
  puts "Введите дату в формате: DD/MM/YYYY"
  gets.split('/').map(&:to_i)
end

def get_numberic_day(day:, month:, year:)
  days_amount = []
  days_amount[0] = day
  days_amount[1] = get_day_from_month(month)
  days_amount[2] = long_year?(year) ? 1 : 0
  days_amount.reduce { |acc, i| acc + i }
end

def get_day_from_month(month)
  days = 0
  months_days = {
    january: 31,
    february: 28,
    march: 31,
    april: 30,
    may: 31,
    june: 30,
    july: 31,
    august: 31,
    september: 30,
    october: 31,
    november: 30,
    december: 31
  }
  months_days.to_a.each_with_index.map {|v, i| days += v[1] if i < month - 1 }
  days
end

def long_year?(year)
  (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
end

def print_numberic_day(amount, date)
  date_format = date.join("/")
  puts "Указанная дата #{date_format} от начала года #{amount} день"
end

date = input_date
numberic_day = get_numberic_day(day: date[0], month: date[1], year: date[2])
print_numberic_day(numberic_day, date)
