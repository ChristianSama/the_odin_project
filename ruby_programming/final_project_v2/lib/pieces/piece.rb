class Piece

  attr_reader :position, :color, :sprite

  def initialize(color, position)
    @color = color
    @position = position
  end

  def to_s
    @sprite.encode('utf-8')
  end

  def direction
    @color == :white ? 1 : -1
  end

end