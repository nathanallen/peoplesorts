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
      obj.inspect
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
  attr_reader :last_name, :first_name, :middle_initial, :gender, :date_of_birth, :favorite_color
  
  def initialize(last_name, first_name, *opt, gender, date_of_birth, favorite_color)
    @last_name = last_name
    @first_name = first_name
    @middle_initial = opt[0] || nil
    @gender = standardize_gender(gender)
    @date_of_birth = date_of_birth
    @favorite_color = favorite_color
    super
  end

  def inspect
    output = []
    output << self.last_name
    output << self.first_name
    output << self.middle_initial if self.middle_initial
    output << self.gender
    output << self.date_of_birth
    output << self.favorite_color
    p output.join(' ')
  end

  private

  def standardize_gender(gender)
    return "Male" if gender == "M"
    return "Female" if gender == "F"
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