require_relative 'piece'

class Pawn < Piece
  #can remove :is_selected y :possible_moves
  attr_reader :x, :y, :has_moved, :is_selected, :possible_moves #[[3,2], [3,3]]

  def initialize(color, x, y)
    super(color)
    @sprite = @color == :white ? '♟︎' : '♙'
    @has_moved = false
    @x = x
    @y = y
  end

  def select(board)
    @is_selected = true
    
    #add dots on possible moves
    @possible_moves = get_possible_moves(board)
    add_dots(board)
  end

  def get_direction
    @color == :white ? 1 : -1
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

  def add_dots(board)
    @possible_moves.each do |move|
      board.set_piece(move, '.')
    end
  end

  def remove_dots(board)
    @possible_moves.each do |move|
      board.set_piece(move, nil)
    end
  end

  def move(board, coord)
    board.set_piece(coord, self)
    board.set_piece([@x, @y], nil)
    @x = coord[0]
    @y = coord[1]
    @has_moved = true
    @is_selected = false
  end
  
end