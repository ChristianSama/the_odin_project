require_relative 'piece'

class King < Piece
  def initialize(color)
    super(color)
    @sprite = @color == 1 ? '♚' : '♔'
  end
end