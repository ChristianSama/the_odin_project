class Rook < Piece

  def initialize(color, position)
    super(color, position)
    @sprite = color == :white ? "\u265c" : "\u2656"
  end

  def get_possible_moves(board)
  #   axis = [[1, 0], [-1, 0], [0, 1], [0, -1]]
  #   possible_moves = []
  #   axis.each do |ax|
  #     move = @position
  #     loop do
  #       move = [move[0] + (ax[0] * @direction), move[1] + (ax[1] * @direction)]
  #       break if (!board.inside_board?(move))
  #       piece = board.get_square(move).piece
  #       if (piece != nil)
  #         if (piece.color != @color)
  #           possible_moves << move
  #         end
  #         break
  #       end
  #       possible_moves << move
  #     end
  #   end
  #   possible_moves
    []
  end

  
end