require_relative 'base_map'

class WaterLight < BaseMap
  def initialize
    super('05/water_light.txt')
  end

  private

  def source_name
    'water'
  end
end
