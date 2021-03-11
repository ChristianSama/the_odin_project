class Pawn < Piece

  def initialize(color, position)
    super(color, position)
    @sprite = color == :white ? "\u265f" : "\u2659"
  end

  def get_possible_moves(board)
    moves = []
    #horizontal moves
    moves << [@position[0] + (1 * direction), @position[1]]
    if (!@has_moved)
      moves << [@position[0] + (2 * direction), @position[1]]
    end
    #diagonal moves
    moves << [@position[0] + (1 * @direction), @position[1] + (1 * @direction)]
    moves << [@position[0] + (1 * @direction), @position[1] + (-1 * @direction)]
    return moves
  end
  
end