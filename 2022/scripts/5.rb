require_relative '../../helpers/day'

class Y2022Day5 < Day
  def initialize(*args, **kwargs)
    super(*args, **kwargs)
    parse_data!
  end

  attr_accessor :moves, :stack
  def part1
    moves.each do |move|
      make_move(move, :single)
    end
    stack.map(&:last).join
  end

  def part2
    moves.each do |move|
      make_move(move, :multiple)
    end
    stack.map(&:last).join
  end

  private

  def parse_data!
    stack_lines, @moves = data.split("\n\nmove")
    stack_lines = stack_lines.split("\n")
    num_col = stack_lines.pop.chars.last.to_i

    @stack = []
    num_col.times { @stack << [] }

    stack_lines.each do |line_string|
      line = line_string.chars.each_slice(4).to_a
      line.each_with_index do |raw_crate_array, col_index|
        next if crate(raw_crate_array).nil?

        @stack[col_index].unshift(crate(raw_crate_array))
      end
    end
    @moves = ("move" + @moves).split("\n")
  end

  def make_move(move_string, mode = :single)
    _, rep, _, source, _, destination = move_string.split.map(&:to_i)
    if mode == :single
      rep.times do
        crate = stack[source - 1].pop
        stack[destination - 1].push(crate)
      end
    else
      crates = stack[source - 1].pop(rep)
      stack[destination - 1].concat(crates)
    end
  end

  def crate(raw_crate_array)
    return nil if raw_crate_array.first == ' '

    raw_crate_array[1]
  end

  def mode
    :string
  end
end
