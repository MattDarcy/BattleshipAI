class ComputerPlayer
  attr_reader :name
  attr_accessor :to_hit

  def initialize(name)
    @name = name
    @to_hit = []
  end

  def get_play
    # returns a random coordinate. BattleshipGame will loop until the
    # coordinate returned has not yet been selected by the PC.

    # every time a hit is made, the valid not-yet-attacked spaces are
    # added to the @to_hit buffer. This makes it so the PC will strive
    # to cluster-fire around hit-areas until it has completely
    # surrounded the hit-group with hits on empty spaces.

    to_hit.empty? ? [rand(10), rand(10)] : to_hit.shift
  end
end
