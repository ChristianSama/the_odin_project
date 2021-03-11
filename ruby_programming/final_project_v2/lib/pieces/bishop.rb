class Bishop < Piece

  def initialize(color, position)
    super(color, position)
    @sprite = color == :white ? "\u265d" : "\u2657"
  end

  def get_possible_moves(board)
    diagonals = [1, -1]
    possible_moves = []
    for j in diagonals do
      for i in diagonals do
        move = @position
        loop do
          move = [move[0] + (i * @direction), move[1] + (j * @direction)]
          break if (!board.inside_board?(move))
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

  def get_capturable_pieces(board)
    pieces = []
    get_possible_moves(board).each do |move|
      piece = board.get_square(move).piece  
      if (piece.color != @color)
        pieces << piece
      end
    end
    pieces
  end

end