module RailsAdminGlyphTheme
  require 'rails'

  class Railtie < ::Rails::Railtie
    initializer "Assets precompile hook", :group => :all do |app|
      app.config.assets.precompile += ['rails_admin_glyph_theme/theme.js']
    end
  end
end
