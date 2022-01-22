#Rl.init_window(900, 506, 'Da Game')
puts 'before window'
Rl.init_window(900, 675, 'Da Game')

puts 'before require'
require './src/components/player.rb'
require './src/systems/systems.rb'
puts 'after require'

#WHITE = Rl::Color.new(255,255,255,255)
#BLACK = Rl::Color.new(0,0,0,255)
#Lautrec = Rl::Texture.new('./assets/lancelot_.png')
#Lautrec_Source = Rl::Rectangle.new(0,0,24,24)
#Position = Rl::Rectangle.new(0,0,48,48)
#Origin = Rl::Vector2.new(0,0)

#Rl.init_audio_device if Rl.platform == 'web'

Rl.while_window_open do

  Rl.draw(clear_color: WHITE) do
    #Rl.draw_texture_pro(texture: Lautrec, origin: Origin, source: Lautrec_Source, dest: Position)
    #draw_texture_pro(texture:, source:, dest:, origin: Rl::Vector.new(0,0), rotation: 0, tint: Rl::Color.new(255,255,255,255))
    puts 'start stage'
    FECS::Stage.call
    puts 'end stage'
  end
end


