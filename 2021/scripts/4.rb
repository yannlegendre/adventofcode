require_relative '../../helpers/day'

class Y2021Day4 < Day
  def initialize(*args, **kwargs)
    super(*args, **kwargs)
    build_data
  end

  def part1
    loop do
      called_number = @tirage.shift
      cross_all_boards(called_number)
      next unless last_bingo_board

      break result(last_bingo_board, called_number)
    end
  end

  def part2
    loop do
      called_number = @tirage.shift
      cross_all_boards(called_number)
      if last_bingo_board
        break result(last_bingo_board, called_number) if all_boards_with_bingo?

        last_bingo_board.announce_bingo!
      end
    end
  end


  private
  def build_data
    processing_data = data.split("\n\n")
    @tirage = processing_data.shift.split(',').map(&:to_i)
    @boards = build_boards(processing_data)
  end

  def build_boards(raw_data)
    raw_data.map.with_index do |raw_board, board_index|
      raw_lines = raw_board.split("\n").map(&:split)

      lines = raw_lines.map.with_index do |raw_line, line_index|
        raw_line.map.with_index do |number, col_index|
          Cell.new(number.to_i, board_index, line_index, col_index)
        end
      end

      Board.new(board_index, lines)
    end
  end

  def cross_all_boards(number)
    @boards.each { _1.cross_number(number) }
  end

  def last_bingo_board
    @boards.find { _1.bingo? && !_1.bingo_announced? }
  end

  def all_boards_with_bingo?
    @boards.all? { _1.bingo? }
  end

  def result(board, last_number)
    board.sum_of_all_unmarked_numbers * last_number
  end

  def mode
    :string
  end
end

class Board
  attr_reader :index
  def initialize(index, lines)
    @lines = lines
    @index = index
    @bingo_announced = false
  end

  def announce_bingo!
    @bingo_announced = true
  end

  def bingo_announced?
    @bingo_announced
  end

  def complete_row?
    @lines.any? { |line| line.all? { |cell| cell.crossed? } }
  end

  def complete_column?
    @lines.each_with_index do |line, line_index|
      line.each_with_index do |cell, col_index|
        return true if @lines.map { _1[col_index] }.all?  { |cell| cell.crossed? }
      end
    end

    false
  end

  def bingo?
    complete_row? || complete_column?
  end

  def cross_number(number)
    @lines.each do |cells|
      cells.each do |cell|
        cell.cross! if cell.number == number
      end
    end
  end

  def sum_of_all_unmarked_numbers
    @lines.sum do |line|
      line.sum do |cell|
        cell.crossed? ? 0 : cell.number
      end
    end
  end
end

class Cell
  attr_reader :number

  def initialize(number, board_index, row, col)
    @number = number
    @crossed = false
    @board_index = board_index
    @row = row
    @col = col
  end

  def crossed?
    @crossed
  end

  def cross!
    @crossed = true
  end
end
