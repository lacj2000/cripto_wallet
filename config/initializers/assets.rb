# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
# Undefault usage for multiples files in path
# Rails.application.config.assets.paths += Dir["#{Rails.root}/vendor/assets/javascript/*"].sort_by { |dir| -dir.size }
Rails.application.config.assets.precompile += %w( jquery-3.6.3.js notify.js )
Rails.application.config.assets.precompile += %w(bootstrap.min.js popper.js)
