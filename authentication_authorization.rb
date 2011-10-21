#cancan
say "Install CanCan authorization"
@after_bundler << lambda do
  generate("cancan:ability")
end