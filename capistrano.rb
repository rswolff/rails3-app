puts "Capify! and create default cap tasks."
capify!

inside "config" do
  remove_file "deploy.rb"
  file 'deploy.rb', <<-END
require 'erb'
require 'bundler/capistrano'
set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"

set :application, "#{app_name}"
set :repository,  "%repository_url%"
set :scm, :git

set :branch, "master"
set :deploy_via, :remote_cache
set :keep_releases, 3
set :user, "deploy"
set :deploy_to, "/home/\#{user}/apps/#{app_name}"

role :web, "web"                          # Your HTTP server, Apache/etc
role :app, "app"                          # This may be the same as your `Web` server
role :db,  "db", :primary => true         # This is where Rails migrations will run

ssh_options[:port] = 30000
set :use_sudo, false
set :ssh_options, { :forward_agent => true }

default_run_options[:pty] = true

set :default_environment, {
  'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
}

before 'deploy:setup', :db
after 'deploy:setup', 'figaro:setup'
before 'deploy:assets:precompile', 'db:symlink'
before 'deploy:finalize_update', 'figaro:finalize'

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

namespace :figaro do
  desc "SCP transfer figaro configuration to the shared folder"
  task :setup do
    transfer :up, "config/application.yml", "\#{shared_path}/application.yml", :via => :scp
  end
 
  desc "Symlink application.yml to the release path"
  task :finalize do
    run "ln -sf \#{shared_path}/application.yml \#{release_path}/config/application.yml"
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