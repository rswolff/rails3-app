create_file "log/.gitkeep"
create_file "tmp/.gitkeep"

remove_file ".gitignore"

file '.gitignore', <<-END
.bundle
config/database.yml
config/deploy.rb
log/*.log
tmp/**/*
.DS\_Store
.DS_Store
/log/*.pid
public/system/*
app/stylesheets/*
.sass-cache/*
END
