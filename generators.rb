inside("lib/generators") do
  git :clone => "--depth 0 https://github.com/rswolff/haml-rails.git"
end

remove_dir "lib/generators/haml-rails/.git"

generators = <<-GENERATORS
  config.generators do |g|
    g.template_engine :haml
  end
GENERATORS

application generators