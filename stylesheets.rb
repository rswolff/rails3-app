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
$font-size: 18px;

body {
	background-color: #F6F6F6;
	font-size: $font-size;
}

/* forms */

label {
	font-size: $font-size - 2;
}

input[type=text], input[type=password] {
	font-size: $font-size;
	padding: 4px;
}

input[type=submit] {
	font-size: $font-size;
}

#flash_messages {
	height: $font-size;
	line-height: $font-size;	
	padding: 15px;
}
  APP
end


sass_options = <<-SASS_OPTIONS
  Sass::Plugin.options[:style] = :compact
  Sass::Plugin.options[:template_location] = 'app/stylesheets'
SASS_OPTIONS

application sass_options
