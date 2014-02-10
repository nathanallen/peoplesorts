class Main

  def initialize(files)
    build_people(files)
  end

  def output_recordsets(*sorts_array)
    ViewController.render_multiple(sorts_array)
  end

  private

  def build_people(files)
    mmddyyyy = /\d{1,2} (\-|\/) \d{1,2} (\-|\/) \d{4}/x
    
    files.map do |file|
      DSV.open(file) do |row|
        row[-1] =~ mmddyyyy ? row << row.slice!(-2) : row
        Person.new(*row)
      end
    end

  end
  
end