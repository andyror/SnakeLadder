boxes=Array.new(101)          #boxes from 1 to 100

def roll_dice
 rand(1..6)
end

def init_board(boxes)
 #p "intializing board"
 for i in 1..100 do
   boxes[i]=i
 end
end


def show_board(boxes)
p "Showing Board"
 for box in boxes do
   puts box
 end
end

def place_ladder(boxes)
 #p "Ladder placment section begins"
loc=Array.new(7)
 i=0
 loop do
   loc[i]=rand(3..90)
   i=i+1
   break if i==7
 end
 uniq_loc= loc.uniq.sort
 #p "Box Location Generated: "
 #p uniq_loc
 #p "**********"
 for l in uniq_loc
  lower_limit=((l/10)+1)*10+1
   if(l % 10 == 0)
     lower_limit=lower_limit-10;
   end
   boxes[l]=rand(lower_limit..97)
 end
 p "Ladders are placed at : "
 for l in uniq_loc do
   p "#{l} -->  #{boxes[l]}"
 end
end

def place_snake(boxes)
 #p "Snake placment section begins"
loc=Array.new(7)
 i=0
 loop do
   loc[i]=rand(11..97)
   i=i+1
   break if i==7
 end
 uniq_loc= loc.uniq.sort
 #p "Box Location Generated: "
 #p uniq_loc
 #p "**********"
 for l in uniq_loc
  upper_limit=((l/10))*10
   if(l % 10 == 0)
     upper_limit=upper_limit-10;
   end
   boxes[l]=rand(3..upper_limit)
 end
 p "Snakes are placed at : "
 for l in uniq_loc do
   p "#{l} -->  #{boxes[l]}"
 end
end



init_board(boxes)
place_ladder(boxes)
place_snake(boxes)


players=Array.new(2)
current_pos=Array.new(2)
print "Name of first player : "
players[0]=gets.chomp
print "Name of Second player : "
players[1]=gets.chomp
current_pos[0]=1
current_pos[1]=1
p "Starting Position of #{players[0]} : #{current_pos[0]}"
p "Starting Position of #{players[1]} : #{current_pos[1]}"
loop do 
 puts "\n\n"
 p "#{players[0]} turn : "
 p "press any key to Roll the dice , q to quit"
 response=gets.chomp
 break if response== "q"
 p "Current Position of #{players[0]} : #{current_pos[0]} ."
 dice_value=roll_dice
 p "Rolling dice ...... ,it's #{dice_value}"
   if current_pos[0]+dice_value > 100 
     p "try for lower Dice values"
   else
   current_pos[0]=current_pos[0]+dice_value
     if current_pos[0] < boxes[current_pos[0]]
       p "*******  Ladder *******"
     elsif current_pos[0] > boxes[current_pos[0]]
       p "*******  Snake *******"
     end
   current_pos[0]=boxes[current_pos[0]]
   p "Current Position of #{players[0]} : #{current_pos[0]} ."
     if current_pos[0] ==100 
       p "#{players[0]} Won"
       break
     end
 end
 puts "\n\n"
   p "#{players[1]} turn : "
   p "press any key to Roll the dice , q to quit"
   response=gets.chomp
   break if response== "q"
 p "Current Position of #{players[1]} : #{current_pos[1]} ."
 dice_value=roll_dice
 p "Rolling dice ...... ,it's #{dice_value}"
   if current_pos[1]+dice_value > 100 
     p "try for lower Dice values"
   else
     current_pos[1]=current_pos[1]+dice_value
       if current_pos[1] < boxes[current_pos[1]]
         p "*******  Ladder *******"
       elsif current_pos[1] > boxes[current_pos[1]]
         p "*******  Snake *******"
       end
     current_pos[1]=boxes[current_pos[1]]
     p "Current Position of #{players[1]} : #{current_pos[1]} ."
       if current_pos[1] ==100 
         p "#{players[1]} Won"
         break
       end
   end
end


