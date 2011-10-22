@after_bundler << lambda do
  rake('sorcery:bootstrap')
  generate('sorcery_migration', 'core')  
  rake('db:migrate')
end
