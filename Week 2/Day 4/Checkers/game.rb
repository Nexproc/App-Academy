require_relative 'board'

class Game
  attr_accessor :board, :loser
  def initialize
    @board = Board.new
    @loser = nil
  end

  def play
    until win?
      board.get_move
      board.change_active_color
    end
    puts "#{loser.to_s.capitalize} Loses!"
  end

  def win?
    board.team_colors.each do |color|
      self.loser = color unless board.grid.any? do |row|
        row.any? {|el| el.color == color}
      end
    end
    loser
  end

end
