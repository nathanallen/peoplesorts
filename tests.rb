# Driver Code
delimeters = ['comma','pipe','space']
files = delimeters.map{|delimeter| "sample/#{delimeter}.txt" }
main = Main.new(files)

# Basic Unit Tests
print "Sanity Checks... \n"

print "The fully rendered recordset matches expected output: "
p main.output_recordsets(Person.sort_by_gender, Person.sort_by_birth, Person.sort_by_last_name_descending) == File.read('sample/expected-output.txt')

print "Regex works for all 3 delimiters: "
p "Smith | Steve, D M | Red, 3-3-1985".split(DSV.delimiter_regex) == ["Smith", "Steve", "D", "M", "Red", "3-3-1985"]

print "Lines are read in and split at the correct point: "
p File.read('sample/comma.txt').split(/^/)[0] == "Abercrombie, Neil, Male, Tan, 2/13/1943\n"

print "Gender is reassigned automagically: "
macho = Person.new("", "", "M", "01-03-1988", "")
femme = Person.new("", "", "F", "01-03-1988", "")
p macho.gender == "Male" && femme.gender == "Female"

print "Mr. George Female is still a man! "
george1 = Person.new("Mr", "George", "Female", "Male", "01-03-1988", "green")
george2 = Person.new("George", "Female", "Male", "01-03-1988", "green")
p george1.gender == "Male" && george2.gender == "Male"

print "Birthdates are reformatted: "
anon = Person.new("", "", "", "01-03-1988", "")
p anon.date_of_birth == "1/3/1988"

print "Creating a person adds them to the directory: "
initial_count = Person.all.count
Person.new("Allen", "Nathan", "Male", "11/03/1988", "Green")
final_count = Person.all.count
p final_count == initial_count + 1

print "Sorting by date of birth sorts by year/month/day: "
youngest = Person.new("", "", "", "01-01-1000", "")
oldest = Person.new("", "", "", "9/9/9999", "")
sort_order = Person.sort_by_birth
p sort_order.first == youngest && sort_order.last == oldest

print "Sorting by last name puts Aardvark before Zebra: "
a = Person.new("Aardvark", "", "", "11/03/1988", "")
z = Person.new("Zebra", "", "", "11/03/1988", "")
sort_order = Person.sort_by_last_name
p sort_order.last == z

print "Sorting by last name descending puts Zebra before Aardvark: "
sort_order = Person.sort_by_last_name_descending
p sort_order.first == z

print "Sorting by gender puts gals before guys: "
sort_order = Person.sort_by_gender
p sort_order.first.gender == "Female" && sort_order.last.gender == "Male"

print "Fields are displayed in the correct order: "
steve = Person.new("Smith", "Steve", "D", "M", "3-3-1985", "Red")
neil = Person.new("Abercrombie", "Neil", "Male", "2/13/1943", "Tan")
p steve.inspect == "Smith Steve Male 3/3/1985 Red" && neil.inspect == "Abercrombie Neil Male 2/13/1943 Tan"
