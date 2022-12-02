require_relative '../../helpers/day'

class Y2022Day1 < Day
  MODE = :csv

  def part1
    elfs.values.max
  end

  def part2
    elfs.values.max(3).sum
  end

  private

  def mode
    :csv
  end

  def elfs
    return @elfs if @elfs

    current_elf = 1
    star_counter = 0
    elfs = {}

    data.each do |stars|
      if stars
        star_counter += stars.to_i
      else
        star_counter = 0
        current_elf += 1
      end

      elfs[current_elf.to_s] = star_counter
    end

    @elfs = elfs
  end
end
