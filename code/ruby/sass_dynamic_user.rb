require 'sass'

module Sass::Script::Functions
  def get_custom_palettes
    value = Sass::Script::Value
    color = value::Color.from_hex(options[:custom][:color])

    palettes = 3.times.map do |n|
      factor = value::Number.new((n + 1) * 10, '%')

      value::Map.new({
        value::String.new('bg') => lighten(color, factor),
        value::String.new('text') => darken(color, factor)
      })
    end

    value::List.new(palettes, :space)
  end
end
