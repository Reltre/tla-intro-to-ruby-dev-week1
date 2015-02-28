#Use a hash to store the possible values of cards, Ace will be stored as an array or two 
#values 1 and 11.

puts "Hi welcome to blackjack.  The goal of this game is to have your cards
add up to a higher value than the dealer.  The dealer, in this case, will be a
computer opponent.  
Cards 1-10 are worth the number on the card. Jack, Queen, and King are worth 10 points.
An ace can be either 1 or 11 depending on what you choose upon it being dealt to you.\n\n"

DECK = {
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

def deal_cards(computer_hand,player_hand,deck)
  computer_hand << deal_card(deck)
  player_hand << deal_card(deck)
  computer_hand << deal_card(deck)
  player_hand << deal_card(deck) 
end

def display_cards(hand,name,computer_turn)
  if  !computer_turn && name == "Computer"
    puts "Computer's Hand:  
#{hand[0][0]} of #{hand[0][1]}
and one card face down"
  else
    puts "#{name}'s Hand: "
    hand.each {|c| puts "#{c[0]} of #{c[1]}" }  
  end

  print "\n\n"
end

def display_total(player_total,computer_total,player_name)
  print "Player Total:#{player_total}   "
  if computer_total.is_a?(Array)
    print "Computer Total: 1 or 11\n"
  else
    print "Computer Total: #{computer_total}\n"
  end

  print "\n"
end

def say_bust(player_name)
  if player_name != "Computer"
    puts "#{player_name}'s card value is over 21, you bust and lose the game."
  else
    puts "The computer's card value is over 21 and it has busted!.
You win the game!"
  end
end

def say_results(player_hand,computer_hand,player_total,computer_total,name)
  if (player_total > computer_total) 
    puts "#{name} wins!"
  elsif (player_total < computer_total) 
    puts "Computer Wins."
  else
    if (blackjack?(player_hand,player_total) && 
        blackjack?(computer_hand,computer_total))
      puts "Push."
    elsif (blackjack?(player_hand,player_total) &&
       !blackjack?(computer_hand,compute_total))
      puts "Blackjack.#{name} wins!"
    elsif ( !blackjack?(player_hand,player_total) &&
       blackjack?(computer_hand,compute_total) )
      puts "The Computer has Blackjack,it wins."
    else
      puts "Push."
    end
  end
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

def handle_ace_values(total,card,aces)
    while total > 21 && aces != 0 
      total = total - DECK[card[0]][1] + DECK[card[0]][0]
      aces -= 1
    end

    return total
end

def compute_total(hand,total)
  ace_count = 0
  hand.each do |card|  
    if(ace?(card))
      total += DECK[card[0]][1]
      ace_count += 1
    else
      total += DECK[card[0]]
    end

    if total > 21
        total = handle_ace_values(total,card, ace_count)
      end
    
  end

  return total
end

def initial_computer_total(hand)
  return DECK[hand[0][0]]
end

def add_to_player_total(card)  
 
  if card[0] == "Ace" 
    ace = one_or_eleven(card) 
    return ace
  end

  return DECK[card[0]] 
end

def one_or_eleven(card)
  puts "Would you like your Ace be worth 1 or 11?"
  1 == gets.chomp ? DECK[card[0]][0] : DECK[card[0]][1]
end


def ace?(card)
  return DECK[card[0]].is_a?(Array) 
end

def blackjack?(hand,total)
  total = 0
  hand.count == 2 && compute_total(hand,total) == 21
end
  
def bust?(card_total)
    card_total > 21
end

#Ask for player's name
puts "Please enter your name."
player_name = gets.chomp
system 'clear'

#Loop through the game.
begin
  system  'clear'

  play_again = false

  player_card_total = 0
  computer_card_total = 0

  computer_hand = []
  player_hand = []
  #Create our deck.
  #Between 2 and 6 decks are used in this game.
  deck = []
  number_of_decks = [2,3,4,5,6].sample
  number_of_decks.times {deck += generate_deck}
  
  #Shuffle the decks twice
  shuffled_deck = deck_shuffle(deck)
  shuffled_deck = deck_shuffle(deck)
  
  deal_cards(computer_hand,player_hand,shuffled_deck)
  
  display_cards(computer_hand,"Computer",false)
  display_cards(player_hand,player_name,false)
  
  player_card_total = initial_player_total(player_hand)
  computer_card_total = initial_computer_total(computer_hand)
  display_total(player_card_total,computer_card_total,player_name)
  
  #Run through players hand
  begin 
    puts "Hit or Stay?"
    answer = gets.chomp.downcase 
    next if answer != 'hit'
    
    system 'clear'
   
  
    player_hand << deal_card(shuffled_deck)
    player_card_total += add_to_player_total(player_hand.last)
  
    display_cards(computer_hand,"Computer",false)
    display_cards(player_hand,player_name,false)
    display_total(player_card_total,computer_card_total,player_name)
  
    if bust?(player_card_total)
      say_bust(player_name)
      break
    end
  
  end while answer == 'hit' 
  
  #If player busted, ask if they want to play again?
  if bust?(player_card_total) 
    puts "Play again?(y/n)"
    answer = gets.chomp.downcase
    answer == 'y' ? redo : puts("Thanks for playing"); break 
  end

  #Run through computer's hand
  begin 
    computer_card_total = 0
    computer_hand << deal_card(shuffled_deck)
    computer_card_total = compute_total(computer_hand,computer_card_total)
  
    display_cards(computer_hand,"Computer",true)
    display_cards(player_hand,player_name,false)
  
    display_total(player_card_total,computer_card_total,player_name)
  
    if bust?(computer_card_total)
      say_bust("Computer")
      break
    end
  
  end while computer_card_total < 17
  
  if !bust?(computer_card_total)
    say_results(player_hand,
      computer_hand,player_card_total,
      computer_card_total,
      player_name)
  end

  puts "\nThat's the end of the round.  Would you like to play again?(y/n)"
  answer = gets.chomp.downcase
  answer == 'y' ? play_again = true : puts("Thanks for playing")

end while play_again == true && shuffled_deck.size > 20
 



