require_relative '../../helpers/day'

class Y2022Day3 < Day
  PRIORITIES = ('a'..'z').zip(1..26).concat(('A'..'Z').zip(27..52)).to_h
  def part1
    duplicates = rucksacks.map { duplicate_in_rucksack(_1) }
    duplicates.sum { PRIORITIES[_1] }
  end

  def part2
    common_letters = groups.map { common_letter_in_group(_1) }
    common_letters.sum { PRIORITIES[_1] }
  end

  private

  def rucksacks
    data.split("\n").map do |string|
      string.chars.each_slice(string.size / 2).to_a
    end
  end

  def groups
    rucksacks = data.split("\n").each_slice(3).to_a
  end

  def common_letter_in_group(group)
    group.first.chars.each do |letter|
      return letter if group[1].include?(letter) && group[2].include?(letter)
    end
  end

  def duplicate_in_rucksack(rucksack)
    rucksack.first.each do |letter|
      return letter if rucksack.last.include?(letter)
    end
  end

  def mode
    :string
  end
end
