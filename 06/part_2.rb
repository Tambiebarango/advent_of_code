time = File.read('06/time.txt').split(' ').join('').to_i
record_distance = File.read('06/distance.txt').split(' ').join('').to_i

pp time
pp record_distance

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

def margin_for_error(min, max)
  (min..max).size
end

min_time_held = find_min_time_held(time, record_distance)
max_time_held = find_max_time_held(time, record_distance)


pp margin_for_error(min_time_held, max_time_held)
