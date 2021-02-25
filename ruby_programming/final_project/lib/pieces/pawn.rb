require_relative 'piece'

class Pawn < Piece
  attr_reader :has_moved

  def initialize(color, x, y)
    super(color, x, y)
    @sprite = @color == :white ? '♟︎' : '♙'
    @has_moved = false
  end

  def select(board)
    @possible_moves = get_possible_moves(board)
    add_dots(board)
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
    set << [@x, @y + (1 * @direction)]
    set
  end

  def extra_move_set
    set = [] 
    set << move_set[0]
    set << [@x, @y + (2 * @direction)]
    set
  end

  def capture_set
    set = []
    set << [@x + (1 * @direction), @y + (1 * @direction)]
    set << [@x + (-1 * @direction), @y + (1 * @direction)]
    set
  end

  def add_dots(board)
    @possible_moves.each do |move|
      if (board.get_piece(move) == nil)
        board.set_piece(move, '.')
      end
    end
  end

  def remove_dots(board)
    @possible_moves.each do |move|
      if (board.get_piece(move) == nil) 
        board.set_piece(move, nil)
      end
    end
  end

  def move(board, coord)
    tile_to_move = board.get_piece(coord)
    # if (coord == extra_move_set[1])
      
    # end
    board.set_piece(coord, self)
    board.set_piece([@x, @y], nil)
    @x = coord[0]
    @y = coord[1]
    
    if (tile_to_move)
      @captured << tile_to_move
    end
    @has_moved = true
  end
  
end