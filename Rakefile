require File.dirname(__FILE__) + "/lib/theplaylist"

task :default => :download

task :download do
  print "Please insert Week # "
  week_number = STDIN.gets.chomp!

  Theplaylist.download week_number
end
