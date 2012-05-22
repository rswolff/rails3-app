@after_bundler << lambda do    
  generate('sorcery:install')
  generate('sorcery:install remember_me reset_password')  
  rake('db:migrate')
end