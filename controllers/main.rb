class Main

  def initialize(files)
    build_people(files)
  end

  def output_recordsets(*sorts_array)
    ViewController.render_multiple(sorts_array)
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