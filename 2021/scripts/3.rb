require_relative '../../helpers/day'

class Y2021Day3 < Day
  def part1
    gamma_rate = values_count.map { _1.max_by { |_,v| v}.first }.join.to_i(2)
    epsilon_rate = values_count.map { _1.min_by { |_,v| v}.first }.join.to_i(2)
    gamma_rate * epsilon_rate
  end

  def part2
    rate(:most) * rate(:least)
  end

  private

  def data
    @data ||= super.split("\n")
  end

  def values_count
    return @values_count if @values_count

    counter = []
    data.first.length.times { counter << { '0' => 0, '1' => 0 }.dup }
    data.each_with_index do |code, code_index|
      code.split('').each_with_index do |digit, digit_index|
        counter[digit_index][digit] += 1
      end
    end

    @values_count = counter
  end

  def rate(type)
    grid = data.map(&:chars)
    bit_size = grid.first.length

    digit_index = 0
    while grid.size > 1
      grid = grid.select.with_index do |line, num_ligne|
        column = grid.map { _1[digit_index]}

        line[digit_index] == most_or_least_freq(column, type)
      end
      digit_index += 1
    end
    grid.flatten.join.to_i(2)
  end

  def most_or_least_freq(column, mode)
    ones = column.count('1')
    zeros = column.count('0')

    if mode == :most
      ones >= zeros ? '1' : '0'
    else
      ones >= zeros ? '0' : '1'
    end
  end

  def mode
    :string
  end
end
