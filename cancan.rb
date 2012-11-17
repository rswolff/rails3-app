#cancan
@after_bundler << lambda do
	say "Install CanCan authorization"  
  generate("cancan:ability")
end