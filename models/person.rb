class Person < PeopleFinder
  require 'date'

  attr_reader :last_name, :first_name, :middle_initial, :gender, :favorite_color, :standardized_dob

  def initialize(last_name, first_name, *middle, gender, date_of_birth, favorite_color)
    @last_name = last_name
    @first_name = first_name
    @middle_initial = middle[0] || nil
    @gender = normalize_gender(gender)
    @date_of_birth = normalize_dob(date_of_birth)
    @favorite_color = favorite_color
    super
  end

  def date_of_birth(date_format="%-m/%-d/%Y")
    @date_of_birth.strftime(date_format)
  end

  def inspect
    output = []
    output << self.last_name
    output << self.first_name
    output << self.gender
    output << self.date_of_birth
    output << self.favorite_color
    output.join(' ')
  end

  private

  def normalize_gender(gender)
    return "Male" if gender == "M"
    return "Female" if gender == "F"
    return gender
  end

  def normalize_dob(date_of_birth)\
    DateTime.strptime(date_of_birth.gsub('-','/'), '%m/%d/%Y')
  end

end