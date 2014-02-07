class Main

  def initialize(files)
    build_people(files)
  end

  def display_recordsets(output=[])
    output << ViewController.render("Output 1", Person.by_gender)
    output << ViewController.render("Output 2", Person.by_birth)
    output << ViewController.render("Output 3", Person.by_last_name_descending)
    output.flatten.join('')
  end

  private

  def build_people(files)
    rows = load_and_parse(files)
    formatted_rows = reformat(rows)
    formatted_rows.map do |row|
      Person.new(*row)
    end
  end

  def load_and_parse(files)
    files.map do |file|
      DSV.parse(file)
    end.flatten(1)
  end

  def reformat(rows)
    mmddyyyy = /(?<mm>\d{1,2}) (\-|\/) (?<dd>\d{1,2}) (\-|\/) (?<yyyy>\d{4})/x
    rows.map do |row|
      row[-1] =~ mmddyyyy ? row << row.slice!(-2) : row
    end
  end
end

class ViewController
  def self.render(*args)
    rendered_records = build_records(*args).join('')
    print rendered_records
    return rendered_records
  end

  private

  def self.build_records(title,objects,output=[])
    output << title + ":\r\n"
    output << objects.map do |obj|
                obj.inspect + "\r\n"
              end
    output << "\r\n"
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

  def self.by_gender
    groupings = by_last_name.group_by{|person| person.gender }
    [*groupings['Female'],*groupings['Male']]
  end

  def self.by_birth
    all.sort_by{|person| person.standardized_dob}
  end

  def self.by_last_name
    all.sort_by{|person| person.last_name}
  end

  def self.by_last_name_descending
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

  private

  def add_person
    @@people << self
  end

end

class Person < People
  attr_reader :last_name, :first_name, :middle_initial, :gender, :date_of_birth, :favorite_color, :standardized_dob
  require 'date'

  def initialize(last_name, first_name, *middle, gender, date_of_birth, favorite_color)
    @last_name = last_name
    @first_name = first_name
    @middle_initial = middle[0] || nil
    @gender = gender
    @date_of_birth = date_of_birth
    @favorite_color = favorite_color
    normalize
    super
  end

  def inspect(output=[])
    output << self.last_name
    output << self.first_name
    output << self.gender
    output << self.date_of_birth
    output << self.favorite_color
    output.join(' ')
  end

  private

  def normalize
    gender = @gender
    @gender = "Male" if gender == "M"
    @gender = "Female" if gender == "F"

    @date_of_birth.gsub!('-','/')
    
    @standardized_dob = DateTime.strptime(@date_of_birth, '%m/%d/%Y').strftime('%Y/%m/%d')
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