#CSS
puts "Install Twitter bootstrap.css "

empty_directory "vendor/assets/stylesheets/"

inside("vendor/assets/stylesheets/") do 
  get "https://raw.github.com/twitter/bootstrap/master/bootstrap.css", 'bootstrap.css'
end

append_to_file 'app/assets/stylesheets/application.css' do
  'body {margin-top: 40px;}'
  '#flash {margin-top: 20px;}'
end
