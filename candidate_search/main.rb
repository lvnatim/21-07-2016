# This is the main entrypoint into the program
# It requires the other files/gems that it needs

require 'pry'
#require './candidates'
require './filters'

## Your test code can go here
begin
  run_again = true
  print "What would you like to do? "
  input = gets.strip.downcase

  case true
  # Quits the loop
  when input == 'quit'
    run_again = false
  # Scrubs for integer and then tries to print a candidate with that ID
  when input.starts_with?('find ')
    id = input.gsub('find ', '').to_i
    candidate = find(id)
    print_candidates(candidate)
  # Prints out all candidates
  when input == 'all'
    print_candidates(@candidates)
  # Finds all qualified candidates and prints them. Qualified candidates are automatically loaded into an array on startup.
  when input == 'qualified'
    print_candidates(@qualified_array)
  # Can't understand you.
  else
    puts "I couldn't understand that. ('QUIT' to quit. 'ALL' for all candidates. 'FIND <id> to find a certain candidate'. 'QUALIFIED' for qualified candidates)."
  end

end while run_again
