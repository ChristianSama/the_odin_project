require_relative 'piece'

class Queen < Piece
  def initialize(color)
    super(color)
    @sprite = @color == 1 ? '♛' : '♕'
  end
end