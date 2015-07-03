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

  def valid_start_pos?(pos)
    return false if self[pos].nil?
    return false if self[pos].color != team_colors.first
    return false if self[pos].moves.empty?

    true
  end

  #get move will allow the choice of a start position
  #chain jumping forces the start position to be on
  #the piece that is chain jumping.
  def get_move(start_pos = nil)
    until start_pos && valid_start_pos?(start_pos)
      start_pos = respond_to_input
    end
    self.cursor = start_pos
    self.end_cursor = self.cursor.dup
    end_pos = nil
    until end_pos && self[start_pos].moves.include?(end_pos)
      end_pos = respond_to_input
    end
    self.cursor = end_cursor
    self.end_cursor = nil
    move(start_pos, end_pos)
  end

  def move(start_pos, end_pos)
    jump = false
    if self[start_pos].get_jumps.include?(end_pos)
      jump = true
      jump_piece(start_pos, end_pos)
    end
    place_piece(start_pos, end_pos)
    chain_jump(end_pos) if jump
  end

  def jump_piece(start, finish)
    vectors = [finish[0] - start[0], finish[1] - start[1]]
    vectors.map! { |vector| vector / 2 }
    middle = [start[0] + vectors[0], start[1] + vectors[1]]
    self[middle] = EmptySquare.new
  end

  def place_piece(start, finish)
    self[finish] = self[start]
    self[start] = EmptySquare.new
    self[finish].position = finish
    self[finish].promote
  end

  def chain_jump(pos)
    unless self[pos].get_jumps.empty?
      self[pos].jump_chain = true
      get_move(pos)
    end
    self[pos].jump_chain = false
  end

  #populate the board
  def add_pieces
    #for each color
    [:red, :black].each do |color|
      #choose side of the board based on current color
      start = color == :red ? 0 : -3
      #populate three rows
      3.times do |i|
        #account for offset in each row
        offset = (start + i) % 2 == 0 ? 1 : 0
        #for each column - only 4 pieces - skip between spaces
        4.times do |c|
          #true_start for setting the internal position of the pieces at -3
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
        if self.end_cursor && self.end_cursor == [i, c]
          next el.to_s.colorize( :background => :green )
        end
        if cursor == [i, c]
          el.to_s.colorize( :background => :green )
        elsif self[cursor].moves.include?([i, c]) && self[cursor].color == team_colors.first
          el.to_s.colorize( :background => :cyan )
        else
          el.to_s.colorize( :background => colors[(c+i) % 2] )
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
    active = end_cursor || cursor
    next_pos = [active[0] + vector[0], active[1] + vector[1]]
    return unless on_board?(next_pos)
    self.end_cursor ? self.end_cursor = next_pos : self.cursor = next_pos
  end

  def change_active_color
    team_colors.rotate!
  end

  #keyboard input stuff
  # original case statement from:
  # http://www.alecjacobson.com/weblog/?p=75
  def respond_to_input
    render
    loop do
      render
      c = read_char
      case c
        when "\r"
          return end_cursor || cursor
        when "\e[A"
          move_cursor([-1, 0])
        when "\e[B"
          move_cursor([1, 0])
        when "\e[C"
          move_cursor([0, 1])
        when "\e[D"
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
