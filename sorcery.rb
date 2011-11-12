@after_bundler << lambda do
  inject_into_file "app/models/user.rb", :before => "\nend" do
<<-RUBY
  \n
  attr_accessible :email, :password, :password_confirmation
  authenticates_with_sorcery!
  validates_length_of :password, :minimum => 3, :message => "password must be at least 3 characters long", :if => :password
  validates_confirmation_of :password, :message => "should match confirmation", :if => :password
RUBY
  end
  
  generate(:controller, "UserSessions new create destroy")
  
  inject_into_file "app/controllers/user_sessions_controller.rb", :after => "\tnew" do  
<<-RUBY
  def new
    @user = User.new
  end
RUBY
  end
  
  inject_into_file 'app/controllers/user_sessions_controller.rb', :after => "\tcreate" do
<<-RUBY
  def create
    respond_to do |format|
      if @user = login(params[:username],params[:password])
        format.html { redirect_back_or_to(:users, :notice => 'Login successfull.') }
        format.xml { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { flash.now[:alert] = "Login failed."; render :action => "new" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
RUBY
  end
  
  inject_into_file 'app/controllers/user_sessions_controller.rb', :after => "\tdestroy" do
<<-RUBY
  def destroy
    logout
    redirect_to(:users, :notice => 'Logged out!')
  end
RUBY
  end
  
  inject_into_file 'app/views/user_sessions/new.html.haml', :before => "\nend" do
    %q[%h1 Login
      = render 'form'
      = link_to 'Back', user_sessions_path]
  end
  
end