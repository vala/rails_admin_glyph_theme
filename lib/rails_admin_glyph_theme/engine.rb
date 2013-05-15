module RailsAdminGlyphTheme
  class Engine < ::Rails::Engine
    initializer "Assets precompile hook", :group => :all do |app|
      app.config.assets.precompile += ['rails_admin_glyph_theme/theme.js']
    end
  end
end
