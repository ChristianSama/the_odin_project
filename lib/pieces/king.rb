require_relative '../linear_movement'

class King < Piece
  include Linear_movement

  def initialize(color, position)
    super(color, position)
    @sprite = color == :white ? "\u265a" : "\u2654"
  end

  def get_possible_moves(board)
    possible_moves = move_set(board)
    board.castle_moves(self).each { |m| possible_moves << m}
    possible_moves
  end

  def move_set(board)
    possible_moves = []
    axis = [[1, 1], [1, -1], [-1, 1], [-1, -1],
            [1, 0], [0, 1], [-1, 0], [0, -1]]
    axis.each do |ax|
      moves = linear_moves(self, [ax[0], ax[1]], 1)
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