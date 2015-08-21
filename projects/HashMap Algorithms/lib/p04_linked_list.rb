Link = Struct.new(:key, :val, :next, :prev)

class LinkedList
  include Enumerable
  attr_reader :head

  def initialize
    @head = Link.new(nil, nil, nil, nil)
  end

  def insert(key, val)
    current = self.head
    current = current.next until current.next.nil? || current.key == key
    changed = false
    if current.key == key
      current.val = val
      changed = true
    end
    if current.next.nil? && !changed
      current.next = Link.new(key, val, nil, current)
    end
    changed
  end

  def get(key)
    current = self.head
    until current.next.nil?
      current = current.next
      return current.val if current.key == key
    end
  end

  def include?(key)
    current = self.head
    until current.next.nil?
      current = current.next
      return true if current.key == key
    end
    false
  end

  def remove(key)
    current = self.head
    until current.next.nil?
      current = current.next
      if current.key == key
        current.prev.next = current.next
        current.next.prev = current.prev if current.next
        return true
      end
    end
  end

  def each(&block)
    current = @head
    until current.next.nil?
      current = current.next
      block.call(current);
    end
  end
end
