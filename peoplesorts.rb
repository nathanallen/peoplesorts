require './controllers/main'
require './controllers/viewController'
require './models/DSV'
require './models/peopleFinder'
require './models/person'

if ARGV.first == "tests"
  require './tests.rb'
else
  
  # Driver Code
  delimeters = ['comma','pipe','space']
  files = ARGV.empty? ? delimeters.map{|delimeter| "sample/#{delimeter}.txt" } : ARGV
  main = Main.new(files)
  print main.output_recordsets(Person.sort_by_gender, Person.sort_by_birth, Person.sort_by_last_name_descending)
  
  # Prompt
  print "-----\n"
  print "Run the tests: ruby peoplesorts.rb tests\n"

end