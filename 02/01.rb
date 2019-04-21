def get_months(amount)
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

  months_days.each { |month, amount_days| puts month if amount_days == amount }
end

get_months(30)
