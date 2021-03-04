class Pawn < Piece

  def initialize(color)
    super(color)
    @sprite = color == :white ? "\u2659" : "\u265f"
  end

  def get_move_set
    
  end
  
end