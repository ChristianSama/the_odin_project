require_relative 'piece'

class Queen < Piece
  def initialize(color)
    super(color)
    @sprite = @color == 'w' ? '♛' : '♕'
  end
end