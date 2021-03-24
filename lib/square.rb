class Square

  attr_reader :mark
  attr_accessor :piece, :marked

  def initialize
    @mark = '.'
    @marked = false
  end

  def to_s
    @piece
  end
end