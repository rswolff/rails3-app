#CSS
root_dir = "~/Rails/rails3-app"

say "Install Twitter bootstrap.css "

empty_directory "vendor/assets/stylesheets/"

append_to_file 'app/assets/stylesheets/application.css' do
  'body {margin-top: 40px;}'
  '#flash {margin-top: 20px;}'
end

#remove scaffold styles, but leave empty scaffold.css file in place.
remove_file 'app/assets/stylesheets/scaffolds.css.scss'
create_file 'app/assets/stylesheets/scaffolds.css.scss'
