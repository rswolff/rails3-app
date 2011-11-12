inside "app/views/layouts" do
  remove_file "application.html.erb" 
  create_file 'application.html.haml', <<-LAYOUT
!!!
%html
  %head
    %title 
    = stylesheet_link_tag 'bootstrap.css'
    
    %link{:href=>'http://fonts.googleapis.com/css?family=Open+Sans:400,400italic,700', :rel=>'stylesheet', :type=>'text/css'}
    
    = stylesheet_link_tag    "application"
    = javascript_include_tag "application"
    = csrf_meta_tag
  %body
    = render :partial => 'shared/nav'

    .container
      - flash.each do |key, value|
        #flash{:class => "alert-message \#{key}"}
          =link_to "x", nil, :class => 'close'
          %p
            =value
    
      = yield
  LAYOUT
end
