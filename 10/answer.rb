require 'pry'
require 'pry-nav'

INPUT = File.read('10/input.txt').split("\n")

PIPE_INFO = {
  '|': {
    moves: %w[up down],
    'up': { x: 0, y: -1 },
    'down': { x: 0, y: 1 }
  },
  '-': {
    moves: %w[right left],
    'right': { x: 1, y: 0 },
    'left': { x: -1, y: 0 }
  },
  'L': {
    moves: %w[up right],
    'down': { x: 1, y: 1 },
    'left': { x: -1, y: -1 }
  },
  'J': {
    moves: %w[up left],
    'down': { x: -1, y: 1 },
    'right': { x: 1, y: -1 }
  },
  '7': {
    moves: %w[down left],
    'up': { x: -1, y: -1 },
    'right': { x: 1, y: 1 }
  },
  'F': {
    moves: %w[down right],
    'up': { x: 1, y: -1 },
    'left': { x: -1, y: 1 }
  },
  'S': { moves: %w[down up right left] },
  '.': { moves: [] }
}.freeze

DIRECTION_INFO = {
  'up': { x: 0, y: -1 },
  'down': { x: 0, y: 1 },
  'left': { x: -1, y: 0 },
  'right': { x: 1, y: 0 }
}.freeze

FLOOR_MAP = (0..INPUT.length - 1).each_with_object({}) do |y_index, map|
  pipes = INPUT[y_index].split('')
  pipes.each_with_index do |pipe, x_index|
    map["#{x_index},#{y_index}"] = { 'pipe' => pipe }
  end
end.freeze

START = FLOOR_MAP.find { |_, v| v['pipe'] == 'S' }[0]

def math_for(direction)
  DIRECTION_INFO[direction.to_sym]
end

def travel(from, direction)
  x, y = from.split(',').map(&:to_i)
  math = math_for(direction)

  "#{x + math[:x]},#{y + math[:y]}"
end

def get_valid_directions(from)
  PIPE_INFO[FLOOR_MAP[from]['pipe'].to_sym][:moves].select do |direction|
    coordinates = travel(from, direction)
    next unless FLOOR_MAP[coordinates]
    PIPE_INFO[FLOOR_MAP[coordinates]['pipe'].to_sym].key?(direction.to_sym)
  end.map(&:to_s)
end

def chart_next(start, steps_start = 0)
  return if start.nil?

  steps_start += 1

  vds = get_valid_directions(start)
  return if vds.empty?

  next_direction =
    if vds.size > 1
      vds.find do |d|
        next_coordinate = travel(start, d)
        next_coordinate != START && FLOOR_MAP[next_coordinate]['steps'].nil?
      end
    else
      vds.first
    end

  next_coordinate = travel(start, next_direction)

  return if next_coordinate == START || FLOOR_MAP[next_coordinate].key?('steps')

  FLOOR_MAP[next_coordinate]['steps'] = steps_start

  chart_next(next_coordinate, steps_start)
end

chart_next(START)

pp (FLOOR_MAP.count { |_k, v| v['steps'] } + 1) / 2
# pp FLOOR_MAP.max_by { |_k, v| v['steps'].to_i }[1]['steps']
