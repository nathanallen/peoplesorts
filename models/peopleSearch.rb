class PeopleSearch

  def self.sort_by_gender
    groupings = sort_by_last_name.group_by{|person| person.gender }
    [*groupings['Female'],*groupings['Male']]
  end

  def self.sort_by_birth
    all.sort_by{|person| person.standardized_dob}
  end

  def self.sort_by_last_name
    all.sort_by{|person| person.last_name}
  end

  def self.sort_by_last_name_descending
    sort_by_last_name.reverse
  end

end