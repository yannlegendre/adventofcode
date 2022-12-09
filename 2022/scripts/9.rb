require_relative '../../helpers/day'

class Y2022Day9 < Day

  attr_reader :head, :tail, :tail_positions, :moves
  def initialize(*args, **kwargs)
    super(*args, **kwargs)

    parse_input
    @head = Stuff.new
    @tail = Stuff.new
    @tail_positions = []
  end


  def part1
    moves.each do |move|
      move[:times].times do
        head.move(move[:direction])
        tail.follow(head)
        tail_positions << tail.coords
      end
    end

    tail_positions.uniq.count
  end

  def part2
    @knots = [head]; 9.times { @knots << Stuff.new }
    positions = @knots.map.with_index {  [_2.to_s, []] }.to_h

    moves.each do |move|
      move[:times].times do
        head.move(move[:direction])
        positions
        @knots.each_with_index do |knot, index|
          knot.follow(@knots[index - 1]) unless index == 0
          positions[index.to_s] << knot.coords
        end
      end
    end

    positions['9'].uniq.count
  end

  private

  def parse_input
    @moves = data.split("\n").map { _1.split }.map { { direction: _1.first, times: _1.last.to_i } }
  end

  def mode
    :string
  end
end

class Stuff
  attr_reader :x, :y
  def initialize
    @x = 0
    @y = 0
  end

  def coords
    [x, y]
  end

  def move(direction)
    case direction
    when 'R'
      @x +=1
    when 'U'
      @y +=1
    when 'L'
      @x -=1
    when 'D'
      @y -=1
    end
  end

  def follow(head)
    return coords if coords == head.coords

    if sqr_distance_to(head) == 4
      move_straight_to(head)
    elsif sqr_distance_to(head) > 4
      move_diagonnally_to(head)
    end
  end

  def move_straight_to(head)
    if left_of?(head, 2)
      move('R')
    elsif right_of?(head, 2)
      move('L')
    elsif below?(head, 2)
      move('U')
    elsif above?(head, 2)
      move('D')
    end
  end

  def move_diagonnally_to(head)
    direction =
      if left_of?(head)
       'R'
      elsif right_of?(head)
       'L'
      elsif below?(head)
       'U'
      elsif above?(head)
       'D'
      end
    move(direction)

    next_direction =
      case direction
      when 'U', 'D'
        left_of?(head) ? 'R' : 'L'
      when 'L', 'R'
        above?(head) ? 'D' : 'U'
      end
    move(next_direction)
  end



  def below?(head, count = 0)
    operator = count == 0 ? "<=" : '=='
    count.send(operator, head.y - y)
  end

  def above?(head, count = 0)
    operator = count == 0 ? "<=" : '=='

    count.send(operator, y - head.y)
  end

  def left_of?(head, count = 0)
    operator = count == 0 ? "<=" : '=='

    count.send(operator, head.x - x)
  end

  def right_of?(head, count = 0)
    operator = count == 0 ? "<=" : '=='

    count.send(operator, x - head.x)
  end

  def sqr_distance_to(head)
    (head.x - x) ** 2 + (head.y - y) ** 2
  end
end
