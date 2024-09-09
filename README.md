# Enumeration Candidates

A ruby exercise to practice accessinng and mainpulating a simple DB.

## Setup

You must install the ruby bundle to start. In your terminal write:

`bundle install`

## How to run

To run the program simply write this in your terminal:

`ruby main.rb`

## Solutions

Here are my notes towards the assignment for viewing pleasure

### Task 1

In the filters.rb file, define the method `experienced?` such that it:
- Takes in a **single** `candidate` (hash). Note: not the array.
- Returns `true` if the candidate has 2 years of experience or more
- Returns `false` otherwise

Note: this is a method that gives you back data, it should not output (puts) anything.
#### Defining and accessing a hash 

Use `hash[key]` to access a value from a hash.

``` ruby
candidate = {
  id: 5,
  years_of_experience: 4,
  github_points: 293,
  languages: ['C', 'Ruby', 'Python', 'Clojure'],
  date_applied: 5.days.ago.to_date,
  age: 26
}

# Access the years_of_experience value
years = candidate[:years_of_experience]
puts "Years of Experience: #{years}"  # Output: Years of Experience: 4

```


let's add a conditional

``` ruby
def experienced?(candidate)
  candidate[:years_of_experience] >= 2
end

puts experienced?(candidate)  # Output: true

```

### Task 2
Define a method `find` that:
- Takes in an `id`
- Returns the `candidate` with that `:id`
- If there is no candidate with that `id`, it naturally returns `nil`
#### Instance variables

Variables that belong to a specifc instance of a class. Stores information of the object created from a class . Use @ to represent an instance variable 


``` ruby

class CarMaker
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def name_length
    name.size
  end
end

honda = CarMaker.new('honda')
toyota = CarMaker.new('toyota')
honda.name
#=> "honda"
honda.name_length
#=> 5

```


in this case @name is our instance variable for the class carMaker, storing a name string


for candidates it isnt a instance variable for class but a top - level instance variable

``` ruby

@candidates = [ { id: 5, years_of_experience: 4, github_points: 293 }, 
{ id: 7, years_of_experience: 1, github_points: 145 } 
] 

def print_candidates 
	puts @candidates 
end 

print_candidates
```

since @candidates is top -level it can be accessed inside any method defined at the top level


#### .find method

iterates over each element of the array and returns the first element that satisfies a condition

In this case, it is iterating over `@candidates`, which is an array of hashes.

If `.find` doesn't find any matching element, it returns `nil` by default.

#### { |candidate| ... }

{ |candidate| ... } is the block passed  to the .find method. Blocks are anymous pieces of code that can take input (parameters) and execute some logic


Here, the block takes one argument, `candidate`, which represents each element (or hash) in the `@candidates` array during iteration


#### candidate[:id] == id

Inside the block, `candidate[:id]` accesses the `:id` key from the current `candidate` hash. For example:

``` ruby
candidate = { id: 5, years_of_experience: 4, github_points: 293 }
candidate[:id]  # This returns 5


```


Full code

``` ruby

def find(id)

    # Returns the candidate with that :id

    @candidates.find { |candidate| candidate[:id] == id }

  
  

  end
```


1.  `@candidates.find` starts iterating over each element in the `@candidates` array. (i.e. candidate = { id: 5, years_of_experience: 4, github_points: 293 } )

2.  { |candidate| candidate[:id] == id } : A block that checks if the `:id` of each `candidate` matches the given `id`.

3.  `.find` returns the **first candidate** whose `:id` matches the input `id`, or `nil` if no match is found.

### Task 3

Define a method `qualified_candidates` in `filters.rb` that:

- Takes in the collection of `candidates`
- Returns a subset of the `candidates` that meet the following criteria:
    - Are experienced
    - Have 100 or more Github points
    - Know at least Ruby or Python
    - Applied in the last 15 days
    - Are over the age of 17 (18+)

Tip: Consider creating other methods to help keep this clean.


Are experienced

``` ruby
def experienced?(candidate) 
candidate[:years_of_experience] >= 2 
end

```

Have 100 or more Github points


``` ruby
def has_enough_github_points?(candidate) 
candidate[:github_points] >= 100 
end
```

Know at least Ruby or Python

``` ruby
def knows_required_languages?(candidate) 
required_languages = ['Ruby', 'Python'] 
(candidate[:languages] & required_languages).any? 
end

```

Applied in the last 15 days

``` ruby
def applied_recently?(candidate) 
candidate[:date_applied] >= 15.days.ago.to_date 
end
```


 Are over the age of 17 (18+)

``` ruby
def is_of_age?(candidate) 
candidate[:age] > 17 
end
```


#### **`qualified_candidates` Method**:

This method uses `select` to filter candidates by applying all the above conditions using the helper methods. Only candidates who meet all the criteria will be returned.

``` ruby

def qualified_candidates(candidates) 
	candidates.select do |candidate| 
		experienced?(candidate) && 
		has_enough_github_points?(candidate) && 
		knows_required_languages?(candidate) && 
		applied_recently?(candidate) && 
		is_of_age?(candidate) 
	end 
end
```


### Task 4

Define a method `ordered_by_qualifications` in `filters.rb` that:

- Takes in a collection of `candidates`
- Instead of filtering on the candidates, returns them all back but reordered such that:
    - Candidates with the most experience are at the top
    - For Candidates that have the same years of experience, they are further sorted by their number of Github points (highest first)


``` ruby

def ordered_by_qualifications(candidates)

  candidates.sort do |a, b|

    # First sort by years of experience (descending)

    comp = b[:years_of_experience] <=> a[:years_of_experience]

    # If years of experience are the same, sort by Github points (descending)

    if comp == 0

      b[:github_points] <=> a[:github_points]

    else

      comp

    end

  end

end
```

- Compare `b[:years_of_experience]` and `a[:years_of_experience]`:
    - If `b` has more experience than `a`, it returns `1` (b goes before a).
    - If `a` has more experience, it returns `-1` (a goes before b).
    - If they have the same experience, it returns `0`, and the block moves on to compare by GitHub points.
- If years of experience are equal (`comp == 0`), compare `b[:github_points]` and `a[:github_points]`:
    - The same logic applies: compare GitHub points in descending order.