require_relative '../../helpers/day'

class Y2022Day6 < Day
  def initialize(*args, **kwargs)
    super(*args, **kwargs)
  end

  def part1
    marker_index(4)
  end

  def part2
    marker_index(14)
  end

  def marker_index(marker_size)
    data.chars.lazy.each_with_index do |letter, index|
      next if index < marker_size - 1

      range = (index - marker_size + 1)..index
      return (index + 1) if range.map { data.chars[_1] }.uniq.size == marker_size
    end
  end

  private

  def mode
    :string
  end
end
