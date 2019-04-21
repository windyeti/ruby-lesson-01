def input_date
  puts "Введите дату в формате: DD/MM/YYYY"
  gets.split('/').map(&:to_i)
end

def get_numberic_day(day:, month:, year:)
  days_amount = day
  days_amount += get_day_from_month(month)
  days_amount += 1 if leap_year?(year) && month > 1
end

def get_day_from_month(month)
  month -= 1
  months_days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  months_days.take(month).reduce(0, &:+)
end

def leap_year?(year)
  (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
end

def print_numberic_day(amount, date)
  date_format = date.join("/")
  puts "Указанная дата #{date_format} от начала года #{amount} день"
end

date = input_date
numberic_day = get_numberic_day(day: date[0], month: date[1], year: date[2])
print_numberic_day(numberic_day, date)
