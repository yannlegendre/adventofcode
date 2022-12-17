require_relative '../../helpers/day'

class Y2022Day15 < Day
  include Grid
  attr_accessor :sensors
  TUNING_FREQUENCY = 4_000_000
  POINT_CONST = 5_000_000

  def initialize(*args, **kwargs)
    super(*args, **kwargs)
    parse_input
    @min_x_value = @sensors.map { |sensor| sensor[:x] - sensor[:distance] }.min
    @max_x_value = @sensors.map { |sensor| sensor[:x] + sensor[:distance] }.max
    @line = Array.new(@max_x_value - @min_x_value, '.')
    @x_offset = @min_x_value < 0 ? @min_x_value.abs : 0
    @line_y = spec ? 10 : 2_000_000
  end

  def part1
    @sensors.each_with_index do |sensor, sensor_index|
      sensor_coord = [sensor[:x], sensor[:y]]
      p sensor_index
      @line.each_with_index do |value, x|
        next if x == '#'

        real_coord = [x - @x_offset, @line_y]
        distance_from_sensor = distance(real_coord, sensor_coord)

        if distance_from_sensor <= sensor[:distance] && distance_from_sensor > 0
          @line[x] = '#' if distance_from_sensor <= sensor[:distance]
        end

      end
    end

    @line.count('#') - 1
  end

  def part2
    @covered_cells = Set.new
    sensors.each_with_index { |sensor, index| p index; build_covered_cells(sensor) }
    @covered_cells.uniq!
    binding.pry unless @stop
    range_max = @spec ? 20 : 4_000_000
    (0..range_max).lazy.each_with_index do |row, y|
      (0..range_max).lazy.each_with_index do |cell, x|
        p [x, y] if x % 1000 == 0 && y % 1000 == 0

        # return (x * TUNING_FREQUENCY + y) if sensors.none? do |sensor|
        #   distance([x, y], [sensor[:x], sensor[:y]]) <= sensor[:distance]
        # end
      end
    end
  end
  # 15h54 =>

  private

  def parse_input
    @sensors = data.split("\n").map do |line|
      regex = /Sensor at x=(.+), y=(.+): closest beacon is at x=(.+), y=(.+)/
      match_data = line.match(regex)
      sensor = {
        x: match_data[1].to_i,
        y: match_data[2].to_i,
        beacon_x: match_data[3].to_i,
        beacon_y: match_data[4].to_i,
      }
      sensor[:distance] = distance_from_beacon(sensor)
      sensor
    end
  end

  def distance_from_beacon(sensor)
    (sensor[:beacon_x] - sensor[:x]).abs + (sensor[:beacon_y] - sensor[:y]).abs
  end

  def distance(coord1, coord2)
    (coord1.first - coord2.first).abs + (coord1.last - coord2.last).abs
  end



  def build_covered_cells(sensor)
    1.upto(sensor[:distance]) do |distance_x|
      1.upto(sensor[:distance] - distance_x) do |distance_y|
        cells_to_add = [
          [sensor[:x] + distance_x, sensor[:y] + distance_y],
          [sensor[:x] - distance_x, sensor[:y] + distance_y],
          [sensor[:x] + distance_x, sensor[:y] - distance_y],
          [sensor[:x] - distance_x, sensor[:y] - distance_y],
        ]

        cells_to_add.each do |cell|
          id = id(*cell)
          next if @covered_cells.key?(id) || cell.any? { |coord| coord < 0 } || cell.any? { |coord| coord > 4_000_000 }

          @covered_cells[cell] = 1
        end
      end
    end
  end

  def mode
    :string
  end
end
