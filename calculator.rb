def options
  puts "Please enter a number use in the calculator."
  num1 = gets.chomp 
  num1 = gets.chomp until num1.to_f.is_a?(Float) && num1.to_f != 0.0

  puts "Please enter another number use in the calculator."
  num2 = gets.chomp 
  num2 = gets.chomp until num2.to_f.is_a?(Float) && num2.to_f != 0.0

  puts "Now, enter an operator to use, enter either '+','-','*',or '/'.",
  "You may also enter 'quit' at this point to exit the program."
  operation = gets.chomp   

  return num1, num2, operation
end






loop do

  num1 ,num2,operation = options

  case operation
  when '+'
    puts "#{num1} - #{num2} = #{num1.to_f - num2.to_f}"
  when '-'
    puts "#{num1} - #{num2} = #{num1.to_f - num2.to_f}"
  when '*'
    puts "#{num1} * #{num2} = #{num1.to_f * num2.to_f}"
  when '/'
    (num2 != "0") ?  puts("#{num1} / #{num2} = #{num1.to_f / num2.to_f}") : 
    puts("Dividing by zero is not a valid operation")
  when 'quit'
    break
  else
    puts "That is not a valid operator."
  end

end

puts "Thank you for using this calculator!"