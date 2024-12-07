# frozen_string_literal: true

require_relative "../util.rb"
require "pry"
require "pry-nav"
require "set"

class Day6
  def initialize(env)
    @inputs = Util.load_inputs(env, "06").split("\n")
    @inputs << "$" * (@inputs.first.chars.size + 2)
    @inputs.insert(0, "$" * (@inputs.first.chars.size + 2))
    @grid = {}

    input_length = @inputs.size
    @inputs.each_with_index do |line, row|
      line =  "$#{line}$" unless row == 0 || row == input_length - 1

      line.chars.each_with_index do |char, column|
        @grid["#{column}, #{row}"] = char
      end
    end
  end

  def part_1
    @guard_x, @guard_y = @grid.key("^").split(",").map(&:to_i)
    @facing = :up
    @hash_found = false
    @edge_found = false

    loop do
      move until @hash_found || @edge_found
      break if @edge_found
      turn if @hash_found
    end

    @grid.count { |_, v| v == "X" }
  end

  def part_2
    @grid2 = @grid.dup

    part_1 # to mark the X locations where the guard walks on

    loop_counts = 0 # track loops sighted
    obstacles = []
    xs = @grid.select { |_, v| v == "X" }.keys

    xs.each do |coordinates_of_x|
      facing = :up
      @hash_found = false
      @edge_found = false
      @repeated_step = false
      guard_x, guard_y = @grid2.key("^").split(",").map(&:to_i)

      visited = Set.new
      visited.add([guard_x, guard_y, facing])

      set_obstacle(@grid2, coordinates_of_x) do |temp_grid|
        loop do
          guard_x, guard_y = move2(temp_grid, facing, guard_x, guard_y)

          if @edge_found
            xs << "#{guard_x}, #{guard_y}" unless xs.include?("#{guard_x}, #{guard_y}") # try edges for obstacles
            break
          end

          facing = turn2(facing) if @hash_found

          @repeated_step = visited.include? [guard_x, guard_y, facing]
          if @repeated_step
            loop_counts += 1
            puts "\n\nnew loop count: #{loop_counts}\n"
            obstacles << coordinates_of_x
            puts "obstacle count is now: #{obstacles.size}\n"
            break
          else
            visited.add([guard_x, guard_y, facing])
          end
        end
      end
    end

    obstacles.size
  end

  private

  def set_obstacle(grid, coordinates_of_x)
    temp = grid[coordinates_of_x]
    grid[coordinates_of_x] = "#"
    yield(grid)
    grid[coordinates_of_x] = temp
  end


  def move2(grid, facing, x, y)
    case facing
    when :up # ^
      if grid["#{x}, #{y - 1}"] == "#"
        @hash_found = true
      elsif grid["#{x}, #{y - 1}"] == "$"
        @edge_found = true
      else
        y -= 1
      end
    when :right # >
      if grid["#{x + 1}, #{y}"] == "#"
        @hash_found = true
      elsif grid["#{x + 1}, #{y}"] == "$"
        @edge_found = true
      else
        x += 1
      end
    when :down # v
      if grid["#{x}, #{y + 1}"] == "#"
        @hash_found = true
      elsif grid["#{x}, #{y + 1}"] == "$"
        @edge_found = true
      else
        y += 1
      end
    when :left # <
      if grid["#{x - 1}, #{y}"] == "#"
        @hash_found = true
      elsif grid["#{x - 1}, #{y}"] == "$"
        @edge_found = true
      else
        x -= 1
      end
    end

    [x, y]
  end

  def turn2(facing)
    case facing
    when :up
      facing = :right
    when :right
      facing = :down
    when :down
      facing = :left
    when :left
      facing = :up
    end

    @hash_found = false
    facing
  end

  def move
    case @facing
    when :up # ^
      if @grid["#{@guard_x}, #{@guard_y - 1}"] == "#"
        @hash_found = true
      elsif @grid["#{@guard_x}, #{@guard_y - 1}"] == "$"
        @grid["#{@guard_x}, #{@guard_y - 1}"] = "X"
        @edge_found = true
      else
        @grid["#{@guard_x}, #{@guard_y - 1}"] = "^"
        @grid["#{@guard_x}, #{@guard_y}"] = "X"
        @guard_y -= 1
      end
    when :right # >
      if @grid["#{@guard_x + 1}, #{@guard_y}"] == "#"
        @hash_found = true
      elsif @grid["#{@guard_x + 1}, #{@guard_y}"] == "$"
        @grid["#{@guard_x + 1}, #{@guard_y}"] = "X"
        @edge_found = true
      else
        @grid["#{@guard_x + 1}, #{@guard_y}"] = "^"
        @grid["#{@guard_x}, #{@guard_y}"] = "X"
        @guard_x += 1
      end
    when :down # v
      if @grid["#{@guard_x}, #{@guard_y + 1}"] == "#"
        @hash_found = true
      elsif @grid["#{@guard_x}, #{@guard_y + 1}"] == "$"
        @grid["#{@guard_x}, #{@guard_y + 1}"] = "X"
        @edge_found = true
      else
        @grid["#{@guard_x}, #{@guard_y + 1}"] = "^"
        @grid["#{@guard_x}, #{@guard_y}"] = "X"
        @guard_y += 1
      end
    when :left # <
      if @grid["#{@guard_x - 1}, #{@guard_y}"] == "#"
        @hash_found = true
      elsif @grid["#{@guard_x - 1}, #{@guard_y}"] == "$"
        @grid["#{@guard_x - 1}, #{@guard_y}"] = "X"
        @edge_found = true
      else
        @grid["#{@guard_x - 1}, #{@guard_y}"] = "^"
        @grid["#{@guard_x}, #{@guard_y}"] = "X"
        @guard_x -= 1
      end
    end
  end

  def turn
    case @facing
    when :up
      @facing = :right
    when :right
      @facing = :down
    when :down
      @facing = :left
    when :left
      @facing = :up
    end

    @hash_found = false
  end
end
