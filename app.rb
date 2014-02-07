require './controllers/main'
require './controllers/viewController'
require './models/DSV'
require './models/peopleFinder'
require './models/person'

# Driver Code
delimeters = ['comma','pipe','space']
files = delimeters.map{|delimeter| "sample/#{delimeter}.txt" }
main = Main.new(files)
main.display_recordsets

# # Sanity Checks

# # Regex works for all delimeters:
# p "Smith | Steve | D | M | Red | 3-3-1985".split(DSV.regex) == ["Smith", "Steve", "D", "M", "Red", "3-3-1985"]
# p "Abercrombie, Neil, Male, Tan, 2/13/1943".split(DSV.regex) == ["Abercrombie", "Neil", "Male", "Tan", "2/13/1943"]
# p "Seles Monica H F 12-2-1973 Black".split(DSV.regex) == ["Seles", "Monica", "H", "F", "12-2-1973", "Black"]

# # Lines are read in and split at the correct point:
# p File.read('sample/comma.txt').split(/^/)[0] == "Abercrombie, Neil, Male, Tan, 2/13/1943\n"

# # Inspected persons match expected output:
# steve = Person.new("Smith", "Steve", "D", "M", "3-3-1985", "Red")
# p steve.inspect == "Smith Steve Male 3/3/1985 Red"

# neil = Person.new("Abercrombie", "Neil", "Male", "2/13/1943", "Tan")
# p neil.inspect == "Abercrombie Neil Male 2/13/1943 Tan"

# # Rendered recordsets match expected output:
# p main.display_recordsets == File.read('sample/expected-output.txt')