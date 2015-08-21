class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    raise "Out of bounds" if num > @store.size || num < 0
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end
end


class IntSet
  def initialize(length = 20)
    @store = Array.new(length) { Array.new }
  end

  def insert(num)
    @store[key(num)] << num
  end

  def remove(num)
    @store[key(num)].delete(num)
  end

  def include?(num)
    @store[key(num)].include?(num)
  end

  def key(num)
    num % @store.length
  end
end

class ResizingIntSet < IntSet
  attr_reader :count

  def initialize(length = 20)
    @count = 0
    super(length)
  end

  def insert(num)
    @count += 1
    super(num)
    resize! if @count == @store.size
  end

  private
  def resize!
    
  end
end
