#Rails generator actions: http://github.com/rails/rails/blob/master/railties/lib/rails/generators/actions.rb
#Thor actions: http://rdoc.info/github/wycats/thor/master/Thor/Actions

require 'json'

root_dir = "~/Rails/rails3-app"
use_rvm = false

@repository_url = nil

def commit_state(comment)
  git :add => "."
  git :commit => "-am '#{comment}'"
end

def init_github_repo_and_push
  github_user = run 'git config --get github.user'
  github_token = run 'git config --get github.token'
  repository = run "curl -F \'login=#{github_user}\' -F \'token=#{github_token}\' -F \'name=#{app_name}\' -F \'public=1\' http://github.com/api/v2/json/repos/create"  
  json_response = JSON["#{repository}"]
   
  @repository_url = "git@github.com:#{json_response["repository"]["owner"]}/#{json_response["repository"]["name"]}.git"
  run "git remote add origin #{@repository_url} && git push origin master"  
end

if yes?("Use rbenv?")
  inside "\#{app_path}" do
    create_file ".rbenv-version", <<-RBENV
    
    RBENV
  end
end

#apply templates
apply "#{root_dir}/gemfile.rb"
apply "#{root_dir}/stylesheets.rb"
apply "#{root_dir}/layouts.rb"
apply "#{root_dir}/generators.rb"
apply "#{root_dir}/capistrano.rb"
apply "#{root_dir}/authentication_authorization.rb"
apply "#{root_dir}/initializers.rb"
apply "#{root_dir}/gitconfig.rb"

puts "Remove README and public/index.html"
remove_file "README"
remove_file "public/index.html"

#create readme
create_file 'readme.md', <<-README
This RAILS3 applicaiton template was created by Scott Wolff (@rswolff), and can be forked on github at http://github.com/rswolff/rails3-app.
README

#file and directory housekeeping
#basic navlist
empty_directory "app/views/shared"
inside "app/views/shared" do
  create_file "_nav.html.haml", <<-NAV
%ul#nav
  %li= link_to "home", root_path
  NAV
end

git :init
commit_state("initial commit")

if yes?("Create GitHub repository?")
  init_github_repo_and_push
  gsub_file 'config/deploy.rb', /%repository_url%/ do |match|
    @repository_url
  end
else
  gsub_file 'config/deploy.rb', /"%repository_url%"/ do |match|
    ''
  end
end

docs = <<-DOCS

Run the following commands to complete the setup of #{app_name.humanize}:

% cd #{app_name}
% rails generate controller pages home
% change default route to pages#home
% rails generate devise:install
% rails generate devise MODEL

DOCS

log docs
