module RowCollector
  #collects all rows into arrays
  def collect_rows(grid)
    return grid
  end

  #collects all columns into arrays
  def collect_cols(grid)
    grid.transpose
  end

  # [ [1, 2, 3, 4]
  #   [5, 6, 7, 8]
  #  [9, 10, 11, 12] ]
  def collect_diags_up(grid) #=[1][5, 2][9, 6, 3][10, 7, 4][11, 8][12]
    diags = []
    height = grid.size
    width = grid[0].size
    height.times do |i|
      first = []
      (i + 1).times do |c|
        first << grid[i-c][c]
      end
      diags << first
    end
    (width - 1).times do |i|
      first = []
      (i + 1).times do |c|
        first << grid[height - c - 1][width - i + c - 1]
      end
      diags << first
    end

    diags
  end

  def collect_diags_down(grid)
    diags = []
    height = grid.size
    width = grid[0].size
    height.times do |i|
      first = []
      (i + 1).times do |c|
        first << grid[height - i + c - 1][c]
      end
      diags << first
    end
    (width - 1).times do |i|
      first = []
      (i + 1).times do |c|
        first << grid[c][i - c]
      end
      diags << first
    end

    diags
  end
end
