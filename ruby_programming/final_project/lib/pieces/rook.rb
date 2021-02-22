require_relative 'piece'

class Rook < Piece
  def initialize(color)
    super(color)
    @sprite = color == :white ? '♜' : '♖'
  end
end