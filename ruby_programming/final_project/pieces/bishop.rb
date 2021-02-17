require_relative 'piece'

class Bishop < Piece

  def initialize(color)
    super(color)
    @sprite = @color == 1 ? '♝' : '♗'
  end
end