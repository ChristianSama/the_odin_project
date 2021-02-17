class Pawn < Piece
  attr_reader :posX, :posY, :is_first_move, :is_selected

  def initialize(color, posX, posY)
    super(color)
    @sprite = @color == 'w' ? '♟︎' : '♙'
    @is_first_move = true
    @posX = posX
    @posY = posY
  end

  # def move
  #   if (@is_first_move == true)
  # end

  # def select
  #   @is_selected = true
  # end

  def get_possible_moves
    possible_moves = []
    if (@color == 'w') 
      possible_moves << [posX, posY + 1]
    else
      possible_moves << [posX, posY - 1]
    end
  end
end