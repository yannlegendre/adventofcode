require_relative '../../helpers/day'

class Y2022Day13 < Day
  attr_accessor :pairs

  def initialize(*args, **kwargs)
    super(*args, **kwargs)
    parse_input
  end

  def part1
    pairs.filter_map.with_index do |pair, index|
      left, right = pair
      left = eval(left)
      right = eval(right)

      (index + 1) if compare(left, right) == -1
    end.sum
  end

  def part2

  end

  private

  def compare(left, right)
    if left.is_a?(Integer) && right.is_a?(Integer)
      left <=> right
    else
      left = Array(left)
      right = Array(right)
      index = 0
      while index < left.size && index < right.size do
        comparison = compare(left[index], right[index])
        return comparison unless comparison.zero?

        index += 1
      end

      if index == left.size && index < right.size
        -1
      elsif index == right.size && index < left.size
        1
      else
        0
      end
    end
  end

  def parse_input
    @pairs = data.split("\n\n").map { _1.split("\n")}
  end

  def mode
    :string
  end
end
