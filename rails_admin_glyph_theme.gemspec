$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_admin_glyph_theme/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_admin_glyph_theme"
  s.version     = RailsAdminGlyphTheme::VERSION
  s.authors     = ["Xana68"]
  s.email       = ["alex@glyph.fr"]
  s.homepage    = "http://www.glyph.fr"
  s.summary     = "RailsAdminGlyphTheme."
  s.description = "Flat design for Rails_admin."

  s.files = Dir["{lib,vendor}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.12"
  # s.add_dependency "jquery-rails"
end
