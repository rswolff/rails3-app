#gemfile
puts "Create Gemfile"
remove_file "Gemfile"
create_file 'Gemfile', <<-GEMFILE

source 'http://rubygems.org'

gem 'rails', '3.1.0'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'mysql2'
gem 'json'
gem 'capistrano'
gem 'devise'
gem 'cancan'
gem 'haml'

gem 'prawn'
gem 'delayed_job'
gem 'state_machine'
gem 'whenever'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# To use debugger
# gem 'ruby-debug'



  
GEMFILE