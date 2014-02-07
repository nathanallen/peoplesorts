class Main

  def initialize(files)
    build_people(files)
  end

  def display_recordsets(output=[])
    output << ViewController.render("Output 1", Person.sort_by_gender)
    output << ViewController.render("Output 2", Person.sort_by_birth)
    output << ViewController.render("Output 3", Person.sort_by_last_name_descending)
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