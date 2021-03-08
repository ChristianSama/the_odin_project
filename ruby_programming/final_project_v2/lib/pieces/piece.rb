class Piece

  attr_reader :position, :color, :sprite, :direction

  def initialize(color, position)
    @color = color
    @position = position
    @direction = @color == :white ? 1 : -1
  end

  def to_s
    @sprite.encode('utf-8')
  end

  def update_position(coord)
    @position[0] = coord[0]
    @position[1] = coord[1]
  end

end