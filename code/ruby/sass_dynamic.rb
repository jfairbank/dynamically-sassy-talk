require 'sass'

# config/initializers/sass.rb
module Sass::Script::Functions
  # Generate palettes of random hex values
  def get_dynamic_palettes
    palettes = 3.times.map do
      Sass::Script::Value::Map.new({
        Sass::Script::Value::String.new('bg') => random_hex,
        Sass::Script::Value::String.new('text') => random_hex
      })
    end

    Sass::Script::Value::List.new(palettes, :space)
  end

  private def random_hex
    Sass::Script::Value::Color.from_hex(
      '#%06x' % (rand * 0xffffff)
    )
  end
end
