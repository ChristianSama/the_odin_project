class Pawn < Piece
  attr_reader :posX, :posY, :is_first_move, :is_selected

  def initialize(color, posX, posY)
    super(color)
    @sprite = @color == 1 ? '♟︎' : '♙'
    @is_first_move = true
    @posX = posX
    @posY = posY
  end

  # def move
  #   if (@is_first_move == true)
  # end

  def select(board)
    @is_selected = true
    #add dots on possible moves
    get_possible_moves(board).each do |move|
      board.data[move[0]][move[1]] = '.'
    end
  end

  def get_direction
    @color == 1 ? 1 : -1
  end

  def get_possible_moves(board)
    possible_moves = []
     
    if (board.data[posX][posY + (1 * get_direction)] == nil)
      possible_moves << [posX, posY + (1 * get_direction)]
      if (@is_first_move && (board.data[posX][posY + (2 * get_direction)] == nil))
        possible_moves << [posX, posY + (2 * get_direction)]
      end
    end

    return possible_moves
  end
end