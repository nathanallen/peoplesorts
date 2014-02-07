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