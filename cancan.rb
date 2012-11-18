#cancan
@after_bundler << lambda do
	say "Install CanCan authorization"  
  generate("cancan:ability")

  insert_into_file "app/controllers/application_controller.rb", :after => "protect_from_forgery\n" do
<<-RUBY 
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to not_authorized_path
  end
  
  protected
  def not_authenticated
    redirect_to new_user_session_path, :alert => "Please login first."
  end
RUBY
  end
end