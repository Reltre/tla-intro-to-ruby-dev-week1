CHOICES = {'r' => 'Rock', 'p' => 'Paper', 's' => 'Scissors'}

puts "Welcome to Rock,Paper,Scissors game."

def winning_message(winning_choice)
  if winning_choice == 's'
    puts "Scissors cuts paper."
  elsif winning_choice == 'r'
    puts "Rock smashes scissors."
  else
    puts "Paper wraps rock."
  end
end


loop do
#1. All players pick either p,r, or s
  begin
    puts "Enter you move(r,p,s)"
    player_choice = gets.chomp.downcase
  end until CHOICES.keys.include?(player_choice)

  computer_choice = CHOICES.keys.sample
#2. compare paper > rock, rock > scissors , scissors > paper.  If both players choose the same
#move it's a tie.
  if player_choice == computer_choice
    puts "This game ended in a tie."
  elsif (player_choice == 's' && computer_choice == 'p') || 
        (player_choice.ord < computer_choice.ord)
    winning_message(player_choice)
    puts "You won!"
  else
    winning_message(computer_choice)
    puts "You lost."
  end

#4. Play again?
  puts "Would you like to play again?(y,n)"
  break if gets.chomp.downcase != 'y'


end

puts "Thanks for playing!"

