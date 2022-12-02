require_relative '../../helpers/day'

class Y2021Day2 < Day
  def initialize(*args, **kwargs)
    super(*args, **kwargs)
    @depth = 0
    @length = 0
    @aim = 0
  end

  def part1
    data.each do |instruction|
      direction, amount = instruction.split
      case direction
      when 'forward'
        @length += amount.to_i
      when 'down'
        @depth += amount.to_i
      when 'up'
        @depth -= amount.to_i
      end
    end
    @depth * @length
  end

  def part2
    data.each do |instruction|
      direction, amount = instruction.split
      amount = amount.to_i
      case direction
      when 'forward'
        @length += amount
        @depth += (@aim * amount)
      when 'down'
        @aim += amount
      when 'up'
        @aim -= amount
      end
    end

    @length * @depth
  end

  private

  def mode
    :csv
  end
end
