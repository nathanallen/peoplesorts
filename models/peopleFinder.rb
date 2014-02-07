class PeopleFinder

  def initialize(*_)
    add_person
  end

  def self.all
    people
  end

  def self.sort_by_last_name
    all.sort_by{|person| person.last_name}
  end

  def self.sort_by_last_name_descending
    sort_by_last_name.reverse
  end

  def self.sort_by_birth
    all.sort_by{|person| person.date_of_birth("%Y/%m/%d")}
  end

  def self.sort_by_gender
    groupings = sort_by_last_name.group_by{|person| person.gender }
    [*groupings['Female'],*groupings['Male']]
  end


  private

  def self.people
    @people ||= []
  end

  def add_person
    self.class.people << self
  end

end