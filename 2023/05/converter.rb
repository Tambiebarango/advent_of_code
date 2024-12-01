require_relative 'seeds_soil'
require_relative 'soil_fertilizer'
require_relative 'fertilizer_water'
require_relative 'water_light'
require_relative 'light_temperature'
require_relative 'temperature_humidity'
require_relative 'humidity_location'
require 'pry'
require 'pry-nav'
class Converter
  class << self
    def convert_seed_to_location(seed)
      services.inject(seed) do |last_result, service|
        service.new.lookup(last_result)
      end
    end

    def convert_seed_range(seed, range)
      new_range = range
      services.inject(seed) do |last_result, service|
        mins = service.new.find_min_from_range(last_result, new_range)
        new_range = mins.max - mins.min
        mins.min
      end
    end

    def services
      [
        SeedsSoil,
        SoilFertilizer,
        FertilizerWater,
        WaterLight,
        LightTemperature,
        TemperatureHumidity,
        HumidityLocation
      ]
    end
  end
end
