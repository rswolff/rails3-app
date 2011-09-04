#CSS
puts "Download blueprint.css and create custom app stylesheets."

empty_directory "vendor/assets/stylesheets/blueprint"

inside("vendor/assets/stylesheets/blueprint") do 
  get "https://github.com/joshuaclayton/blueprint-css/raw/master/blueprint/screen.css", "screen.css"
  get "https://github.com/joshuaclayton/blueprint-css/raw/master/blueprint/print.css", "print.css"
  get "https://github.com/joshuaclayton/blueprint-css/raw/master/blueprint/ie.css", "ie.css"
end

inside "app/assets/stylesheets" do
  file 'base.scss', <<-BASE
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

input[type=text], input[type=number], input[type=password], input[type=file], select, textarea {
	font-size: $font-size;
	padding: 4px;
}

input[type=text].short, input[type=number].short, input[type=password].short {
	width: 100px;
}

input[type=text].medium, input[type=number].medium, input[type=password].medium {
	width: 250px;
}

input[type=text].long, input[type=number].long, input[type=password].long {
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

.button {
	text-decoration: none;
	font-size: $font-size - 2px;
}

/* fancy button styles thanks to: http://naioo.com/blog/css3-buttons-without-any-images/ */
button, .button {
	-moz-border-radius:5px;
	-webkit-border-radius:5px;
	-moz-box-shadow:0px 0px 2px rgba(0,0,0,0.4);
	-webkit-box-shadow:0px 0px 2px rgba(0,0,0,0.4);

	color:rgba(0,0,0,0.9);
	text-shadow:1px 1px 0px rgba(255,255,255,0.8);
	border:1px solid rgba(0,0,0,0.5);
	
	background:-webkit-gradient(linear,0% 0%,0% 100%,from(rgba(255,255,255,1)),to(rgba(185,185,185,1)));
	background:-moz-linear-gradient(top,rgba(255,255,255,1),rgba(185,185,185,1));

	padding:5px 5px 5px 5px;
}

button:hover, .button:hover {
	background:rgba(240,240,240,1);
}

button:active, button:focus, .button:active, .button:focus {
	background:-webkit-gradient(linear,0% 100%,0% 0%,from(rgba(255,255,255,1)),to(rgba(185,185,185,1)));
	background:-moz-linear-gradient(bottom,rgba(255,255,255,1),rgba(185,185,185,1));
}

button:disabled {
	color:rgba(0,0,0,0.4);
	text-shadow:1px 1px 0px rgba(255,255,255,0.5);
	background:rgba(220,220,220,1);
}

  BASE
end
