class Piece
  attr_reader :x, :y, :direction, :sprite, :color, :possible_moves, :captured

  def initialize(color, x, y)
    @color = color
    @direction = color == :white ? 1 : -1
    @x = x
    @y = y
    @captured = []
  end

  def to_s
    sprite
  end
end