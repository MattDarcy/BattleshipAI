class HumanPlayer
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def get_play
    puts "Enter coordinates not yet attacked:"
    result = gets.chomp.split(",").map { |el| Integer(el) }
    system "clear"
    result
  end
end
