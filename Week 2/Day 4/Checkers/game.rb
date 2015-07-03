require_relative 'board'

class Game
  attr_accessor :board, :loser

  def initialize
    @board = Board.new
  end

  def play
    until win?
      board.get_move
      board.change_active_color
    end
    puts "#{board.team_colors.last.to_s.capitalize} Wins!"
  end

  def win?
    !board.team_colors.any? do |color|
      board.grid.any? do |row|
        row.any? {|el| el.color == color}
      end
    end
  end

end
