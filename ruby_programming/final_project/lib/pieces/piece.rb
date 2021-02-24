class Piece
  attr_reader :x, :y, :sprite, :color, :possible_moves, :captured

  def initialize(color, x, y)
    @color = color
    @x = x
    @y = y
    @captured = []
  end

  def to_s
    sprite
  end
end