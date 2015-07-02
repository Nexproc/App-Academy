require_relative 'piece'
require_relative 'empty_square'
require 'colorize'
require 'io/console'

class Board
  attr_accessor :grid, :cursor, :end_cursor, :team_colors

  def initialize
    @grid = Array.new(8) { Array.new(8) { EmptySquare.new }}
    add_pieces
    @cursor = [0, 0]
    @team_colors = [:red, :black]
  end

  def get_move
    start_pos = nil
    while board[start_pos].nil?
      start_pos = respond_to_input
    end
    self.end_cursor = cursor
  end_pos = nil
    until board[end_pos].moves.include?(end_pos)
    end_pos = respond_to_input
    self.end_cursor = nil
    make_move(start_pos, end_pos)
  end

  def make_move

  end

  def add_pieces
    [:red, :black].each do |color|
      start = color == :red ? 0 : -3
      3.times do |i|
        offset = (start + i) % 2 == 0 ? 1 : 0
        4.times do |c|
          true_start = start < 0 ? (8 + start) : start
          pos = [true_start + i, (c * 2) + offset]
          self[pos] = Piece.new(pos, color, self)
        end
      end
    end
  end

  def [](pos)
    row, col = pos
    self.grid[row][col]
  end

  def []=(pos, el)
    row, col = pos
    self.grid[row][col] = el
  end

  def render
    #render board and pieces
    colors = [:blue, :yellow]
    system "clear"
    puts "   a  b  c  d  e  f  g  h"
    grid_string = []
    grid.each_with_index do |row, i|
      row_string = row.map.with_index do |el, c|
        if !end_cursor.nil? && end_cursor == [i, c]
          el.to_s.colorize(:background => :green)
        end
        if cursor == [i, c]
          el.to_s.colorize(:background => :green)
        else
          el.to_s.colorize(:background => colors[(c+i) % 2])
        end
      end
      grid_string << row_string
    end

    grid_string.each_with_index {|row, i| puts "#{(i + 1).to_s} #{row.join}"}
  end

  def on_board?(pos)
    pos.all? {|x| x.between?(0, 7)}
  end

  def move_cursor(vector)
    next_pos = [cursor[0] + vector[0], cursor[1] + vector[1]]
    return unless on_board?(next_pos)
    if end_cursor.nil?
      self.cursor = next_pos
    else
      self.end_cursor = nex_pos
    end
  end

  def change_active_color
    team_colors.rotate
  end

  # original case statement from:
# http://www.alecjacobson.com/weblog/?p=75
  def respond_to_input
    self.render
    loop do
      self.render
      c = read_char
      case c
        when "\r"
          return end_cursor || cursor
        when "\e[A"
          self.render
          move_cursor([-1, 0])
        when "\e[B"
          self.render
          move_cursor([1, 0])
        when "\e[C"
          self.render
          move_cursor([0, 1])
        when "\e[D"
          self.render
          move_cursor([0, -1])
        when "\u0003"
          raise Interrupt
      end
    end
  end

  def read_char
    STDIN.echo = false
    STDIN.raw!

    input = STDIN.getc.chr
    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil
      input << STDIN.read_nonblock(2) rescue nil
    end
    ensure
      STDIN.echo = true
      STDIN.cooked!

      return input
  end
end
