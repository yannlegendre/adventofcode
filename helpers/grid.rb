module Grid
  attr_reader :grid

  def initialize_grid(x_size, y_size, default_value = '.')
    @grid = Array.new(y_size) { Array.new(x_size, default_value) }
  end

  def draw_grid(skip_first_x_columns: nil, skip_after_col: nil)
    draw_grid_headers(skip_first_x_columns: skip_first_x_columns, skip_after_col: skip_after_col)

    @grid.each_with_index do |row, row_index|
      print("%02d " % row_index)
      row.each_with_index do |cell, col_index|
        next if skip_first_x_columns && col_index < skip_first_x_columns || skip_after_col && col_index > skip_after_col

        print cell
      end
      puts
    end
    return nil
  end

  def draw_grid_headers(skip_first_x_columns: nil, skip_after_col: nil)
    num_col = @grid.first.size
    num_char = num_col.to_s.size
    num_char.times do |char_index|
      print '   '
      num_col.times do |col_index|
        next if skip_first_x_columns && col_index < skip_first_x_columns || skip_after_col && col_index > skip_after_col

        print col_index.to_s[char_index].to_i
      end
      puts
    end
    return nil
  end

  def fill_right_kind_of_line(origin_coord, destination_coord)
    x_is_fixed = origin_coord.first == destination_coord.first
    y_is_fixed = origin_coord.last == destination_coord.last
    if x_is_fixed
      fixed_x = origin_coord.first
      sorted_val = [origin_coord.last, destination_coord.last].sort
      y_range = (sorted_val.first)..(sorted_val.last)
      fill_vertical(y_range, fixed_x)
    elsif y_is_fixed
      fixed_y = origin_coord.last
      sorted_val = [origin_coord.first, destination_coord.first].sort
      x_range = (sorted_val.first)..(sorted_val.last)
      fill_horizontal(x_range, fixed_y)
    end
  end

  def fill_vertical(y_range, x)
    y_range.each do |y|
      grid[y][x] = '#'
    end
  end

  def fill_horizontal(x_range, y)
    x_range.each do |x|
      grid[y][x] = '#'
    end
  end

  def id(x, y)
    (x + y * self.class::POINT_CONST)
  end

  def cell(id)
    {
      x: id % self.class::POINT_CONST,
      y: id / self.class::POINT_CONST,
    }
  end
end