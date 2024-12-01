require_relative 'base_map'

class SeedsSoil < BaseMap
  def initialize
    super('05/seeds_soil.txt')
  end

  private

  def source_name
    'seed'
  end
end
