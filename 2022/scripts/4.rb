require_relative '../../helpers/day'

class Y2022Day4 < Day
  def part1
    range_pairs.select { range_included?(*_1) }.count
  end

  def part2
    range_pairs.select { range_overlap?(*_1) }.count
  end

  private

  def range_pairs
    data.split("\n").map do |a|
      a.split(',').map do |b|

        arr = b.split('-').map(&:to_i)
        (arr.first)..(arr.last)
      end
    end
  end

  def range_included?(range1, range2)
    range1_included = range1.first >= range2.first && range1.last <= range2.last
    range2_included = range2.first >= range1.first && range2.last <= range1.last
    range1_included || range2_included
  end

  def range_overlap?(range1, range2)
    (range1.last >= range2.first && range1.first <= range2.last) ||
    (range2.last >= range1.first && range2.first <= range1.last)
  end

  def mode
    :string
  end
end
