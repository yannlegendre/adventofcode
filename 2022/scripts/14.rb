require_relative '../../helpers/day'
require_relative '../../helpers/grid'

class Y2022Day14 < Day
  attr_reader :paths, :current
  include Grid
  class OutOfBounds < StandardError; end
  class ReachedTheTop < StandardError; end

  ENTRY_POINT = [500, 0]

  def initialize(*args, **kwargs)
    super(*args, **kwargs)
    initialize_grid(1000, 163)
    parse_input
    draw_rock_lines
  end

  def part1
    # draw_grid(skip_first_x_columns: 490, skip_after_col: 505)
    begin
      loop { flow_from(*ENTRY_POINT) }
    rescue OutOfBounds
      @grid.flatten.count { _1 == 'o' }
    end
  end

  def part2
    fill_horizontal(0..grid.first.size - 1, last_line_where_rock + 2)
    # draw_grid(skip_first_x_columns: 490, skip_after_col: 505)

    begin
      loop { flow_from(*ENTRY_POINT) }
    rescue OutOfBounds, ReachedTheTop
      @grid.flatten.count { _1 == 'o' }
    end
  end

  private

  def last_line_where_rock
    @grid.reverse.each_with_index do |line, index|
      next if line.all? { _1 == '.' }
      return @grid.size - index - 1
    end
  end

  def parse_input
    @paths = data.split("\n")
  end

  def draw_rock_lines
    @paths.each do |path_str|
      coords = path_str.split(' -> ')
      lines = coords.filter_map.with_index do |coord, index|
        next if index.zero?
        "#{coords[index - 1]} -> #{coord}"
      end

      lines.each do |line|
        source_coord, destination_coord = line.split(' -> ').map { _1.split(',').map(&:to_i) }
        fill_right_kind_of_line(source_coord, destination_coord)
      end
    end
  end

  def flow_from(x ,y)
    @current = { x: x, y: y }

    loop { can_move?(:down) ? (@current[:y] += 1) : break }

    if can_move?(:left)
      return flow_from(@current[:x] - 1, @current[:y] + 1)
    end
    if can_move?(:right)
      return flow_from(@current[:x] + 1, @current[:y] + 1)
    end
    draw_at_current
    raise ReachedTheTop if @current[:y] == 0
  end

  def can_move?(direction)
    case direction
    when :down
      if @current[:y] + 1 >= @grid.size
        raise OutOfBounds
      end
      @grid[@current[:y] + 1][@current[:x]] == '.'
    when :left
      @grid[@current[:y] + 1][@current[:x] - 1] == '.'
    when :right
      @grid[@current[:y] + 1][@current[:x] + 1] == '.'
    end
  end

  def draw_at_current
    @grid[current[:y]][current[:x]] = 'o'
  end

  def mode
    :string
  end
end
