class People < PeopleSearch

  def initialize(*_)
    add_person
  end

  def self.all
    people
  end

  private

  def self.people
    @people ||= []
  end

  def add_person
    self.class.people << self
  end

end