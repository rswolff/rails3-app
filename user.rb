#create user scaffold
say "Generate user scaffold: rails generate scaffold user ..."
generate(:scaffold, "User first_name:string last_name:string email:string crypted_password:string salt:string")