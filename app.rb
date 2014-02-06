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

class ViewController
  def self.render(title,objects)
    p title
    objects.each do |obj|
      p "#{obj.last_name} #{obj.first_name} #{obj.middle_initial} #{obj.gender} #{obj.date_of_birth} #{obj.favorite_color}"
    end
    p ""
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

class PeopleSearch

  def self.by_gender #(females before males) then by last name ascending (a-z).
    by_last_name.sort_by{|person| person.gender}
  end

  def self.by_birth # - Output 2 – sorted by birth date, ascending (lo-hi).
    all.sort_by{|person| person.date_of_birth}
  end

  def self.by_last_name
    all.sort_by{|person| person.last_name}
  end

  def self.by_last_name_descending # by last name, descending z-a.
    by_last_name.reverse
  end

end

class People < PeopleSearch

  @@people = []

  def initialize(*_)
    add_person
  end

  def self.all
    @@people
  end

  # def people
  #   @people ||= []
  # end

  private

  def add_person
    @@people << self
  end

end

class Person < People
  attr_accessor :last_name, :first_name, :middle_initial, :gender, :date_of_birth, :favorite_color
  
  def initialize(*args)
    @last_name = args[0]
    @first_name = args[1]
    @middle_initial = args[2]
    @gender = standardize_gender(args[3])
    @date_of_birth = args[4]
    @favorite_color = args[5]
    super
  end

  private

  def standardize_gender(gender)
    return "Male" if gender == "M"
    return "FEMALE" if gender == "F"
    return gender
  end

end

delimeters = ['comma','pipe','space']
files = delimeters.map{|delimeter| "sample/#{delimeter}.txt" }

main = Main.new(files)

ViewController.render("Output 1", People.by_gender)
ViewController.render("Output 2", People.by_birth)
ViewController.render("Output 3", People.by_last_name_descending)


# # Sanity Checks
# # Regex
# p "Smith | Steve | D | M | Red | 3-3-1985".split(DSV.regex) == ["Smith", "Steve", "D", "M", "Red", "3-3-1985"]
# p "Abercrombie, Neil, Male, Tan, 2/13/1943".split(DSV.regex) == ["Abercrombie", "Neil", "Male", "Tan", "2/13/1943"]
# p "Seles Monica H F 12-2-1973 Black".split(DSV.regex) == ["Seles", "Monica", "H", "F", "12-2-1973", "Black"]

# # Read line
# p File.read('sample/comma.txt').split(/^/)[0] == "Abercrombie, Neil, Male, Tan, 2/13/1943\n"