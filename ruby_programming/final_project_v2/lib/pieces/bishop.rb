require_relative '../linear_movement'

class Bishop < Piece
  include Linear_movement
  
  def initialize(color, position)
    super(color, position)
    @sprite = color == :white ? "\u265d" : "\u2657"
  end

  def get_possible_moves(board)
    possible_moves = []
    axis = [1, -1]
    for y in axis do
      for x in axis do
        diagonal = linear_moves(self, [x, y])
        diagonal.each do |move|
          piece = board.get_square(move).piece
          if (piece != nil)
            if (piece.color != @color)
              possible_moves << move
            end
            break
          end
          possible_moves << move
        end
      end
    end
    possible_moves
  end

end