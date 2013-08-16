inside "app/views/layouts" do
  remove_file "application.html.erb" 
  create_file 'application.html.haml', <<-LAYOUT
!!!
%html
  %head
    %title 

    %meta{:name=>"viewport", :content=>"width=device-width, initial-scale=1.0"}
    %link{:rel => 'stylesheet', :href => '//netdna.bootstrapcdn.com/bootstrap/3.0.0-wip/css/bootstrap.min.css'}
    = stylesheet_link_tag "application"

    %script{:src=>"http://code.jquery.com/jquery-1.10.1.min.js"}
    %srcipt{:src => "//netdna.bootstrapcdn.com/bootstrap/3.0.0-wip/js/bootstrap.min.js"}
    = javascript_include_tag "application"

    = csrf_meta_tag
  %body
    = render :partial => 'shared/nav'

    .container
      - flash.each do |key, value|
        #flash{:class => "alert alert-\#{key}"}
          =link_to "x", nil, :class => 'close'
          %p
            =value
    
      = yield
LAYOUT
end
