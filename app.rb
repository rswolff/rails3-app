require 'json'

def commit_state(comment)
  git :add => "."
  git :commit => "-am '#{comment}'"
end

def create_github_repo_and_push
  github_username = run 'git config --get github.user'
  github_token = run 'git config --get github.token'

  response = run "curl -F 'login=#{github_username.chomp}' -F 'token=#{github_token.chomp}' -F 'name=#{app_name}' -F 'public=1' http://github.com/api/v2/json/repos/create"
  
  json_response = JSON.parse(response)
  
  run "git remote add origin git@github.com:#{json_response["repository"]["owner"]}/#{app_name}.git"
  run 'git push origin master'  
end

#remove crufty files
remove_file "README"
remove_file "public/index.html"

#gmefile
gemfile = <<-GEMFILE
  source 'http://rubygems.org'

  gem 'rails', '3.0.0.beta4'

  # Bundle edge Rails instead:
  # gem 'rails', :git => 'git://github.com/rails/rails.git'

  gem "haml", ">= 3.0.18"
  gem "compass"
  gem "capistrano"
  gem "mysql"

  # Use unicorn as the web server
  # gem 'unicorn'

  # To use debugger
  # gem 'ruby-debug'

  # Bundle the extra gems:
  # gem 'bj'
  # gem 'nokogiri', '1.4.1'
  # gem 'sqlite3-ruby', :require => 'sqlite3'
  # gem 'aws-s3', :require => 'aws/s3'

  # Bundle gems for certain environments:
  # gem 'rspec', :group => :test
  # group :test do
  #   gem 'webrat'
  # end
  
GEMFILE

remove_file "Gemfile"
create_file "Gemfile", gemfile

route("root :to => 'pages\#home'")
generate(:controller, "pages home")

#css
empty_directory "app/stylesheets/"
empty_directory "public/stylesheets/blueprint"

inside("public/stylesheets/blueprint") do 
  get "http://github.com/joshuaclayton/blueprint-css/raw/master/blueprint/screen.css"
  get "http://github.com/joshuaclayton/blueprint-css/raw/master/blueprint/print.css"
  get "http://github.com/joshuaclayton/blueprint-css/raw/master/blueprint/ie.css"
end

sass_options = <<-SASS_OPTIONS
  Sass::Plugin.options[:style] = :compact
  Sass::Plugin.options[:template_location] = 'app/stylesheets'
SASS_OPTIONS

application sass_options

jquery = <<-JQUERY
  config.action_view.javascript_expansions[:defaults] = ['jquery.min.js', 'rails.js']
JQUERY

application jquery

#generators
inside("lib/generators") do
  git :clone => "--depth 0 http://github.com/psynix/rails3_haml_scaffold_generator.git haml"
end

remove_dir "lib/generators/haml/.git"

generators = <<-GENERATORS
  config.generators do |g|
    g.template_engine :haml
  end
GENERATORS

application generators

#initializers
date_time_formats = <<-DATE_TIME_FORMATS
Date::DATE_FORMATS.merge!(
  :short => "%Y/%m/%d",
  :med => "%d-%b-%Y",
  :long => "%A %B %d, %Y",
  :military => "%H%M"  
)

Time::DATE_FORMATS.merge!(
  :military => "%H%M",
  :short => "%I:%M %p"  
)
DATE_TIME_FORMATS

initializer "custom_date_formats.rb", date_time_formats

#javascripts
inside "public/javascripts/" do
  get "http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"
  get "http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.1/jquery-ui.min.js"
  get "http://github.com/rails/jquery-ujs/raw/master/src/rails.js"
end

#css

base = <<-BASE
/* base styles go here */
ul#nav {
	padding-left: 0px
}
ul#nav li {
  display: inline;
  list-style-type: none;
  padding-right: 20px;
}
BASE

app = <<-APP
/* appy styles go here */
APP

inside "app/stylesheets" do
  create_file "base.scss", base 
  create_file "app.scss", app
end

initializer "jquery.rb", jquery

layout = <<-LAYOUT
!!!
%html
  %head
    %title Testapp
    = stylesheet_link_tag 'blueprint/screen.css', :media => 'screen, projection'
    = stylesheet_link_tag 'blueprint/print.css', :media => 'print'
    /[if lt IE 8]
      = stylesheet_link_tag 'blueprint/ie.css', :media => 'screen, projection'
    = stylesheet_link_tag 'base'
    = stylesheet_link_tag 'app'
    = javascript_include_tag :defaults
    = csrf_meta_tag
  %body
  .container
    = render :partial => 'shared/nav'
    = yield
LAYOUT

#file and directory housekeeping

#basic navlist
nav = <<-NAV
%ul#nav
  %li= link_to "home", root_path
NAV

empty_directory "app/views/shared"
inside "app/views/shared" do
  create_file "_nav.html.haml", nav
end

remove_file "app/views/layouts/application.html.erb"
create_file "app/views/layouts/application.html.haml", layout

remove_file "public/index.html"

#create readme
readme = <<-README
This RAILS3 applicaiton template was created by Scott Wolff (@rswolff), and can be forked on github at http://github.com/rswolff/rails3-app.
README

create_file "log/.gitkeep"
create_file "tmp/.gitkeep"

capify!

remove_file ".gitignore"

file '.gitignore', <<-END
.bundle
config/database.yml
config/deploy.rb
log/*.log
tmp/**/*
.DS\_Store
.DS_Store
/log/*.pid
public/system/*
app/stylesheets/*
.sass-cache/*
END

git :init
commit_state("initial commit")

create_github_repo_and_push if yes?("Create GitHub repository?") 
  
docs = <<-DOCS

Run the following commands to complete the setup of #{app_name.humanize}:

% cd #{app_name}
% sudo gem install bundler
% sudo bundle install

DOCS

log docs
