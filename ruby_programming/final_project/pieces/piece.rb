class Piece
  attr_reader :sprite, :color

  def initialize(color)
    @color = color == 'w' ? 'w' : 'b'
  end
end