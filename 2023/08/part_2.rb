require 'pry'
require 'pry-nav'

network_input = File.read('08/network.txt')
direction_input = File.read('08/directions.txt')


map = network_input.split("\n").inject({}) do |hash, line|
  key, left, right = line.scan(/[a-z|0-9]+/i)
  hash[key] = { 'L' => left, 'R' => right }
  hash
end

starts = map.find_all { |k, _v| k.match?(/[A-Z|0-9]{2}A/i) }
directions = direction_input.strip.split('')

pp starts
starts.each do |start|
  key, next_step = start
  pp key
  z_found = false
  step_count = 1

  until z_found
    directions.each do |d|
      if next_step[d].match?(/[a-z|0-9]{2}Z/i)
        z_found = true
        break
      else
        next_step = map[next_step[d]]
        step_count += 1
      end
    end
  end

  pp step_count
  pp next_step
end

# Calculate the LCM with the returned step counts
