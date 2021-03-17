class Rook < Piece
  include Linear_movement

  def initialize(color, position)
    super(color, position)
    @sprite = color == :white ? "\u265c" : "\u2656"
  end

  def get_possible_moves(board)
    possible_moves = []
    axis = [[1, 0], [0, 1], [-1, 0], [0, -1]]
    axis.each do |ax|
      horizontal = linear_moves(self, [ax[0], ax[1]])
      horizontal.each do |move|
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