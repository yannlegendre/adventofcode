require_relative '../../helpers/day'

class Y2021Day7 < Day
  attr_accessor :monkeys

  def initialize(*args, **kwargs)
    super(*args, **kwargs)
    parse_input
  end

  def part1
    distances(:part1).min
  end


  def part2
    distances(:part2).min
  end

  private

  def distances(part)
    possible_positions = (@crabs.min)..(@crabs.max)
    possible_positions.map do |possible_position|
      @crabs.map do |crab|
        case part
        when :part1 then distance1(crab, possible_position)
        when :part2 then distance2(crab, possible_position)
        end
      end.sum
    end
  end

  def distance1(crab, other_crab)
    (crab - other_crab).abs
  end

  def distance2(crab, other_crab)
    base_distance = distance1(crab, other_crab)

    (0..base_distance).sum
  end

  def parse_input
    @crabs = data.split(',').map(&:to_i)
  end

  def mode
    :string
  end
end
