require_relative '../../helpers/day'

class Y2022Day11 < Day
  attr_accessor :monkeys

  def initialize(*args, **kwargs)
    super(*args, **kwargs)
    parse_input
  end

  def part1

  end

  def part2

  end

  private

  def parse_input
    data.split("\n\n")
  end

  def mode
    :string
  end
end
