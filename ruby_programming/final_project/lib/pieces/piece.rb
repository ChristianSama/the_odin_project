class Piece
  attr_reader :direction, :sprite, :color, :possible_moves, :captured
  attr_accessor :x, :y

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