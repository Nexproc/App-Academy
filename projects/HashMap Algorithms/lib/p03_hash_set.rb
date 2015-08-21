require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(size = 8)
    @store = Array.new(size) { Array.new }
    @count = 0
  end

  def insert(key)
    @count += 1
    @store[help(key)] << key
    resize! if @count == @store.size
  end

  def remove(key)
    @count -= 1
    @store[help(key)].delete(key)
  end

  def include?(key)
    @store[help(key)].include?(key)
  end

  def help(key)
    key.hash % @store.size
  end

  private
  def resize!
  end
end
