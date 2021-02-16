require_relative 'piece'

class Bishop < Piece

  def initialize(color)
    super(color)
    @sprite = @color == 'w' ? '♝' : '♗'
  end
end