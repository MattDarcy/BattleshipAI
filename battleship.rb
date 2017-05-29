class BattleshipGame
  attr_reader :board, :player

  def initialize(player1, board1, player2, board2)
    @player1, @player2 = player1, player2
    @board1, @board2 = board1, board2
    @current_attack = nil
    @hit = false
    @turn_player, @not_turn_player = @player1, @player2
  end

  def attack(pos)
    @current_attack = pos
    if get_board[pos] == :s
      get_board[pos] = :x
      @hit = true
    else
      get_board[pos] = :-
      @hit = false
    end
  end

  def count
    get_board.count
  end

  def game_over?
    get_board.won?
  end

  def display_status
    puts "#{@turn_player.name} selected #{@current_attack} -- " +
      "miss\n\n" if !@hit
    puts "#{@turn_player.name} selected #{@current_attack} -- " +
      "HIT\n\n" if @hit
    puts "-- #{@not_turn_player.name}'s fleet --".center(22)
    get_board.display

    if count == 1
      puts "\n#{@not_turn_player.name} has #{count} ship-segment" +
        " remaining.\n\n"
    else
      puts "\n#{@not_turn_player.name} has #{count} ship-segments" +
        " remaining.\n\n"
    end

  end

  def change_turn
    if @turn_player == @player1
      @turn_player = @player2
      @not_turn_player = @player1
    else
      @turn_player = @player1
      @not_turn_player = @player2
    end
  end

  def get_board
    @turn_player == @player1 ? @board2 : @board1
  end

  def adjacents(space)
    result = []
    row, col = space

    if row < get_board.grid.length
      result << [row + 1, col] if get_board.grid[row + 1][col] == 0 \
      || get_board.grid[row + 1][col] == :s
    end

    if row > 0
      result << [row - 1, col] if get_board.grid[row - 1][col] == 0 \
      || get_board.grid[row - 1][col] == :s
    end

    if col < get_board.grid.length
      result << [row, col + 1] if get_board.grid[row][col + 1] == 0 \
      || get_board.grid[row][col + 1] == :s
    end

    if col > 0
      result << [row, col - 1] if get_board.grid[row][col - 1] == 0 \
      || get_board.grid[row][col - 1] == :s
    end

    result
  end

  def play_turn
    if @turn_player.is_a?(HumanPlayer)
      puts "-- #{@not_turn_player.name}'s fleet --".center(22)
      get_board.display
    end
    result = nil
    #puts "Answers: #{get_board.answers}"
    while result.nil? || !(get_board.attacked_spaces.include?(result))
      result = @turn_player.get_play
      redo if get_board.attacked_spaces.include?(result)
      row, col = result
      if @turn_player.is_a?(ComputerPlayer) && get_board.grid[row][col] == :s
        adjacents(result).each { |adj| @turn_player.to_hit << adj }
        #p @turn_player.to_hit
      end
      get_board.attacked_spaces << result
    end
    attack(result)
    display_status
    if count == 0
      puts "GAME OVER--#{@turn_player.name} WINS!\n\n" if count == 0
    else
      sleep(0.5)
      system 'clear'
      puts "#{@not_turn_player.name} will fire--\n\n"
      change_turn
    end
  end

  def play
    until game_over?
      play_turn
    end
  end
end
