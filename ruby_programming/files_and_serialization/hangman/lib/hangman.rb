require 'json'

class Game

  attr_reader :tries
  attr_accessor :game_id
  attr_accessor :word
  attr_accessor :placeholder
  attr_accessor :incorrect_guesses

  def initialize(tries)
    @tries = tries
    @word = ""
    @incorrect_guesses = []
    puts 'game initialized'
  end

  def get_word
    #get word
    words = File.readlines "5desk.txt"
    until (@word.length > 5 && @word.length < 12) do
      @word = words.sample.strip.downcase
    end
    puts word
  end

  def draw_placeholder()
    puts "\n"
    @placeholder.each do |el|
      print el + " "
    end
    puts "\n"
  end

  def make_guess(char)
    guess_index = @word.index(char.downcase)
    if (char == ".") 
      save_game
      puts "game saved"
    elsif (guess_index)
      @placeholder[guess_index] = char
      @word[guess_index] = "_"
      puts "correct guess!"
    else
      @incorrect_guesses.push(char)
      @tries -= 1
      puts "wrong guess!"
    end
    draw_placeholder
    check_win
    print_incorrect
  end

  def check_win
    if (@tries == 0)
      puts "GAME OVER"
    elsif (@placeholder.index("_") == nil)
      puts "YOU WIN!"
      @tries = 0;
    else
      puts "#{tries} tries remaining";
    end
  end

  def print_incorrect
    print "Incorrect guesses: "
    @incorrect_guesses.each_with_index do |el, i|
      if (i == @incorrect_guesses.length - 1)
        print "#{el}"
      else
        print "#{el}, "
      end
    end
    puts "\n"
  end

  def save_game
    Dir.mkdir("saved") unless Dir.exists?("saved")
    filename = "saved/game_#{@game_id}.txt"
    save_data = {:game_id => @game_id,
                 :tries => @tries,
                 :incorrect_guesses => @incorrect_guesses,
                 :placeholder => @placeholder,
                 :word => @word}.to_json

    File.open(filename, 'w') do |file|
       file.puts save_data
    end
  end

  def new_game
    dir = './saved'
    @game_id = Dir[File.join(dir, '**', '*')].count { |file| File.file?(file) } + 1
    puts "Game ID: #{@game_id}"
    get_word
    @placeholder = Array.new(word.length, "_")
    continue_game
  end

  def continue_game
    puts "#{@tries} tries remaining";
    draw_placeholder
      while @tries > 0 do
        puts "\n--------------------------"
        puts "Enter a character"
        input_char = gets.chomp
        make_guess(input_char)
      end
  end

  def load_game
    valid_ids = []
    Dir.glob("./saved/*.txt") do |my_text_file|
      data = JSON.parse(File.read(my_text_file))
      valid_ids.push(data["game_id"])
      puts "ID: #{data["game_id"]} - Tries left: #{data["tries"]} - State: #{data["placeholder"].join}"
    end
    puts "enter a valid id number"
    input_id = gets.chomp.to_i
    if (valid_ids.include?(input_id))
      data_to_load = JSON.parse(File.read("./saved/game_#{input_id}.txt"))
      @game_id = data_to_load["game_id"]
      @tries = data_to_load["tries"]
      @incorrect_guesses = data_to_load["incorrect_guesses"]
      @placeholder = data_to_load["placeholder"]
      @word = data_to_load["word"]
      continue_game
    else
      puts "invalid ID"
    end
  end

  def start
    puts "enter \'n\' for new game or \'s\' to load a saved game"
    input = gets.chomp
    if (input == "n")
      new_game
    elsif (input == "s")
      load_game
    else
      puts "incorrect input"
    end
  end
end

my_game = Game.new(10)

my_game.start

