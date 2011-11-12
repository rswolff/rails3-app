#Javascripts
puts "Install Twitter bootstrap .js files"

empty_directory "vendor/assets/javascripts/"

inside("vendor/assets/javascripts/") do 
  get "https://raw.github.com/twitter/bootstrap/master/js/bootstrap-alerts.js", 'bootstrap-alert.js'
  get "https://raw.github.com/twitter/bootstrap/master/js/bootstrap-dropdown.js", 'bootstrap-dropdown.js'
  get "https://raw.github.com/twitter/bootstrap/master/js/bootstrap-modal.js", 'bootstrap-modal.js'
  get "https://raw.github.com/twitter/bootstrap/master/js/bootstrap-popover.js", 'bootstrap-popover.js'
  get "https://raw.github.com/twitter/bootstrap/master/js/bootstrap-scrollspy.js", "bootstrap-scrollspy.js"
  get "https://raw.github.com/twitter/bootstrap/master/js/bootstrap-tabs.js", "bootstrap-tabs.js"
  get "https://raw.github.com/twitter/bootstrap/master/js/bootstrap-twipsy.js", "bootstrap-twipsy.js"    
end
