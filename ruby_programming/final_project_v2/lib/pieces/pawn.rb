class Pawn < Piece

  attr_accessor :has_moved

  def initialize(color)
    super(color)
    @has_moved = false
    @sprite = color == :white ? "\u265f" : "\u2659"
  end

  def move_set
    moves = []
    #horizontal moves
    moves << [@position[0] + (1 * @direction), @position[1]]
    if (!@has_moved)
      moves << [@position[0] + (2 * @direction), @position[1]]
    end
    #diagonal moves
    moves << [@position[0]+ (1 * @direction), @position[1] + (1 * @direction)]
    moves << [@position[0]+ (1 * @direction), @position[1] + (-1 * @direction)]
  end
  
end