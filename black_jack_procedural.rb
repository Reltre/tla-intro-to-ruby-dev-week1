#Use a hash to store the possible values of cards, Ace will be stored as an array or two 
#values 1 and 11.

puts "Hi welcome to blackjack.  The goal of this game is to have your cards
add up to a higher value than the dealer.  The dealer, in this case, will be a
computer opponent.  
Cards 1-10 are worth the number on the card. Jack, Queen, and King are worth 10 point.
An ace can be either 1 or 11 depending on what you choose upon it being dealt to you."

DECK = {
  "One"   => 1,
  "Two"   => 2,
  "Three" => 3,
  "Four"  => 4,
  "Five"  => 5,
  "Six"   => 6,
  "Seven" => 7,
  "Eight" => 8,
  "Nine"  => 9,
  "Ten"   => 10,
  "Jack"  => 10,
  "Queen" => 10,
  "King"  => 10,
  "Ace"   => [1,11]
}

SUITS = ["Clubs","Spades","Hearts","Diamonds"]

#Totals for both the player and the computer. 
#Used for persistence of card total throughout
#a round of blackjack.
player_card_total = 0
computer_card_total = 0
computer_hidden_card = 0

computer_hand = []
player_hand = []

def generate_deck
  deck = []
  SUITS.each {|s| DECK.keys.each {|c| deck << [c,s] } }
  deck
end

def deck_shuffle(deck)
  deck.shuffle
end

def deal_card(shuffled_deck)
  shuffled_deck.pop
end

def display_cards(computer_hand,player_hand,name)
  system 'clear'
  puts "Computer's Hand:  
#{computer_hand[0][0]} of #{computer_hand[0][1]}
and one card face down"
  puts "\n"
  puts "#{name}'s Hand: "

  player_hand.each {|c| puts "#{c[0]} of #{c[1]}" }  
end

def display_total(player_total,computer_total,player_name)

  print "Player Total:#{player_total}   "
  print "Computer Total:#{computer_total}\n"
end

def one_or_eleven(card)
  puts "Would you like your Ace be worth 1 or 11?"
  1 == gets.chomp ? HASH[card[0]][0] : HASH[card[0]][1]
end

def initial_player_total(hand,ace = 0)
  result = 
  hand.inject(0) do |memo,c| 
    if c[0] == "Ace" 
      ace = one_or_eleven(c)
      memo += ace
    else
      memo += DECK[c[0]]
    end
  end
  result 
end

def say_bust(is_player)
  if is_player
    puts "You're card value is over 21, you bust and lose the game."
  else
    puts "The computer's card value is over 21 and it has busted!.
You win the game!"
  end
end

def bust?(card_total)
    return true if card_total > 21
    return false
end

=begin
def initial_player_total(player_hand)
  result = 0
  player_hand.each do |card|
    #result = one_or_eleven(card)
    player_card_total += 1

  end
  if player_hand[0][0] == "Ace" && player_hand[1][0] == "Ace"
    return DECK["Ace"][0] + DECK["Ace"][1]
  elsif player_hand[0][0] == "Ace" || player_hand[1][0] == "Ace"
    ace_value = one_or_eleven(player_hand[])
  end
  total(player_hand,ace_value)
end
=end
def deal_cards(computer_hand,player_hand,deck)
  computer_hand << deal_card(deck)
  player_hand << deal_card(deck)
  computer_hand << deal_card(deck)
  player_hand << deal_card(deck) 
end

def initial_computer_total(computer_hand)
  #computer_hidden_card = computer_hand[1]
  
  return "1  or 11" if computer_hand[0][0] == "Ace"
  return DECK[computer_hand[0][0]]
end


#{total(player_hand)} 

#Ask for player's name
puts "Please enter your name."
player_name = gets.chomp
system 'clear'

#Create our deck.
#Note change this to potentially add more than one deck.
deck = generate_deck

#Shuffle the deck twice
shuffled_deck = deck_shuffle(deck)
shuffled_deck = deck_shuffle(deck)

deal_cards(computer_hand,player_hand,shuffled_deck)
display_cards(computer_hand,player_hand,player_name)
player_card_total = initial_player_total(player_hand)
computer_card_total = initial_computer_total(computer_hand)
display_total(player_card_total,computer_card_total,player_name)

begin 
  puts "Hit or Stay?"
  answer = gets.chomp.downcase 
  next if answer != 'hit'

  player_hand << deal_card(shuffled_deck)
  player_card_total += DECK[player_hand.last[0]]

  display_cards(computer_hand,player_hand,player_name)
  display_total(player_card_total,computer_card_total,player_name)

  if bust?(player_card_total)
    say_bust(true)
    break
  end

end while answer == 'hit' 

#Ask if the player wants to hit or stay, it they choose to hit
#deal another card if they choose to stay,  start add ing
#the computer's hand

#puts "Hit or Stay?"

#end



