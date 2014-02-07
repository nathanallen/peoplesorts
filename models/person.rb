class Person < PeopleDirectory
  require 'date'

  attr_reader :last_name, :first_name, :middle_initial, :gender, :date_of_birth, :favorite_color, :standardized_dob

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