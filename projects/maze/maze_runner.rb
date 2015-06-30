#........
#.   . E.
#. . . ..
#. . .  .
#. . .  .
#. . .  .
#.S.    .
#........

#move
#up?
#down?
#left?
#right?
#@previous_positions = []

#methods based on orientation to exit?
#branching path 'theories' for shortest route finding - merge branches that intersect(shortest = preferred)
#handling dead ends - check all spaces - if space has 3 directions == '.' then change space to '.' and check
						#the fourth direction to see if it is also a dead end
#handling redundancy
class MazeRunner
	attr_accessor  :x, :y, :maze

	def initialize(filename)
		@maze = Maze.new(filename)
		@x = @maze.start[0]
		@y = @maze.start[1]
	end

	def run
		puts "Maze"
		@maze.maze_arr.each {|line| puts line.join}
		path_finder
		puts "Dead Ends"
		@maze.maze_arr.each {|line| puts line.join}
		pos = 'S'
		this_x = -1
		this_y = -1
		while pos != 'E'
			break if this_x == @x && this_y == @y
			this_x = @x
			this_y = @y
			pos = move
		end
		puts "End"
		@maze.maze_arr.each_with_index {|line, y| line.each_with_index {|node, x| @maze.maze_arr[y][x] = ' ' if node == 'X'}}
		@maze.maze_arr.each {|line| puts line.join}
	end

	def path_finder
		dead_ends = find_dead_ends
		p dead_ends
		dead_ends.each do |d_end|
			remove_path(d_end)
		end
	end

	def remove_path(d_end)
		case 
		when left?(d_end)
			@maze.maze_arr[d_end[1]][d_end[0]] = 'X'
			d_end[0] -= 1
			remove_path(d_end) if dead_end?(d_end[0], d_end[1])
			return
		when up?(d_end)
			@maze.maze_arr[d_end[1]][d_end[0]] = 'X'
			d_end[1] -= 1
			remove_path(d_end) if dead_end?(d_end[0], d_end[1])
			return
		when right?(d_end)
			@maze.maze_arr[d_end[1]][d_end[0]] = 'X'
			d_end[0] += 1
			remove_path(d_end) if dead_end?(d_end[0], d_end[1])
			return
		when down?(d_end)
			@maze.maze_arr[d_end[1]][d_end[0]] = 'X'
			d_end[1] += 1
			remove_path(d_end) if dead_end?(d_end[0], d_end[1])
			return
		end
	end

	def find_dead_ends
		dead_ends = []
		@maze.maze_arr.each_with_index {|line, temp_y| line.each_with_index {|node, temp_x| dead_ends << [temp_x, temp_y] if dead_end?(temp_x, temp_y) }}
		dead_ends
	end

	def dead_end?(temp_x, temp_y)
		count = 0
		count += 1 unless left?([temp_x, temp_y])
		count += 1 unless right?([temp_x, temp_y])
		count += 1 unless up?([temp_x, temp_y])
		count += 1 unless down?([temp_x, temp_y])
		pos = @maze.maze_arr[temp_y][temp_x]
		count == 3 && pos == ' '
	end

	def move
		case 
		#hand on left wall
		when left?([@x, @y])
			@maze.maze_arr[@y][@x] = '<'
			@x -= 1
			return maze.maze_arr[@y][@x]
		when up?([@x, @y])
			@maze.maze_arr[@y][@x] = '^'
			@y -= 1
			return maze.maze_arr[@y][@x]
		when right?([@x, @y])
			@maze.maze_arr[@y][@x] = '>'
			@x += 1
			return maze.maze_arr[@y][@x]
		when down?([@x, @y])
			@maze.maze_arr[@y][@x] = 'v'
			@y += 1
			return maze.maze_arr[@y][@x]
		end
		maze.maze_arr[@y][@x]
	end

	def up?(pos)
		valid_move?(pos[0], pos[1] - 1)
	end

	def down?(pos)
		valid_move?(pos[0], pos[1] + 1)
	end

	def left?(pos)
		valid_move?(pos[0] - 1, pos[1])
	end

	def right?(pos)
		valid_move?(pos[0] + 1, pos[1])
	end

	def valid_move?(temp_x, temp_y)
		begin
		pos = @maze.maze_arr[temp_y][temp_x]
		pos == ' '||  pos == "S" || pos == "E"
		rescue NoMethodError
			return false
		end
	end
end

class Maze
	attr_accessor :maze_arr, :start, :end
	def initialize(filename)
		#load maze from file >> split each line into an array of characters
		@maze_arr = File.readlines(filename)
		#store start position
		@maze_arr.map!{|line| line.split('')}
		@maze_arr.each_with_index do |line, y|
			line.each_with_index do |val, x| 
				@start = [x, y] if val == 'S'
				@end = [x, y] if val == 'E'
			end
		end
	end
end

MazeRunner.new('maze.txt').run