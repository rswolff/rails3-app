puts "Adding .rvmrc"
run "echo \'rvm ruby-1.9.2-head@#{app_name} --create\' > .rvmrc"
use_rvm = true