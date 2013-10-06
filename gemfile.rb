gem 'devise'
gem 'capistrano'
gem 'cancan'
gem 'haml-rails', :git => "git://github.com/rswolff/haml-rails.git"
gem 'kaminari'
gem 'prawn'
gem 'state_machine'
gem 'whenever'
gem 'money-rails'
gem 'chronic'
gem 'figaro'

gem_group :development do
	gem 'pry'
	gem 'meta_request', '0.2.1'	
end

gem_group :production do
  gem 'execjs'
  gem 'therubyracer'
end
