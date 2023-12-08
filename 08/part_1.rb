require 'pry'
require 'pry-nav'

network_input = File.read('08/network.txt')
direction_input = File.read('08/directions.txt')


map = network_input.split("\n").inject({}) do |hash, line|
  key, left, right = line.scan(/[a-z]+/i)
  hash[key] = { 'L' => left, 'R' => right }
  hash
end

z_found = false
next_step = map.find { |k, _v| k == 'AAA' }[1]
directions = direction_input.strip.split('')
step_count = 1

until z_found
  directions.each do |d|
    if next_step[d] == 'ZZZ'
      z_found = true
      break
    else
      next_step = map[next_step[d]]
      step_count += 1
    end
  end
end

pp step_count
