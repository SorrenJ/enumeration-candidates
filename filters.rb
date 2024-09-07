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
  
  def qualified_candidates(candidates)
    

  end
  
  # More methods will go below