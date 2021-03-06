class Pawn < Piece

  def initialize(color)
    super(color)
    @sprite = color == :white ? "\u265f" : "\u2659"
  end

  def get_move_set
    
  end
  
end