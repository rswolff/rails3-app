# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mysql2'
gem 'json'
gem 'capistrano'
gem 'sorcery'
gem 'cancan'
gem 'haml'
gem 'kaminari'
gem 'prawn'
gem 'state_machine'
gem 'whenever'
gem 'money-rails'

gem_group :development do
	gem 'pry'
	gem 'meta_request', '0.2.1'	
end

gem_group :production do
  gem 'execjs'
  gem 'therubyracer'
end
