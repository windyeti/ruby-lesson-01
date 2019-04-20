def input_date
  puts "Введите дату в формате: DD/MM/YYYY"
  gets.split('/').map(&:to_i)
end

def get_numberic_day(day:, month:, year:)
  number = day
  number += get_day_from_month(month)
  number += 1 if long_year?(year)
  number
end

def get_day_from_month(month)
  days = 0
  months_days =
    {'январь' => 31, 'февраль' => 28, 'март' => 31,
    'апрель' => 30, 'май' => 31, 'июнь' => 30, 'июль' => 31,
    'август' => 31, 'сентябрь' => 30, 'октябрь' => 31,
    'ноябрь' => 30, 'декабрь' => 31}
  months_days.to_a.each_with_index.map {|v, i| days += v[1] if i < month - 1 }
  days
end

def long_year?(year)
  if year % 4 == 0
    if year % 100 == 0
      if year % 400 == 0
        plus_one = true
      else
        plus_one = false
      end
    else
      plus_one = true
    end
  else
    plus_one = false
  end
end

def print_numberic_day(number, date)
  date_format = date.join("/")
  puts "Указанная дата #{date_format} от начала года #{number} день"
end

date = input_date
numberic_day = get_numberic_day(day: date[0], month: date[1], year: date[2])
print_numberic_day(numberic_day, date)
