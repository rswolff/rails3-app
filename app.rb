#Rails generator actions: https://github.com/rails/rails/blob/master/railties/lib/rails/generators/actions.rb
#Thor actions: http://rdoc.info/github/wycats/thor/master/Thor/Actions


#TODO: add signin page, add signin css

require 'json'

root_dir = "~/Rails/rails3-app"

@repository_url = nil
@after_bundler = []

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

inside "app" do
  create_file ".rbenv-version", <<-RBENV
  
  RBENV
end

#apply templates
apply "#{root_dir}/gemfile.rb"
apply "#{root_dir}/layouts.rb"
apply "#{root_dir}/generators.rb"
apply "#{root_dir}/capistrano.rb"
apply "#{root_dir}/initializers.rb"
apply "#{root_dir}/gitconfig.rb"
apply "#{root_dir}/stylesheets.rb"
apply "#{root_dir}/javascripts.rb"

rake("db:create") 

# apply "#{root_dir}/user.rb" # calls generate scaffold user
apply "#{root_dir}/sorcery.rb" # create sorcery controller
apply "#{root_dir}/cancan.rb" #after bundler
apply "#{root_dir}/cleanup.rb" #remove readme, setup root route, create default navigation

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

say "running bundle install"
run 'bundle install'

say "running after bundler tasks"
@after_bundler.each do |task|
  task.call
end

git :init
commit_state("initial commit")

say "Complete!"
say "Remember to add Twitter Bootsrap and procompile assests in production to the asset pipeline."
