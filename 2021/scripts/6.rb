require_relative '../../helpers/day'

class Y2021Day6 < Day
  attr_accessor :fishes
  def initialize(*args, **kwargs)
    super(*args, **kwargs)
    fish_array = data.chomp.split(',').map(&:to_i)
    @fishes = Hash.new(0).merge!(fish_array.tally)
    @fishes[FIRST_NEW_FISH_TIMER] = 0
  end

  FIRST_NEW_FISH_TIMER = 8
  NEW_FISH_FREQ = 7

  def part1
    80.times { one_day_goes_by! }
    fishes.values.sum
  end

  def part2
    256.times { one_day_goes_by! }
    fishes.values.sum
  end

  private

  def one_day_goes_by!
    age_fishes!
    create_fishes!
    reset_counters!
  end


  def age_fishes!
    fishes.transform_keys! { _1 - 1 }
  end

  def create_fishes!
    new_fishes_count = fishes[-1]
    fishes[FIRST_NEW_FISH_TIMER] = new_fishes_count
  end

  def reset_counters!
    fishes[-1 % NEW_FISH_FREQ] += fishes.delete(-1) if fishes[-1] > 0
  end

  def mode
    :string
  end
end
