require_relative 'base_map'

class SoilFertilizer < BaseMap
  def initialize
    super('05/soil_fertilizer.txt')
  end

  private

  def source_name
    'soil'
  end
end
