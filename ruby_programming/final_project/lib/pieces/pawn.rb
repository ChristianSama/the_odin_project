class Pawn < Piece
  attr_reader :x, :x, :is_first_move, :is_selected, :possible_moves

  def initialize(color, x, y)
    super(color)
    @sprite = @color == 1 ? '♟︎' : '♙'
    @is_first_move = true
    @x = x
    @y = y
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
    if (board.get_piece([x, y + (1 * get_direction)]) == nil)
      possible_moves << [x, y + (1 * get_direction)]
      if (@is_first_move && (board.get_piece([x, y + (2 * get_direction)]) == nil))
        possible_moves << [x, y + (2 * get_direction)]
      end
    end
    # SE DEBE CORREGIR

    return possible_moves
  end

  def move_set
    set = []
    set << [@x + (1 * get_direction), @y + (-1 * get_direction) ]
    set << [@x, @y + (1 * get_direction)]
    set
  end

  def extra_move_set
    set = []
    move_set.each { |e| set << e}
    set << [@x, @y + (2 * get_direction)]
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