class Array
	def my_each(&block)
		length.times {|i| block.call self[i] }
		self
	end

	def my_map(&block)
		arr = []
		my_each {|el| arr << block.call(el) }
		arr
	end

	def my_select(&block)
		arr = []
		my_each { |el| arr << el if block.call(el) }
		arr
	end

	def my_inject(accu = nil, &block)
		arr = self.dup
		accu = arr.shift if accu.nil?
		arr.my_each {|el| accu = block.call(accu, el)}
		accu
	end

	def my_sort!(&proc)
		return self if self.size < 2
		pivot = self.shift
		proc ||= Proc.new{|x, y| x <=> y}
		left, right = [], []
		until self.empty?
			case proc.call(pivot, self[0])
			when -1 || 0
				right << self.shift
			else
				left << self.shift
			end
		end
		self << left.my_sort!(&proc) + [pivot] + right.my_sort!(&proc)
		self.flatten!
	end
end