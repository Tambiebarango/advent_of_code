require_relative 'base_map'

class TemperatureHumidity < BaseMap
  def initialize
    super('05/temperature_humidity.txt')
  end

  private

  def source_name
    'temperature'
  end
end
