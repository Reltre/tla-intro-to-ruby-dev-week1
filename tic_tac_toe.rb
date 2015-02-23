

#Hash of possible win positions based around which squares are current empty.
CHECK_HASH = {
  1 => [[1,2],[3,6],[4,8]],
  2 => [[0,2],[4,7]],
  3 => [[0,1],[5,8],[4,7]],
  4 => [[0,6],[4,5]],
  5 => [[0,8],[1,7],[2,6],[3,5]], 
  6 => [[3,4],[2,8]],
  7 => [[0,3],[7,8],[2,4]],
  8 => [[1,4],[6,8]],  
  9 => [[6,7],[2,5],[0,4]]
}
               

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
#to block the player or to try to win the game under differing circumstances.
def move_if_two_in_a_row(board,player_letter)

  if board.values.count(player_letter) >= 2
    move =
    empty_squares(board).find do |empty_square|
      CHECK_HASH[empty_square].any? do |value|
        board.values[value[0]] == player_letter &&
        board.values[value[1]] == player_letter
      end
    end
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


def horizontal_win?(position,squares,letter)
    bool_horizontal = 
    %w(squares[position * 3],
    squares[(position * 3) + 1],
    squares[(position * 3) + 2]).all? {|e| e == letter}
    
    return bool_horizontal
end


def vertical_win?(position,squares,letter)
    bool_vertical = 
    %w(squares[position],
    squares[position + 3],
    squares[position + 6]).all? {|e| e == letter}

    return bool_vertical  
end


def diagonal_win?(squares,letter)
  return %w(squares[0],squares[4],squares[8]).all? {|e| e == letter}
  return %w(squares[2],squares[4],squares[6]).all? {|e| e == letter}
end


def winner?(board,letter)
  squares = board.values
  position = 0
  
  begin  
    return true if horizontal_win?(position,squares,letter)
    return true if vertical_win?(position,squares,letter)
    position += 1
  end while position < 3

  return true if diagonal_win?(squares,letter)

  return false
end  

#Prompt the player to pick a letter, either X or O, and intruct them on 
#how the game is played

puts "Welcome to Tic-Tac-Toe.  In this game you'll first choose a letter,
either X or O.  The goal of the game is to place three of your 
letters in a row on the game board before your opponent can.  You can win
with horizontal, vertical, or diagonal placement.  Good luck!"

begin
  puts "Player, would you like to be X or O?"
  player_letter = gets.chomp.upcase
end until player_letter == 'X' || player_letter == 'O'

if player_letter == "X" 
  computer_letter = "O"
else
  computer_letter = "X" 
end

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