require_relative '../../helpers/day'

class Y2023Day1 < Day
  NUMS = {
    'one' => 1,
    'two' => 2,
    'three' => 3,
    'four' => 4,
    'five' => 5,
    'six' => 6,
    'seven' => 7,
    'eight' => 8,
    'nine' => 9,
  }

  def initialize(*args, **kwargs)
    super(*args, **kwargs)
  end

  def part1
    lines = data.split("\n")
    lines.map { _1.gsub(/\D/, "") }.map {  "#{_1.chars.first}#{_1.chars.last}".to_i }.sum
  end

  def part2
    lines = data.split("\n")
    digits = NUMS.keys.concat((1..9).map(&:to_s))
    pattern = /(?=(#{Regexp.union(digits)}))/

    lines.map { _1.scan(pattern).flatten }
      .map { [_1.first, _1.last] }
      .map do |line|
        line.map { spelled_in_letters?(_1) ? NUMS[_1] : _1.to_i }
      end
      .map { (_1.first.to_s + _1.last.to_s).to_i }
      .sum
  end

  private

  def parse_input
    data.split("\n\n")
  end

  def mode
    :string
  end

  def spelled_in_letters?(string)
    NUMS.keys.include?(string)
  end
end
