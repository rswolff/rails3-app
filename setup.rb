@after_bundler << lambda do  
  rake("db:create") 
  generate('sorcery:install')
  generate('sorcery:install remember_me reset_password')  
  rake('db:migrate')
end