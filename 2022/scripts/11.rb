require_relative '../../helpers/day'

class Y2022Day11 < Day
  attr_accessor :monkeys

  def initialize(*args, **kwargs)
    super(*args, **kwargs)
    parse_input
  end

  def part1
    20.times { @monkeys.each(&:round_simple!)}
    monkey_business
  end

  def part2
    monkeys.each { _1.build_complex_items }
    10_000.times { @monkeys.each { _1.round_complex!(i) } }
    monkey_business
  end

  def dividers
    @dividers ||= monkeys.map(&:divider)
  end

  private

  def parse_input
    @monkeys = data.split("\n\n").map { Monkey.new(_1, self) }
  end

  def mode
    :string
  end

  def monkey_business
    @monkeys.map(&:counter).sort.last(2).reduce(:*)
  end
end

class Monkey
  attr_accessor :counter, :divider, :starting_items, :index

  def initialize(monkey_string, day)
    index, starting_items, operation, test, if_true, if_false = monkey_string.split("\n").map { _1.strip }
    @index = index[-2].to_i
    @starting_items = starting_items.split(':').last.split(',').map(&:to_i)
    @divider = test.split.last.to_i
    @operation = operation.split(':').last.strip
    @if_true = if_true.split.last.to_i
    @if_false = if_false.split.last.to_i
    @day = day
    @counter = 0
    @complex_starting_items = {}
  end

  def monkeys
    @day.monkeys
  end

  def dividers
    @dividers ||= @day.dividers
  end

  def build_complex_items(reset: false)
    @starting_items.map! do |item|
      dividers.to_h { |divider| ["by_#{divider}".to_sym, item ]}
    end
  end

  def round_simple!
    @starting_items.each_with_index do |old, index|
      worry_level = eval(@operation)
      worry_level /= 3
      monkey_index = worry_level % @divider == 0 ? @if_true : @if_false
      @counter += 1
      throw_to!(worry_level, monkeys[monkey_index])
    end
    @starting_items = []
  end

  def round_complex!(count)
    @starting_items.each_with_index do |complex_item, index|
      complex_item.each do |by_key, old|
        complex_item[by_key] = eval(@operation) % (by_key.to_s.split('_').last.to_i)
      end
      key = "by_#{@divider}".to_sym
      monkey_index = complex_item[key] == 0 ? @if_true : @if_false
      @counter += 1
      throw_to!(complex_item, monkeys[monkey_index])
    end
    @starting_items = []
  end

  def throw_to!(item, monkey_destination)
    monkey_destination.receive(item)
  end

  def receive(item)
    @starting_items << item
  end
end