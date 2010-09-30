puts "Adding .rvmrc"
run "echo \'rvm ruby-1.9.2-p0@#{app_name} --create\' > .rvmrc"
use_rvm = true