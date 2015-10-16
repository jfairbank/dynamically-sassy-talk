# app/workers/sass_custom_palettes_worker.rb
class SassCustomPalettesWorker
  include Sidekiq::Worker

  def perform(color)
    SassCustomPalettes.new(color).render
  end
end
