require_relative 'base_map'

class HumidityLocation < BaseMap
  def initialize
    super('05/humidity_location.txt')
  end

  private

  def source_name
    'humidity'
  end
end
