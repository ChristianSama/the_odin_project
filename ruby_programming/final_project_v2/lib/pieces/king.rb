class King < Piece

  def initialize(color, position)
    super(color, position)
    @sprite = color == :white ? "\u265a" : "\u2654"
  end
end