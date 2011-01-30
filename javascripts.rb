#javascripts
puts "Install jquery as default JavaScript library"
jquery = <<-JQUERY
  config.action_view.javascript_expansions[:defaults] = ['jquery.min.js', 'rails.js']
JQUERY

application jquery

inside "public/javascripts/" do
  remove_file "rails.js"  
  get "https://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js"
  get "https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.6/jquery-ui.min.js"
  get "https://github.com/rails/jquery-ujs/raw/master/src/rails.js"
end