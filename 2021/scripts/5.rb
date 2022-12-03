require_relative '../../helpers/day'

class Y2021Day5 < Day
  def initialize(*args, **kwargs)
    super(*args, **kwargs)
  end

  def part1
    lines_data.each { draw_right_kind_of_line(*_1, only_straight: true)}
    count_dangerous_spots
  end

  def part2
    lines_data.each { draw_right_kind_of_line(*_1)}
    count_dangerous_spots
  end

  private

  def count_dangerous_spots
    cells.flatten.count { _1.number > 1 }
  end

  def cells
    @cells ||= (0..999).map do |x|
      (0..999).map do |y|
        Cell.new(x, y)
      end
    end
  end

  def lines_data
    data.split("\n").map do |raw_line|
      raw_line.split(' -> ').map { _1.split(',').map(&:to_i) }
    end
  end

  def draw_right_kind_of_line(origin_coord, destination_coord, only_straight: false)
    x_is_fixed = origin_coord.first == destination_coord.first
    y_is_fixed = origin_coord.last == destination_coord.last
    if x_is_fixed
      fixed_x = origin_coord.first
      sorted_val = [origin_coord.last, destination_coord.last].sort
      y_range = (sorted_val.first)..(sorted_val.last)
      draw_vertical(y_range, fixed_x)
    elsif y_is_fixed
      fixed_y = origin_coord.last
      sorted_val = [origin_coord.first, destination_coord.first].sort
      x_range = (sorted_val.first)..(sorted_val.last)
      draw_horizontal(x_range, fixed_y)
    else
      return if only_straight

      sorted_x = reversible_range_array(origin_coord.first, destination_coord.first)
      sorted_y = reversible_range_array(origin_coord.last, destination_coord.last)
      draw_diagnonal(sorted_x, sorted_y)
    end
  end

  def draw_vertical(y_range, x)
    y_range.each do |y|
      cells[x][y].cross!
    end
  end

  def draw_horizontal(x_range, y)
    x_range.each do |x|
      cells[x][y].cross!
    end
  end

  def draw_diagnonal(x_range, y_range)
    x_range.each_with_index do |x, index|
      cells[x][y_range[index]].cross!
    end
  end

  def mode
    :string
  end

  def reversible_range_array(first, last)
    if last >= first
      (first..last).to_a
    else
      (last..first).to_a.reverse
    end
  end
end

class Cell
  attr_reader :number, :x, :y

  def initialize(x, y)
    @number = 0
    @x = x
    @y = y
  end

  def cross!
    @number += 1
  end
end
