require_relative '../../helpers/day'

class Y2022Day2 < Day
  def part1
    data.sum do |plays|
      elf, player = plays.split
      points(elf, player, 1)
    end
  end

  def part2
    data.sum do |plays|
      elf, player = plays.split
      points(elf, player, 2)
    end
  end

  private

  PLAYS = {
    'A' => 'rock',
    'B' => 'paper',
    'C' => 'scissors',
  }
  WINNER_MOVE = {
    'rock' => 'paper',
    'paper' => 'scissors',
    'scissors' => 'rock',
  }
  POINTS = {
    'rock' => 1,
    'paper' => 2,
    'scissors' => 3,
    'win' => 6,
    'draw' => 3,
    'lose' => 0,
  }


  def player_play1(player_letter, _elf_play)
    map = {
      'X' => 'A',
      'Y' => 'B',
      'Z' => 'C',
    }
    PLAYS[map[player_letter]]
  end

  def player_play2(player_letter, elf_play)
    map = {
      'X' => WINNER_MOVE.invert[elf_play],
      'Y' => elf_play,
      'Z' => WINNER_MOVE[elf_play],
    }
    map[player_letter]
  end

  def points(elf_letter, player_letter, part)
    elf_play = PLAYS[elf_letter]
    player_play = send("player_play#{part}", player_letter, elf_play)

    income = if elf_play == player_play
        'draw'
      elsif player_play == WINNER_MOVE[elf_play]
        'win'
      else
        'lose'
      end
    income = POINTS[income] + POINTS[player_play]
  end

  def mode
    :csv
  end
end
