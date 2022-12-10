require_relative '../../helpers/day'

class Y2022Day10 < Day

  attr_reader :instructions, :register
  def initialize(*args, **kwargs)
    super(*args, **kwargs)

    @instructions = []
    parse_input
    build_register
  end

  CYCLES =[20, 60, 100, 140, 180, 220].freeze

  def part1

    CYCLES.map { signal_strength(_1)}.reduce(:+)
  end

  def part2
    register.pop
    register.each_slice(40).map.with_index do |values|
      values.map.with_index do |value, index|
        display?(value, index) ? '#' : '.'
      end.join
    end.join("\n")
  end

  private

  def display?(value, index)
    (index).between?(value - 1, value + 1)
  end

  def build_register
    @register = [1]
    instructions.each do |instruction|
      send(instruction[:id], instruction[:value])
    end
  end

  def noop(_value)
    register << register.last
  end

  def addx(value)
    noop(value)
    register << register.last + value
  end

  def signal_strength(cycle)
    index = cycle - 1
    cycle * @register[index]
  end

  def parse_input
    @instructions = data.split("\n").map do |line|
      id, value = line.split
      {
        id: id,
        value: value.to_i,
      }
    end
  end

  def mode
    :string
  end
end

