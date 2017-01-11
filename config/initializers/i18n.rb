Rails.application.config.time_zone = 'Tokyo'
Rails.application.config.i18n.load_path += Dir[Rails.root.join('config','locales','**','*.{rb,yml}').to_s]
Rails.application.config.i18n.default_locale = :ja