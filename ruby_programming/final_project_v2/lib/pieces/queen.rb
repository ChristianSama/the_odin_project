require_relative '../movement'

class Queen < Piece
  include Movement

  def initialize(color, position = nil)
    super(color, position)
    @sprite = color == :white ? "\u265b" : "\u2655"
  end

  def get_possible_moves(board)
    possible_moves = []
    axis = [[1, 1], [1, -1], [-1, 1], [-1, -1],
            [1, 0], [0, 1], [-1, 0], [0, -1]]
    axis.each do |ax|
      moves = linear_moves(self, [ax[0], ax[1]])
      moves.each do |move|
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
    possible_moves
  end
end