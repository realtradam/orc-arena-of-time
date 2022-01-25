

#Lautrec = Rl::Texture.new('./assets/lancelot_.png')
#Lautrec_Source = Rl::Rectangle.new(0,0,24,24)
#Position = Rl::Rectangle.new(0,0,48,48)
#Origin = Rl::Vector2.new(0,0)


Rl.while_window_open do

  Rl.draw(clear_color: BLACK) do
    #Rl.draw_texture_pro(texture: Lautrec, origin: Origin, source: Lautrec_Source, dest: Position)
    #draw_texture_pro(texture:, source:, dest:, origin: Rl::Vector.new(0,0), rotation: 0, tint: Rl::Color.new(255,255,255,255))
    FECS::Stage.call
  end
end


