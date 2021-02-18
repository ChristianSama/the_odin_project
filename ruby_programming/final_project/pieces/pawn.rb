class Pawn < Piece
  attr_reader :posX, :posY, :is_first_move, :is_selected, :possible_moves

  def initialize(color, posX, posY)
    super(color)
    @sprite = @color == 1 ? '♟︎' : '♙'
    @is_first_move = true
    @posX = posX
    @posY = posY
  end

  def select(board)
    @is_selected = true
    @possible_moves = get_possible_moves(board)
    #add dots on possible moves
    @possible_moves.each do |move|
      board.data[move[0]][move[1]] = '.'
    end
  end

  def get_direction
    @color == 1 ? 1 : -1
  end

  def get_possible_moves(board)
    possible_moves = []
    
    # SE DEBE CORREGIR  
    if (board.get_piece([posX, posY + (1 * get_direction)]) == nil)
      possible_moves << [posX, posY + (1 * get_direction)]
      if (@is_first_move && (board.get_piece([posX, posY + (2 * get_direction)]) == nil))
        possible_moves << [posX, posY + (2 * get_direction)]
      end
    end
    # SE DEBE CORREGIR

    return possible_moves
  end

  def remove_possible_moves(board)
    possible_moves.each do |move|
      board.data[move[0]][move[1]] = nil
    end
  end

  def move(board, coord)
    if (@possible_moves.include?(coord))
      p 'ok'
    end
  end
  
end