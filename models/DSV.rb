class DSV #delimiter seperated values

  def self.open(filepath)
    input = File.read(filepath)
    rows = input.split(/^/)
    rows.map do |row|
      yield(parse(row))
    end
  end

  def self.delimiter_regex
    %r{
      \,\s     # comma
      |        # or
      \s\|\s   # pipe
      |        # or else
      \s       # space
    }x
  end

  private

  def self.parse(row)
    row.chomp.split(delimiter_regex)
  end
end