@after_bundler << lambda do
	generate('money_rails:initializer')
end