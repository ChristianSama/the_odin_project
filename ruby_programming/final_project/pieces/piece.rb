class Piece
  attr_reader :sprite, :color

  def initialize(color)
    @color = color
  end

  def to_s
    sprite
  end
end