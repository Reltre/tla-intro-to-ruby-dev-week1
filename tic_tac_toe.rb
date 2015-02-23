

#Hash of possible win positions based around which squares are current empty.
CHECK_HASH = {1 => [[1,2],[3,6],[4,8]],2 => [[0,2],[4,7]],3 => [[0,1],[5,8],[4,7]],
              4 => [[0,6],[4,5]],5 => [[0,8],[1,7],[2,6],[3,5]], 
              6 => [[3,4],[2,8]],7 => [[0,3],[7,8],[2,4]],8=>[[1,4],[6,8]],  
              9 => [[6,7],[2,5],[0,4]]}
               
#Set the initial data for the game board
def initialize_board
  board = {}
  (1..9).each { |k| board[k] = ' ' }
  board
end

#Draw the game board, it is initiall empty.
def draw_board(board)
  system 'clear'
  puts "  #{board[1]} | #{board[2]} | #{board[3]} "
  puts "----+---+----"
  puts "  #{board[4]} | #{board[5]} | #{board[6]} "
  puts "----+---+----"
  puts "  #{board[7]} | #{board[8]} | #{board[9]} "
end

#Checks the board for empty squares, this helps inform both the player
#and the computer about possible moves to make.
def empty_squares(board)
  board.keys.select {|k| board[k] == ' '}
end

def player_picks_a_square(board,player_letter)
  puts "These squares are empty,\n#{empty_squares(board).join(' ')}
please pick one as your move... "
  player_choice = gets.chomp.to_i
  board[player_choice] = player_letter
end


def computer_picks_a_square(board,player_letter,computer_letter)
  
  #Check if the player doesn't have two in a row, then make a
  #strategic move to win the game based on the computer's two in a row.
  if (move_if_two_in_a_row(board,computer_letter))
    computer_choice = move_if_two_in_a_row(board,computer_letter)
 #Check if the player has two in a row, if so block them.
  elsif (move_if_two_in_a_row(board,player_letter)) 
    computer_choice = move_if_two_in_a_row(board,player_letter)
  #Otherwise just pick a random square.  
  else
    computer_choice = empty_squares(board).sample 
  end
  board[computer_choice] = computer_letter
  
end


#This method is used for computer logic.  It allows the computer to decide whether 
#to block the player go try to win the game under differing circumstances.
def move_if_two_in_a_row(board,player_letter)
  
  squares_to_check = empty_squares(board)
  
  if board.values.count(player_letter) >= 2
    move =
    squares_to_check.
    find{|e| CHECK_HASH[e].
    #Checks any of the possible winning conditions around an empty square
    #If any one has two marks, the computer will block.  
    any?{|v| board.
    values[v[0]] == player_letter && board.values[v[1]] == player_letter} }
  end

  return move
    
end


def say_who_won(player,computer)

  if player 
    puts "The player won the game."
  elsif computer
    puts "The Computer won the game."
  else
    puts "Cats game."
  end

end


def horizontal_win?(idx,vals)
    bool_horizontal = 
    [vals[idx * 3],vals[(idx * 3) + 1],vals[(idx * 3) + 2]].all? {|e| e == letter}
    
    return bool_horizontal
end


def vertical_win?(idx,vals)
    bool_vertical = 
    [vals[idx],vals[idx + 3],vals[idx + 6]].all? {|e| e == letter}
    return true if bool_v  
end


def diagonal_win?(vals)
  return true if [vals[0],vals[4],vals[8]].all? {|e| e == letter}
  return true if [vals[2],vals[4],vals[6]].all? {|e| e == letter}
end


def winner?(board,letter)
  vals = board.values
  idx = 0
  
  begin  
    return true if horizontal_win?(idx,vals)
    return true if vertical_win?(idx,vals)
    idx += 1
  end while idx < 3

  return true if diagonal_win?(vals)
  return nil
end  

#Prompt the player to pick a letter, either X or O, and intruct them on 
#how the game is played
begin
puts "Player, would you like to be X or O?"
player_letter = gets.chomp.upcase
end until player_letter == 'X' || player_letter == 'O'
computer_letter = "O" if player_letter == "X" 
computer_letter = "X" if player_letter == "O"


puts "Just to clarify, the top-left square of the board is number 1, the top-middle
is number two, the left-middle is number 4 and so on."
board = initialize_board
draw_board(board)
#Loop until either someone wins
#or it ends in a cat's game.
begin
  
  player_picks_a_square(board,player_letter)
  player = winner?(board,player_letter)  
  computer_picks_a_square(board,player_letter,computer_letter)
  computer = winner?(board,computer_letter)

  draw_board(board)
end until (player || computer) || empty_squares(board).empty?

say_who_won(player,computer)