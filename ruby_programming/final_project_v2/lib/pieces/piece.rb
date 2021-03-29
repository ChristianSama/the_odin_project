class Piece

  attr_reader :color, :sprite, :direction
  attr_accessor :captured, :has_moved, :position

  def initialize(color, position = nil)
    @color = color
    @captured = []
    @has_moved = false
    @position = position
    @direction = @color == :white ? 1 : -1
  end

  def update_position(coord)
    @position[0] = coord[0]
    @position[1] = coord[1]
  end

  def to_s
    @sprite.encode('utf-8')
  end

end