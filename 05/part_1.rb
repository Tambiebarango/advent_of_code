require_relative('converter')

seeds = File.read('05/seeds.txt').split(' ').map(&:to_i)

result = seeds.map { |seed| Converter.convert_seed_to_location(seed) }
pp result.min
