#CSS
puts "Download blueprint.css and create custom app stylesheets."

empty_directory "app/stylesheets/"
empty_directory "public/stylesheets/blueprint"

inside("public/stylesheets/blueprint") do 
  get "http://github.com/joshuaclayton/blueprint-css/raw/master/blueprint/screen.css"
  get "http://github.com/joshuaclayton/blueprint-css/raw/master/blueprint/print.css"
  get "http://github.com/joshuaclayton/blueprint-css/raw/master/blueprint/ie.css"
end

inside "app/stylesheets" do
  file 'base.scss', <<-BASE
/* base styles go here */
ul#nav {
	padding-left: 0px
}
ul#nav li {
  display: inline;
  list-style-type: none;
  padding-right: 20px;
}
  BASE
  
  file 'app.scss', <<-APP
/* appy styles go here */
  APP
end


sass_options = <<-SASS_OPTIONS
  Sass::Plugin.options[:style] = :compact
  Sass::Plugin.options[:template_location] = 'app/stylesheets'
SASS_OPTIONS

application sass_options
