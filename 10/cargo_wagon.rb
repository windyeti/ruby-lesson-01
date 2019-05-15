class CargoWagon < Wagon
  validate :amount, :presence
  validate :amount, :type, Float
  validate :amount, :format, /^[0-9]+.[0-9]+$/
end
