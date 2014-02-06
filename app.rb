class Main
  attr_reader :people

  def initialize(files)
    @people = build_people(files)
  end

  private

  def build_people(files)
    rows = load_and_parse(files)
    rows.map do |row|
      Person.new(*row)
    end
  end

  def load_and_parse(files)
    files.map do |file|
      DSV.parse(file)
    end.flatten(1)
  end
end

class DSV #delimeter seperated values

  def self.parse(filepath)
    input = read_file(filepath)
    parse_rows_and_values(input)
  end

  def self.regex
    %r{
      \,\s     # comma
      |        # or
      \s\|\s   # pipe
      |        # or else
      \s       # space
    }x
  end

  private

  def self.read_file(filepath)
    File.read(filepath)
  end

  def self.parse_rows_and_values(input)
    rows = input.split(/^/)
    rows.map do |row|
      row.chomp.split(regex)
    end
  end

end

class Person < People_Finder
  attr_accessor :lastName, :firstName, :middleInitial, :gender, :dateOfBirth, :favoriteColor
  
  def initialize(*args)
    @lastName = args[0]
    @firstName = args[1]
    @middleInitial = args[2]
    @gender = args[3]
    @dateOfBirth = args[4]
    @favoriteColor = args[5]
  end

end

delimeters = ['comma','pipe','space']
files = delimeters.map{|delimeter| "sample/#{delimeter}.txt" }

main = Main.new(files)
output = main.people

p output


# # Sanity Checks
# # Regex
# p "Smith | Steve | D | M | Red | 3-3-1985".split(DSV.regex) == ["Smith", "Steve", "D", "M", "Red", "3-3-1985"]
# p "Abercrombie, Neil, Male, Tan, 2/13/1943".split(DSV.regex) == ["Abercrombie", "Neil", "Male", "Tan", "2/13/1943"]
# p "Seles Monica H F 12-2-1973 Black".split(DSV.regex) == ["Seles", "Monica", "H", "F", "12-2-1973", "Black"]

# # Read line
# p File.read('sample/comma.txt').split(/^/)[0] == "Abercrombie, Neil, Male, Tan, 2/13/1943\n"