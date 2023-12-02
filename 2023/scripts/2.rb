require_relative '../../helpers/day'

# only 12 red cubes, 13 green cubes, and 14 blue cubes

class Y2023Day2 < Day
  def initialize(*args, **kwargs)
    super(*args, **kwargs)
    parse_input
  end

  def part1
    parse_input.select do |game|
      game[:sets].all? do |set|
        set[:red] <= 12 && set[:green] <= 13 && set[:blue] <= 14
      end
    end.sum { _1[:id] }
  end

  def part2
    parse_input.map do |game|
      %i[red green blue].map do |color|
        game[:sets].max_by { _1[color] }[color]
      end.reduce(:*)
    end.sum
  end

  private

  def parse_input
    data.split("\n").map! do |line|
      id, sets = line.split(': ')
      id = id.scan(/\d/).join.to_i
      sets = sets.split('; ').map! do |set|
        set = set.split(', ').map { _1.split(' ').reverse }.to_h.transform_values(&:to_i).transform_keys(&:to_sym)
        set[:red] ||= 0
        set[:blue] ||= 0
        set[:green] ||= 0
        set
      end
      { id: id, sets: sets}
    end
  end

  def mode
    :string
  end
end
