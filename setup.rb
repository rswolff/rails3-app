@after_bundler << lambda do
  
  rake("db:create") 
  generate(:scaffold, "User first_name:string last_name:string email:string --migration=false")
  inject_into_class("app/models/user.rb", "User", "\tauthenticates_with_sorcery!\n")
  rake("db:migrate")
  
end