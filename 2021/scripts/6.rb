require_relative '../../helpers/day'

class Y2021Day6 < Day
  attr_accessor :fishes
  def initialize(*args, **kwargs)
    super(*args, **kwargs)
    @fishes = data.chomp.split(',').map(&:to_i)
  end

  FIRST_NEW_FISH_TIMER = 8
  NEW_FISH_FREQ = 7

  def part1
    80.times { one_day_goes_by! }
    fishes.count
  end

  def part2
    binding.pry unless @stop
    256.times do

    end
  end

  private

  def one_day_goes_by!
    age_fishes!
    create_fishes!
    reset_counters!
  end

  def age_fishes!
    fishes.map! { |age| age -= 1 }
  end

  def create_fishes!
    fishes.count(-1).times { fishes << FIRST_NEW_FISH_TIMER }
  end

  def reset_counters!
    fishes.map! { |age| (age < 0) ? (age % NEW_FISH_FREQ) : age }
  end

  def mode
    :string
  end
end
