times = File.read('06/time.txt').split(' ').map(&:to_i)
record_distances = File.read('06/distance.txt').split(' ').map(&:to_i)

map = times.each_with_index.inject({})  do |hash_map, pair|
  time, index = pair
  hash_map[time] = record_distances[index]
  hash_map
end

def speed_gained(time_held)
  time_held * 1
end

def total_distance_travelled(time_held, time_remaining)
  speed_gained(time_held) * time_remaining
end

def find_min_time_held(total_time, record_distance)
  time_remaining = total_time
  time_held = 0

  while total_distance_travelled(time_held, time_remaining) <= record_distance
    time_held += 1
    time_remaining -= 1
  end

  time_held
end

def find_max_time_held(total_time, record_distance)
  time_remaining = 0
  time_held = total_time

  while total_distance_travelled(time_held, time_remaining) <= record_distance
    time_held -= 1
    time_remaining += 1
  end

  time_held
end

def margin_for_error(arr_of_min_and_max)
  arr_of_min_and_max.map do |min, max|
    (min..max).size
  end.inject(:*)
end

min_and_maxes = map.map do |total_time, record_distance|
  min_time_held = find_min_time_held(total_time, record_distance)
  max_time_held = find_max_time_held(total_time, record_distance)

  [min_time_held, max_time_held]
end

pp margin_for_error(min_and_maxes)
