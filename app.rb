REGEX = %r{
  \,\s     # comma
  |        # or
  \s\|\s   # pipe
  |        # or else
  \s       # space
}x

delimeters = ['comma','pipe','space']

def read_file(filename)
  File.read(filename)
end

def parse_rows_and_values(input)
  rows = input.split(/^/)
  rows.map do |row|
    row.chomp.split(REGEX)
  end
end

def go(delimeters)
  delimeters.map do |delimiter|
    filename = "sample/#{delimiter}.txt"
    input = read_file(filename)
    parse_rows_and_values(input)
  end.flatten(1)
end

p go(delimeters)
#p delimeters

## Sanity Checks
## Regex
# p "Smith | Steve | D | M | Red | 3-3-1985".split(REGEX) == ["Smith", "Steve", "D", "M", "Red", "3-3-1985"]
# p "Abercrombie, Neil, Male, Tan, 2/13/1943".split(REGEX) == ["Abercrombie", "Neil", "Male", "Tan", "2/13/1943"]
# p "Seles Monica H F 12-2-1973 Black".split(REGEX) == ["Seles", "Monica", "H", "F", "12-2-1973", "Black"]

## Read line
# p File.read('sample/comma.txt').split(/^/)[0] == "Abercrombie, Neil, Male, Tan, 2/13/1943\n"