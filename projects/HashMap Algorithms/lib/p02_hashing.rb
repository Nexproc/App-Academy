class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    vals = self.to_s.split("").map.with_index { |el, i| (el.ord + i).hash }
    vals.inject(0) { |accu, x| accu += x }
  end
end

class String
  def hash
    arr = self.split("")
    arr.hash
  end
end

class Hash
  def hash
    sum = 0
    self.each { |k, v| sum += k.to_s.ord.hash + v.to_s.ord.hash }
    sum
  end
end
