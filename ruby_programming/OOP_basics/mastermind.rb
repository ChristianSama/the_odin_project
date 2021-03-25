$COLORS = ["red", "green", "blue", "orange", "black", "white", "yellow", "brown"]

class Computer
  attr_accessor :code
  def initialize
    @code = $COLORS.sample(4)
  end
end

class Player
  def guess
    @arr = []
    puts "Enter your guess:"
    i = 0
    while i < 4 do 
      print "#{i+1}: "
      input = gets.chomp
      if $COLORS.include?(input)
        @arr[i] = input
      else
        "Color not available"
        break
      end
      i += 1
    end
    p @arr
  end
end

class Game
  attr_accessor :code
  attr_accessor :player
  
  def initialize(code, player)
    @code = code
    @player = player
  end

  def start
    tries = 0
    while tries < 3 do
      hints = []
      puts "Try # #{tries+1}"
      input = @player.guess
      if input == @code
        puts "Congratulations you win"
        return
      else
        @code.each_with_index do |el, i|
          if el == input[i]
            hints.push "\u2B24".encode
          elsif @code.include?(input[i])
            hints.push "\u26AA".encode
          else
            hints.push ". "
          end
        end
        hints.sort.reverse.each { |el| print el}
        puts
      end
      tries += 1
    end
    return
  end

end

player = Player.new
comp = Computer.new
game = Game.new(comp.code, player)
p comp.code
game.start
