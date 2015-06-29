class Array
  def binary_search(target)
    middle = self.size/2
    return nil if size == 0
    return middle if self[middle] == target
    if target < self[middle]
        self.take(middle).binary_search(target)
      else
        middle + self.drop(middle).binary_search(target)
      end
  end
end
