class EmptySquare
  attr_accessor :jump_chain

  def nil?
    true
  end

  def to_s
    "   "
  end

  def moves
    []
  end

  def color
    nil
  end
end
