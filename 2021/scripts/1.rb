require_relative '../../helpers/day'

class Y2021Day1 < Day
  def part1
    increases = 0
    nb_entries = data.map.size

    for index in 1..(data.size - 1)
      increases += 1 if data[index] > data[index - 1]
    end

    increases
  end

  def part2
    increases = 0
    nb_entries = data.size

    for index in 3..(data.size - 1)
      increases += 1 if data[index] > data[index - 3]
    end

    increases
  end

  private

  def data
    super.map(&:to_i)
  end

  def mode
    :csv
  end
end
