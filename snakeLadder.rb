class SnakeLadder
  attr_reader :board , :snakes , :ladders

  def initialize
    @board=[]
    @snakes=[]
    @ladders=[]
    create_board
    snake_placement
    ladder_placement
  end

  def create_board
    101.times do |i|
      @board<<i
    end
  end
  
  def snake_placement

    7.times  { @snakes<<rand(11..97) }
    @snakes.sort!.uniq!
    @snakes.each do |pos|
      upper_limit=((pos/10))*10
      pos % 10 == 0 ? upper_limit-=10 : upper_limit
      @board[pos]=rand(3..upper_limit)
    end

  end


  def ladder_placement

    7.times { @ladders<<rand(3..90) }
    @ladders.sort!.uniq!
    @ladders.each do |pos|
      lower_limit=((pos/10)+1)*10+1
      pos % 10 == 0 ? lower_limit-=10 : lower_limit
      @board[pos]=rand(lower_limit..97)
    end

  end

  def is_ladder_used(obj)
    if @ladders.include?(obj.current_pos) 
      puts "********************* #{obj.name} have climbed a ladder from #{obj.current_pos} to #{@board[obj.current_pos]} *********************"
      obj.current_pos=@board[obj.current_pos]
    end
  end

  def is_snake_bitten(obj)
    if @snakes.include?(obj.current_pos)
      puts "******************** #{obj.name} have been bitten by a snake at #{obj.current_pos} now go to #{@board[obj.current_pos]} ************************"
      obj.current_pos=@board[obj.current_pos]
    end
  end



def logger
  show_snakes
  show_ladders
  show_board
end

private

  def show_board
    puts "Board of Snake and ladder : "
    @board.each do |box|
       print " #{box != 0 ? box : ""} " 
    end
    puts ""
  end

  def show_snakes
    puts "Sankes are placed as follows "
    @snakes.each do |i|
      puts " #{i} --> #{board[i]} "
    end
  end

  def show_ladders
    puts "Ladders are placed as follows "
    @ladders.each do |i|
      puts " #{i} --> #{board[i]} "
    end
  end

end

class Player 

  attr_accessor :name , :current_pos
  
  @@player_count=1

  def initialize(name="Player-#{@@player_count}")
    @current_pos=1
    @name=name
    @@player_count+=1
    @a=[]
  end

  def roll_the_dice
    curr_dice_val=rand(1..6)
    puts " #{@name} got #{curr_dice_val} "
    @current_pos+=curr_dice_val
    if @current_pos > 100
      @current_pos-=curr_dice_val
      puts " #{@name} need  only #{100 - @current_pos } to win the game , try for small no. "
    end
  end

  def show_current_position
    puts " #{@name} is currently at #{@current_pos} . "
  end


  

  def is_won_the_game
    if @current_pos==100
      return true
    else
      return false
    end
  end

end



def dont_want_to_play
  print " Press any key to roll the dice and q to exit the game : "
  response=gets.chomp.downcase
  if response == "q"
    return true
  else
    return false
  end
end


game=SnakeLadder.new
game.logger
puts "\n\n"
print "Enter name of 1st player : "
name1=gets.chomp
player1 = name1.empty? ? Player.new : Player.new(name1)
print "Enter name of 2nd player : "
name2=gets.chomp
player2= name2.empty? ? Player.new : Player.new(name2)
puts "\n\nWelcome #{player1.name} , #{player2.name} to our Snake and Ladder Game\n\n"
player1.show_current_position
player2.show_current_position
puts "\n\n"
while  !(player1.is_won_the_game || player2.is_won_the_game) do
  puts "\n\n #{player1.name}'s turn \n\n"
  player1.show_current_position
  break if dont_want_to_play
 
  player1.roll_the_dice
  game.is_snake_bitten(player1)
  game.is_ladder_used(player1)
  player1.show_current_position

  if player1.is_won_the_game 
    puts " #{player1.name} has won the game ."
    break
  end

  puts "\n\n #{player2.name}'s turn \n\n"
  player2.show_current_position
  break if dont_want_to_play

  
  player2.roll_the_dice
  game.is_snake_bitten(player2)
  game.is_ladder_used(player2)
  player2.show_current_position

  if player2.is_won_the_game
    puts " #{player2.name} has won the game ."
    break
  end
end