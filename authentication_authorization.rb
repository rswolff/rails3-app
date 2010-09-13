#devise
puts "Install Devise"
run 'rails generate devise:install'
run 'rails generate devise User'

#cancan
puts "Install CanCan and create Ability.rb"
inside "app/models" do
  create_file 'ability.rb', <<-ABILITY
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new #guest user
  end
end
  ABILITY
end