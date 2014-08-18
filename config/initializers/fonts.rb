Rails.configuration.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')
Rails.configuration.assets.precompile << /\.(?:svg|eot|woff|ttf)$/
