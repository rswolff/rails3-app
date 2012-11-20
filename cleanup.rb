say "Remove README and public/index.html"
remove_file "README"
remove_file "public/index.html"

@after_bundler << lambda { generate('controller', 'pages home') }

#routes
route "match 'login' => 'user_sessions#new', :as => :login"
route "match 'logout' => 'user_sessions#destroy', :as => :logout"
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
.navbar.navbar-fixed-top
  .navbar-inner
    .container
      =link_to "#{app_name}", root_path, {:class => 'brand'}
      .nav-collapse
        %ul.nav
          %li= link_to "nav_item", nil
          %li= link_to "nav_item", nil

  NAV
end