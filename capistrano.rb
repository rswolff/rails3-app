puts "Capify! and create default cap tasks."
capify!

inside "config" do
  remove_file "deploy.rb"
  file 'deploy.rb', <<-END
require 'erb'

set :application, "#{app_name}"
set :repository,  "%repository_url%"
set :scm, :git

set :branch, "master"
set :deploy_via, :remote_cache
set :scm_verbose, true
set :keep_releases, 3
set :user, "deploy"

role :web, "web"                          # Your HTTP server, Apache/etc
role :app, "app"                          # This may be the same as your `Web` server
role :db,  "db", :primary => true         # This is where Rails migrations will run
role :db,  "db"

ssh_options[:port] = 30000
set :use_sudo, false

before "deploy:setup", :db
after "deploy:update_code", "db:symlink"

namespace :db do
  desc "Create database yaml in shared path"
  task :default do
    db_config = ERB.new <<-EOF
production:
  username: 
  password: 
  adapter: mysql2
  encoding: utf8
  database: #{app_name}_production
EOF

    run "mkdir -p \#{shared_path}/config"
    put db_config.result, "\#{shared_path}/config/database.yml"
  end

  desc "Make symlink for database yaml"
  task :symlink do
    run "ln -nfs \#{shared_path}/config/database.yml \#{release_path}/config/database.yml"
  end
end

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "\#{try_sudo} touch \#{File.join(current_path,'tmp','restart.txt')}"
  end
end
  END
end