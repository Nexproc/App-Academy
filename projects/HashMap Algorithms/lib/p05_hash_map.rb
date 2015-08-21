require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count
  def initialize(size = 8)
    @store = Array.new(size) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[hashit(key)].include?(key)
  end

  def set(key, val)
    @count += 1 unless @store[hashit(key)].insert(key, val)
    resize! if @count == @store.size
  end

  def get(key)
    @store[hashit(key)].get(key)
  end

  def delete(key)
    @count -= 1 if @store[hashit(key)].remove(key)
  end

  def [](key)
    get(key)
  end

  def []=(key, val)
    set(key, val)
  end

  def each(&block)
    @store.each { |list| list.each { |link| block.call(link.key, link.val) } }
  end

  def hashit(key)
    key.hash % @store.size
  end

  private

  def resize!
    hmap = new HashMap(count * 2)
    this.each { |k, v| hmap.set(k, v) }
    @store = hmap.store
  end
end
