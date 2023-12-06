require_relative 'base_map'

class LightTemperature < BaseMap
  def initialize
    super('05/light_temperature.txt')
  end

  private

  def source_name
    'light'
  end
end
