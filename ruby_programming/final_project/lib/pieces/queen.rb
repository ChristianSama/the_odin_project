require_relative 'piece'

class Queen < Piece
  def initialize(color)
    super(color)
    @sprite = color == :white ? '♛' : '♕'
  end
end