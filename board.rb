class Board
  SHIPS = {
    a: 5, #aircraft carrier
    b: 4, #battleship
    s: 3, #submarine
    d: 3, #destroyer
    p: 2  #patrol boat
  }

  def self.default_grid
    Array.new(10) { Array.new(10,0) }
  end

  attr_reader :grid

  def initialize(grid = self.class.default_grid)
    @grid = grid
    @attacked_spaces = []
  end

  def attacked_spaces
    @attacked_spaces
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, val)
    x, y = pos
    grid[x][y] = val
  end

  def count
    grid.flatten.select { |el| el == :s }.length
  end

  def empty?(pos = nil)
    if !(pos.nil?)
      grid[pos.first][pos.last].nil?
    else
      won?
    end
  end

  def full?
    grid.flatten.all? { |el| el == :s }
  end

  def won?
    grid.flatten.none? { |el| el == :s }
  end

  # is the coordinate a valid choice?
  def in_range?(pos)
    pos.all? { |coord| coord.between?(0, size - 1) }
  end


  def place_horizontal(len)
    valid_placement = false
    until valid_placement
      row, col = random_pos
      bow_col = col + len
      # check col + len is <= 9
      # check all spaces involved are 0's
      # valid_placement = true if both pass
      if bow_col <= size - 1 && (col..bow_col).all? { |col| @grid[row][col] == 0 }
        valid_placement = true
        (col...bow_col).each { |col| @grid[row][col]= :s }
      end
    end
  end

  def place_vertical(len)
    valid_placement = false
    until valid_placement
      row, col = random_pos
      bow_row = row + len
      # check row + len is <= 9
      # check all spaces involved are 0's
      # valid_placement = true if both pass
      if bow_row <= size - 1 && (row..bow_row).all? { |row| @grid[row][col] == 0 }
        valid_placement = true
        (row...bow_row).each { |row| @grid[row][col]= :s }
      end
    end
  end

  def orientation(len)
    rand(2) == 1 ? vertical = true : vertical = false
    vertical ? place_vertical(len) : place_horizontal(len)
  end

  def place_ships
    SHIPS.keys.each do |ship|
      orientation(SHIPS[ship])
    end
  end

  def random_pos
    [rand(size), rand(size)]
  end

  def size
    grid.length
  end

  def display
    display_grid = "----------------------\n"
    # make it like quadrant 1 of a coordinate plan, so reverse
    @grid.reverse.each_with_index do |row, row_idx|
      display_grid << "|"
      row.each_with_index do |space, col_idx|
        display_grid << " "
        # we have nils, :s, :x, and :-
        # if nil or :s display empty space to the user
        # if :- the attack missed so display a '·' to the user
        # if :x it was an actual hit so display '#' to the user
        case space
        when :-
          display_grid << "·"
        when :x
          display_grid << "#"
        # the :s case is only for debugging random ship placement
        # when :s
        #   display_grid << "S"
        else
          display_grid << " "
        end
        display_grid << "|\n" if col_idx == 9
      end
    end
    display_grid << '----------------------'
    puts display_grid
  end

  # DEBUGGING - PRINT AND ENTER SPACES OF ALL SHIP SEGMENTS FOR QUICK VICTORY
  def answers
    result = []
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |space, col_idx|
        result << [row_idx, col_idx] if space == :s
      end
    end
    result
  end
end
