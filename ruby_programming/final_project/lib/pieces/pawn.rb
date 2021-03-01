require_relative 'piece'

class Pawn < Piece
  attr_reader :has_moved, :en_passant_turn
  attr_accessor :en_passant_capture

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
      piece = board.get_piece(e)
      if (piece != nil && piece.color != self.color)
        possible_moves << e
      end
    end

    if en_passant_capture != nil
      possible_moves << en_passant_capture
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

  def change_location(board, coord)
    board.set_piece(coord, self)
    board.set_piece([@x, @y], nil)
    @x = coord[0]
    @y = coord[1]
    @has_moved = true
  end

  def move(board, coord)
    if (board.get_piece(coord) != nil)
      capture(board, coord)
      return
    end

    if (coord == @en_passant_capture)
      capture_en_passant(board, coord)
      return
    end

    moves = extra_move_set
    if (coord == moves[1])
      change_location(board, coord)
      get_adjacent_pawns(board).each do |pawn|
        pawn.en_passant_capture = moves[0]
      end
      return
    end

    change_location(board, coord)
  end

  def capture_en_passant(board, coord)
    change_location(board, coord)
    pawn_coord = [coord[0], coord[1] + (-1 * @direction)]
    @captured << board.get_piece(pawn_coord)
    board.set_piece(pawn_coord, nil)
  end

  def capture(board, coord)
    piece_to_cap = board.get_piece(coord)
    change_location(board, coord)
    @captured << piece_to_cap
  end

  def get_adjacent_pawns(board)
    pieces = []

    pieces << board.get_piece([@x + 1, @y])
    pieces << board.get_piece([@x - 1, @y])

    # pieces.each do |p|
    #   next if (p == nil)
    #   next if (p.color == @color)
    #   next if (!p.instance_of?(Pawn))
    #   adjacent_enemy_pawns << p
    # end

    pieces.filter do |piece|
      (piece != nil &&
      piece.color != @color &&
      piece.instance_of?(Pawn))
    end

  end
  
end