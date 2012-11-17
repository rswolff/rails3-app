@after_bundler << lambda do

  say "Rails generate sorcery:install"
  generate('sorcery:install')  #install only base sorcery  
  say "Migrating database to include sorcery"
  rake('db:migrate')

  say "Add sorcery to user.rb"

  insert_into_file "app/models/user.rb", :before => "\nend" do
<<-RUBY
  \n
  attr_accessible :email, :password, :password_confirmation
  authenticates_with_sorcery!
  validates_length_of :password, :minimum => 3, :message => "password must be at least 3 characters long", :if => :password
  validates_confirmation_of :password, :message => "should match confirmation", :if => :password
RUBY
  end

  say "Generate UserSessions controller"
  generate(:controller, "UserSessions new create destroy")

  #TODO: These insert_into_file methods are not being called.

  insert_into_file "app/controllers/user_sessions_controller.rb", :after => "def new\n" do 
    <<-RUBY
    @user = User.new
    RUBY
  end 

  insert_into_file 'app/controllers/user_sessions_controller.rb', :after => "def create\n" do
<<-RUBY
    respond_to do |format|
      if @user = login(params[:username],params[:password])
        format.html { redirect_back_or_to(:users, :notice => 'Login successfull.') }
        format.xml { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { flash.now[:alert] = "Login failed."; render :action => "new" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
RUBY
  end
  
  insert_into_file 'app/controllers/user_sessions_controller.rb', :after => "def destroy\n" do
<<-RUBY
    logout
    redirect_to(:users, :notice => 'Logged out!')
RUBY
  end
  
  insert_into_file 'app/views/user_sessions/new.html.haml', :before => "\nend" do
    %q[%h1 Login
      = render 'form'
      = link_to 'Back', user_sessions_path]
  end 

end