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
  file '_base.scss', <<-BASE
/* base styles go here */
$font-size: 18px;
$default-font-family: helvetica, arial, 'sans serif';

body {
	background-color: #F6F6F6;
	font-size: $font-size;
}

/* forms */

label {
	font-size: $font-size -2;
}

hr {
	margin-bottom: 15px;
}

input[type=text], input[type=password], input[type=file], select, textarea {
	font-size: $font-size;
	padding: 4px;
}

input[type=text].short, input[type=password].short {
	width: 100px;
}

input[type=text].medium, input[type=password].medium {
	width: 250px;
}

input[type=text].long, input[type=password].long {
	width: 450px;
}

input[type=submit] {
	font-size: $font-size;
}

textarea {
	font-family: $default-font-family;
}

/* nav */

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
@import "_base";  
/* appy styles go here */

  APP
end


sass_options = <<-SASS_OPTIONS
  Sass::Plugin.options[:style] = :compact
  Sass::Plugin.options[:template_location] = 'app/stylesheets'
SASS_OPTIONS

application sass_options
