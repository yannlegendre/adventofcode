require_relative '../../helpers/day'

class Y2022Day13 < Day
  attr_accessor :pairs

  DIVIDER_PACKETS = [[[2]], [[6]]].freeze
  def initialize(*args, **kwargs)
    super(*args, **kwargs)
    parse_input
  end

  def part1
    pairs.filter_map.with_index do |pair, index|
      left, right = pair
      (index + 1) if compare(left, right) == -1
    end.sum
  end

  def part2
    sorted_packets = pairs.flatten(1).concat(DIVIDER_PACKETS).sort { |a, b| compare(a, b) }
    indices = sorted_packets.filter_map.with_index { |packet, index| index + 1 if DIVIDER_PACKETS.include?(packet) }.reduce(:*)
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
    pairs.map! { |pair| pair.map { eval(_1) }}
  end

  def mode
    :string
  end
end
