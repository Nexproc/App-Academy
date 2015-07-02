module RowCollector
  #collects all rows into arrays
  def collect_rows(grid)
    return grid
  end

  #collects all columns into arrays
  def collect_cols(grid)
    grid.transpose
  end

  #collects
  def collect_diags_up(grid)
    diags = []
    height = grid[0].size
    width = grid.size
    grid.each_with_index do |row, i|
      c = 0
      first = []
      second = []
      (i + 1).times do |c|
        first << grid[i-c][c]
      end
      diags << first
    end
    width.times do |i|
      i.times
    end
    diags
  end

  def collect_diags_down(grid)
  end
end
