class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end

  def delete_train(train)
    @trains.delete(train)
  end

private

  def get_trains_of_type(type)
    @trains.select { |train| train.type == type }.size
  end
end
