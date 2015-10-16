# Simple usage
Rails.cache.write('sass', 'is awesome')
Rails.cache.fetch('sass') == 'is awesome'

# Using with Sass rendering
@css = Rails.cache.fetch('palettes/steelblue') do
  Sass::Engine.new(...).render
end
