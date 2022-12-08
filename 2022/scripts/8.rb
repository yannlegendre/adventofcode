require_relative '../../helpers/day'

class Y2022Day8 < Day
  attr_reader :rows, :columns, :size

  def initialize(*args, **kwargs)
    super(*args, **kwargs)

    parse_input
  end


  def part1
    visible_count = 0
    visibles = []
    (0..size - 1).each do |y|
      (0..size - 1).each do |x|
        if visible?(x, y)
          visible_count += 1
          visibles << [x, y]
        end
      end
    end
    visible_count
  end

  def part2
    viewing_distance(3, 3, :left)
    scores = (0..size - 1).map do |y|
      (0..size - 1).map do |x|
        scenic_score(x, y)
      end
    end.flatten

    scores.max
  end

  private

  def scenic_score(x, y)
    %i[up down left right].map { viewing_distance(x, y, _1) }.reduce(:*)
  end

  def viewing_distance(x, y, direction)
    distance = 0
    next_tree = 0
    value = value(x,y)

    case direction
    when :up
      next_index = y

      loop do
        next_index -= 1
        break unless next_index.between?(*visible_index_values)

        distance += 1
        next_tree = value(x, next_index)

        break if next_tree >= value
      end

    when :down
      next_index = y

      loop do
        next_index += 1
        break unless next_index.between?(*visible_index_values)
        distance += 1
        next_tree = value(x, next_index)

        break if next_tree >= value
      end

    when :left
      next_index = x

      loop do
        next_index -= 1
        break unless next_index.between?(*visible_index_values)
        distance += 1
        next_tree = value(next_index, y)

        break if next_tree >= value
      end

    when :right
      next_index = x
      loop do
        next_index += 1
        break unless next_index.between?(*visible_index_values)
        distance += 1
        next_tree = value(next_index, y)

        break if next_tree >= value
      end
    end

    distance
  end

  def parse_input
    @rows = data.split("\n").map { _1.chars.map(&:to_i) }
    @columns = @rows.transpose
    @size = @rows.count
  end

  def visible_index_values
    @visible_index_values ||= [0, size - 1]
  end

  def value(x,y)
    rows[y][x]
  end

  def visible?(x, y)
    return true if visible_index_values.include?(x) || visible_index_values.include?(y)

    value = value(x,y)
    rows[y][0..x - 1].none? { _1 >= value } || rows[y][x + 1.. size - 1].none? { _1 >= value } ||
     columns[x][0..y - 1].none? { _1 >= value } || columns[x][y + 1.. size - 1].none? { _1 >= value }
  end

  def mode
    :string
  end
end

