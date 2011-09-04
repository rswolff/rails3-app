inside "app/views/layouts" do
  remove_file "application.html.erb" 
  create_file 'application.html.haml', <<-LAYOUT
!!!
%html
  %head
    %title 
    = stylesheet_link_tag 'blueprint/screen.css', :media => 'screen, projection'
    = stylesheet_link_tag 'blueprint/print.css', :media => 'print'
    /[if lt IE 8]
      = stylesheet_link_tag 'blueprint/ie.css', :media => 'screen, projection'
    
    %link{:href=>'http://fonts.googleapis.com/css?family=Open+Sans:400,400italic,700', :rel=>'stylesheet', :type=>'text/css'}
    
    = stylesheet_link_tag    "application"
    = javascript_include_tag "application"
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
