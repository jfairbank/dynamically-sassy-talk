class SassCustomPalettes
  def initialize(color)
    @color = color
    @key = generate_client_key(color)
  end

  def render(color)
    css = Sass::Engine.new(
      DEFAULTS.merge(custom: { color: color })
    ).render
    Rails.cache.write(@key, css)
  end

  def render_async(color)
    unless Rails.cache.exist? @key
      SassCustomPalettesWorker.peform_async(color)
    end
    @key
  end
end
