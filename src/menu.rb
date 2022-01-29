FECS::Cmp.new('Button',
              :unpressed_texture,
              :pressed_texture,
              clicked: false)

FECS::Sys.new('ConstructTitleScreen') do
  ent = FECS::Ent.new(
    FECS::Cmp::Button.new(
      unpressed_texture: Rl::Texture.new('./assets/start-button.png'),
      pressed_texture: Rl::Texture.new('./assets/start-button-pressed.png')
    ),
    FECS::Cmp::Hitbox.new(
      rec: Rl::Rectangle.new(0,0,204,42),
    ),
    FECS::Cmp::Sprite.new(
      source_rec: Rl::Rectangle.new(0,0,102,21),
      dest_rec: Rl::Rectangle.new(0,0,204,42),
    ),
    FECS::Cmp::Position.new(x: 450-102, y: 340)
  )
  MapTexture.texture = Rl::Texture.new('./assets/menu-bg.png')
  MapTexture.source_rec = Rl::Rectangle.new(0,0,125,125)
  MapTexture.dest_rec = Rl::Rectangle.new(325,212,250,250)
end

FECS::Sys.new('DestroyTitleScreen') do
  FECS::Cmp::Button.reverse_each do |btn|
    btn_ent = btn.entity
    btn_ent.components.each do |mgr, arry|
      arry.reverse_each do |cmp|
        puts cmp
        cmp.delete
      end
    end
    btn_ent.delete
  end
  FECS::Stg.remove(FECS::Scn::Menu)
  FECS::Stg.add(FECS::Scn::Play)
  CurrentLevel.level = 0
end

