class Bishop < Piece

  def initialize(color, position)
    super(color, position)
    @sprite = color == :white ? "\u265d" : "\u2657"
  end

  def move_set

  end

  def get_possible_moves(board)
    diagonals = [1, -1]
    possible_moves = []
    for j in diagonals do
      for i in diagonals do
        move = @position
        loop do
          move = [move[0] + (i * @direction), move[1] + (j * @direction)]
          piece = board.get_square(move).piece
          if (piece != nil)
            if (piece.color == @color)
              break
            else
              possible_moves << move
              break
            end
          end
          possible_moves << move
        end
      end
    end
  end

end