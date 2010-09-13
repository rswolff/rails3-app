#javascripts
puts "Install jquery as default JavaScript library"
jquery = <<-JQUERY
  config.action_view.javascript_expansions[:defaults] = ['jquery.min.js', 'rails.js']
JQUERY

application jquery

inside "public/javascripts/" do
  remove_file "rails.js"  
  get "http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"
  get "http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.1/jquery-ui.min.js"
  get "http://github.com/rails/jquery-ujs/raw/master/src/rails.js"
end