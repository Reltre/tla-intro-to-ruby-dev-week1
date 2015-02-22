
def get_words_from_file(my_file)
  words = File.open(my_file,'r') do |f|
    f.read
  end.split
  words
end

nouns = get_words_from_file('nouns.txt')
verbs = get_words_from_file('verbs.txt')
adjectives = get_words_from_file('adjectives.txt')


def say(msg)
  puts "=> #{msg}"
end

def exit_with(msg)
  say msg
  exit
end

def get_input(word)
  puts "Input a #{word}"
  noun = STDIN.gets.chomp
end

#Check if there is a file here. or if the file name is correct
exit_with("No input file.") if ARGV.empty?
exit_with("Input file doesn't exist.") if !File.exists?(ARGV[0])

#read in the file contents.
contents = File.open(ARGV[0],'r') do |f|
  f.read
end


puts "Would you like to input nouns, verbs, and adjectives to add to our
reverse madlibs, or take them from a list?(y/n)"
ans = STDIN.gets.chomp.downcase

if ans == 'y'

  contents.gsub!('NOUN').each do |noun|
    get_input(noun)
  end

  contents.gsub!('VERB').each do |verb|
    get_input(verb)
  end

  contents.gsub!('ADJECTIVE').each do |adjective|
    get_input(adjective)
  end
else
  contents.gsub!('NOUN').each {nouns.sample}
  contents.gsub!('VERB').each {verbs.sample}
  contents.gsub!('ADJECTIVE').each {adjectives.sample}
end

p contents  




 
