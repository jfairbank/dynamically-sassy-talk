class PalettesController < ApplicationController
  TEMPLATE = <<-SCSS.freeze
    $palettes: get-dynamic-palettes();
    @import 'ui';
  SCSS

  def custom
    @css = Sass::Engine.new(TEMPLATE, {
      syntax: :scss,
      style: :expanded,
      load_paths: [
        Rails.root.join('app/assets/stylesheets')
      ],
      custom: { color: params[:color] }
    }).render
  end
end
