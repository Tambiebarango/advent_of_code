require_relative 'converter'
require_relative 'humidity_location'

input = File.read('05/seeds.txt').split('|').map(&:strip)
seeds = input.map { |info| info.split(' ').map(&:to_i) }

result = seeds.map do |start, length|
  Converter.convert_seed_range(start, length)
end

pp result
