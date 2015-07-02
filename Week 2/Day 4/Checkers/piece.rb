require 'set'
require 'colorize'

class Piece
  BLACK_VECTORS = [ [-1, 1], [-1, -1] ]
  RED_VECTORS = [ [1, 1], [1, -1] ]
  attr_accessor :vectors, :symbol, :board, :position, :jump_chain
  attr_reader :color, :king_row
  def initialize(pos, color, board)
    @board = board
    @position = pos
    @color = color
    @vectors = Set.new
    @symbol = '☗'.colorize(color)
    @jump_chain = false
    @king_row = color == :red ? 7 : 0
    get_move_set
  end

  def promote
    row = position[0]
    make_king if row == king_row
  end

  def to_s
    " #{symbol} "
  end

  def get_move_set
    self.vectors += color == :red ? RED_VECTORS : BLACK_VECTORS
  end

  def make_king
    self.vectors += color == :red ? BLACK_VECTORS : RED_VECTORS
    self.symbol = '★'.colorize(color)
  end

  def get_slides
    slides = []
    self.vectors.each do |vector|
      move = increment(position, vector)
      slides << move if board.on_board?(move) && board[move].nil?
    end

    slides
  end

  def increment(pos, vector)
    [pos[0] + vector[0], pos[1] + vector[1]]
  end

  def get_jumps
    jumps = []
    vectors.each do |vector|
      next_space = jump_helper(vector)
      jumps << next_space if next_space
    end

    jumps
  end

  def jump_helper(vector)
    move = increment(position, vector)
    return false unless board.on_board?(move) && !board[move].nil?
    next_space = increment(move, vector)
    return false unless board.on_board?(next_space) && board[next_space].nil?
    return false unless board[move].color != color

    next_space
  end

  def moves
    if jump_chain
      return get_jumps
    end

    get_jumps + get_slides
  end
end
