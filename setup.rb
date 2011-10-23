@after_bundler << lambda do  
  rake("db:create") 
  generate('sorcery:install')  
  rake('db:migrate')
end