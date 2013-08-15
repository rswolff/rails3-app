say "Remove README and public/index.html"
remove_file "README"
remove_file "public/index.html"

@after_bundler << lambda { generate('controller', 'pages home') }

#routes
route "get 'not_authorized' => 'pages#not_authorized'"
route "root :to => 'pages#home'"

# create not_authorized page

create_file 'app/views/pages/not_authorized.html.haml', <<-README
#not_authorized.alert.alert-error
%h1 Not Authorized
%p You are not authorized to view this page.
README

#create readme
create_file 'readme.md', <<-README
This RAILS3 applicaiton template was created by Scott Wolff (@rswolff), and can be forked on github at http://github.com/rswolff/rails3-app.
README

#file and directory housekeeping
#basic navlist
empty_directory "app/views/shared"
inside "app/views/shared" do
  create_file "_nav.html.haml", <<-NAV
%nav{:class => 'navbar', :role => 'navigation'}
  .navbar-header
    %button{:type => 'button', :class => 'navbar-toggle', :'data-toggle' => 'collapse', :'data-target' => '.navbar-ex1-collapse'}
      %span.sr-only Toggle Navigation
      %span.icon-bar
      %span.icon-bar
      %span.icon-bar
    = link_to 'Website Title', '#', :class => 'navbar-brand'
  .collapse.navbar-collapse.navbar-ex1-collapse
    %ul.nav.navbar-nav
      %li.active= link_to "Home", '#'
      %li=link_to "Menu Item 1", '#'
      %li=link_to "Menu Item 2", '#'




  NAV
end