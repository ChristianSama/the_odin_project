require_relative 'piece'

class Bishop < Piece

  def initialize(color)
    super(color)
    @sprite = color == :white ? '♝' : '♗'
  end
end