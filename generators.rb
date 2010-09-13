inside("lib/generators") do
  git :clone => "--depth 0 http://github.com/psynix/rails3_haml_scaffold_generator.git haml"
end

remove_dir "lib/generators/haml/.git"

generators = <<-GENERATORS
  config.generators do |g|
    g.template_engine :haml
  end
GENERATORS

application generators