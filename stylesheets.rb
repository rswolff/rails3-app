#CSS
say "Install Twitter bootstrap.css "

empty_directory "vendor/assets/stylesheets/"

append_to_file 'app/assets/stylesheets/application.css' do
  'body {margin-top: 40px;}'
  '#flash {margin-top: 20px;}'
end

#remove scaffold styles, but leave empty scaffold.css file in place.
remove_file 'app/assets/stylesheets/scaffold.css'
create_file 'app/assets/stylesheets/scaffold.css'
