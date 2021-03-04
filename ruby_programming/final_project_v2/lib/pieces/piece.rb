class Piece

  attr_reader :color, :sprite

  def initialize(color)
    @color = color
  end

  def to_s
    @sprite.encode('utf-8')
  end

end