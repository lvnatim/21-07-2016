# In this file we define the methods to help filter out candidates
# This way, we keep these methods separated from other potential parts of the program
require './candidates'
require 'active_support/all'
require 'colorize'

# Returns candidate array of matched ID
def find(id)
  @candidates.select { |candidate| candidate[:id] == id }
end

# Company requirements checklist methods.
def experienced?(candidate)
  candidate[:years_of_experience] >= 2 ? true : false
end

def enough_points?(candidate)
  candidate[:github_points] > 100 ? true : false
end

def proper_languages?(candidate)
  (candidate[:languages].include?("Ruby") || candidate[:languages].include?("Python")) ? true : false
end

def applied_recently?(candidate)
  candidate[:date_applied] > 15.days.ago.to_date ? true : false
end

def old_enough?(candidate)
  candidate[:age] > 17
end

# Algorithm for determining qualified candidates
def qualified_candidates(candidates)
  @candidates.select do |candidate|
    experienced?(candidate) &&
    enough_points?(candidate) &&
    proper_languages?(candidate) &&
    applied_recently?(candidate) &&
    old_enough?(candidate)
  end
end

# Orders candidates by qualifications.
def ordered_by_qualifications(candidates)
  sorted = candidates.sort_by { |candidate| [candidate[:years_of_experience], candidate[:github_points]] }
  sorted.reverse!
end

# Automatically loads qualified candidates into an array for future access. Automatically sorted.
qualified_unsorted = qualified_candidates(@candidates)
@qualified_array = ordered_by_qualifications(qualified_unsorted)

# Prints candidates from an array of candidates. If empty, returns prompts user for input.
def print_candidates(candidates)
  puts "----- Starting search -----"
  if candidates.empty?
    puts "Couldn't find candidate. Are you sure that's a proper ID integer?"
  else
    candidates.each do |candidate|
      candidate.each do |key, value|
        string = @qualified_array.include?(candidate) ? "#{key} : #{value}".green : "#{key} : #{value}".red
        puts string
      end
    puts "-----------"
    end
  end
end
