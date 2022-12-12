require_relative '../../helpers/day'

class Y2022Day12 < Day
  attr_accessor :grid

  def initialize(*args, **kwargs)
    super(*args, **kwargs)
    parse_input
    @paths
  end

  def part1
    grid.each_with_index do |line, y|
      line.each_with_index do |cell, x|
        cell.explore
      end
    end
  end

  def part2

  end

  private

  def max_x
    @max_x ||= grid.first.count
  end

  def max_y
    @max_y ||= grid.count
  end

  def shortest_path_to(cell)
    binding.pry unless @stop
  end

  def parse_input
    @grid =
    data.split("\n").map.with_index do |line, num_ligne|
      line.chars.map.with_index do |letter, num_col|
        Cell.new(num_col, num_ligne, letter, grid)
      end
    end
  end

  def mode
    :string
  end

  def path(x,y)
    return nil if x >= x_max || y >= ymax

    grid[y][x].path
  end

  def path_size(x,y)
    path(x,y).size
  end

  def value(x, y)
    return nil if x >= x_max || y >= ymax

    grid[y][x].value
  end

  def left(x, y)
    value(x - 1, y)
  end

  def right(x, y)
    value(x + 1, y)
  end

  def up(x, y)
    value(x, y + 1)
  end

  def down(x, y)
    value(x, y - 1)
  end
end

class Cell
  attr_reader :coord

  def initialize(x, y, value, grid)
    @x = x
    @y = y
    @value = value
    @possible_destinations = []
    @explored = false
    @grid = grid
  end

  def coord
    [x, y]
  end

  def explore

  end
end