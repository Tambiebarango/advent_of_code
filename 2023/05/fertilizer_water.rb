require_relative 'base_map'

class FertilizerWater < BaseMap
  def initialize
    super('05/fertilizer_water.txt')
  end

  private

  def source_name
    'fertilizer'
  end
end
