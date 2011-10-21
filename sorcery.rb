@after_bundler << lambda do
  run 'rake sorcery:bootstrap'
  generate('sorcery_migration', 'core')  
end
