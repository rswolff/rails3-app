@after_bundler << lambda do 
  generate(:scaffold, "User first_name:string last_name:string email:string")
  inject_into_class("app/models/user.rb", "User", "\tauthenticates_with_sorcery!\n")
  
end