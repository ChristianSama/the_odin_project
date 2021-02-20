class Pawn < Piece
  attr_reader :x, :y, :has_moved, :is_selected, :possible_moves

  def initialize(color, x, y)
    super(color)
    @sprite = @color == 1 ? '♟︎' : '♙'
    @has_moved = false
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

    if (!@has_moved)
      extra_move_set.each do |e| 
        if (board.get_piece(e) == nil)
          possible_moves << e
        end
      end
    else
      move_set.each do |e|
        if (board.get_piece(e) == nil)  
          possible_moves << e
        end
      end
    end

    capture_set.each do |e|
      if (board.get_piece(e))
        possible_moves << e
      end
    end

    return possible_moves
  end

  def move_set
    set = []
    set << [@x, @y + (1 * get_direction)]
    set
  end

  def extra_move_set
    set = []
    set << move_set[0]
    set << [@x, @y + (2 * get_direction)]
    set
  end

  def capture_set
    set = []
    set << [@x + (1 * get_direction), @y + (1 * get_direction)]
    set << [@x + (-1 * get_direction), @y + (1 * get_direction)]
    set
  end

  def move(board, coord)
    if (@possible_moves.include?(coord))
      p 'ok'
    end
  end
  @has_moved = true
  @is_selected = false
end