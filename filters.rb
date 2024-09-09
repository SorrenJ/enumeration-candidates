# In this file we define the methods to help filter out candidates
# This way, we keep these methods separated from other potential parts of the program

def find(id)
    # Returns the candidate with that :id
    @candidates.find { |candidate| candidate[:id] == id }


  end
  
def experienced?(candidate)
    # Takes an id, returns the candidate with that :id if there is no candidate with that id, naturally returns nil
    # No output (puts)
    
    candidate[:years_of_experience] >= 2

  end
  
def has_enough_github_points?(candidate)
  candidate[:github_points] >= 100
  end

def knows_required_languages?(candidate)
  required_languages = ['Ruby', 'Python']
  (candidate[:languages] & required_languages).any?
  end

def applied_recently?(candidate)
  candidate[:date_applied] >= 15.days.ago.to_date
  end

def is_of_age?(candidate)
  candidate[:age] > 17
  end

def qualified_candidates(candidates)
  candidates.select do |candidate|
    experienced?(candidate) &&
    has_enough_github_points?(candidate) &&
    knows_required_languages?(candidate) &&
    applied_recently?(candidate) &&
    is_of_age?(candidate) 

    end
end  
  