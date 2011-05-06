inside "app/views/layouts" do
  remove_file "application.html.erb" 
  create_file 'application.html.haml', <<-LAYOUT
!!!
%html
  %head
    %title Testapp
    = stylesheet_link_tag 'blueprint/screen.css', :media => 'screen, projection'
    = stylesheet_link_tag 'blueprint/print.css', :media => 'print'
    /[if lt IE 8]
      = stylesheet_link_tag 'blueprint/ie.css', :media => 'screen, projection'
    = stylesheet_link_tag 'app'
    = javascript_include_tag :defaults
    = csrf_meta_tag
  %body
  .container
    = render :partial => 'shared/nav'
    
    - flash.each do |key, value|
      #flash{:class => key}
        =value
    
    = yield
  LAYOUT
end
