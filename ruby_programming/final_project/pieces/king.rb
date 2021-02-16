require_relative 'piece'

class King < Piece
  def initialize(color)
    super(color)
    @sprite = @color == 'w' ? '♚' : '♔'
  end
end