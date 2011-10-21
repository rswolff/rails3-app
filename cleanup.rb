puts "Remove README and public/index.html"
remove_file "README"
remove_file "public/index.html"

@after_bundler << lambda { generate('controller', 'pages home') }

route "root :to => 'pages#home'"

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