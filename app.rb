# TODO
# 2 - classes of real ships
# 3 - pc player with AI
# 4 - final test of all

# require won't work here, used require_relative
#require "byebug"
require_relative "battleship"
require_relative "board"
require_relative "player"
require_relative "computer"

def make_player(player, isAI=false)
  if !isAI
    puts "Enter #{player} name:"
    HumanPlayer.new(gets.chomp)
  else
    ComputerPlayer.new(player)
  end
end

if __FILE__ == $PROGRAM_NAME

  play_game = true
  puts "\nWelcome to BATTLESHIP!"

  while play_game
    puts "\nWill you play the PC? (yes/no)"
    input = gets.chomp.downcase
    system "clear"
    if input == "yes"
      p1 = make_player("Player 1")
      p2 = make_player("Computer")
    elsif input == "no"
      p1 = make_player("Player 1")
      p2 = make_player("Player 2")
    elsif input == "pcpc"
      p1 = make_player("Computer 1", true)
      p2 = make_player("Computer 2", true)
    else
      puts "Try a valid answer next time!"
      exit
    end
    system "clear"
    b1 = Board.new; b2 = Board.new
    b1.place_ships; b2.place_ships
    game = BattleshipGame.new(p1, b1, p2, b2)
    game.play
    puts "Play again? (yes/no)"
    input = gets.chomp
    input == "yes" ? redo : (puts "Thank you for playing!")
    exit
  end
end
