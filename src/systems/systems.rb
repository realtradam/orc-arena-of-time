FECS::Stg.add(FECS::Scn.new('Play'))

FECS::Scn::Play.add(
  FECS::Sys.new('PlayerInput') do
    puts 'start player input'
    ent = FECS::Cmp::Player.first.entity
    velocity_component = ent.component[FECS::Cmp::Velocity]
    velocity_component.x = 0
    velocity_component.y = 0
    velocity_component.y -= 10 if Rl.key_down? 87
    velocity_component.y += 10 if Rl.key_down? 83
    velocity_component.x -= 10 if Rl.key_down? 65
    velocity_component.x += 10 if Rl.key_down? 68
    puts 'end player input'
  end,
  FECS::Sys.new('Movement') do
    FECS::Cmp::Velocity.each do |velocity_component|
      position_component = velocity_component.entity.component[FECS::Cmp::Position]
      position_component.x += velocity_component.x
      position_component.y += velocity_component.y
    end
  end,
  FECS::Sys.new('TakePosition') do
    FECS::Cmp::Position.each do |position_cmp|
      sprite = position_cmp.entity.component[FECS::Cmp::Sprite]
      if sprite
        sprite.dest_rect.x = position_cmp.x
        sprite.dest_rect.y = position_cmp.y
      end
    end
  end,
  FECS::Sys.new('Render') do
    FECS::Cmp::Sprite.each do |sprite_cmp|
      #Rl.draw_texture_pro(texture: sprite_cmp.texture,
      #                    origin: sprite_cmp.origin_rect,
      #                    source_rect: sprite_cmp.source_rect,
      #                    dest_rect: sprite_cmp.dest_rect)
    end
  end,
)

FelECS::Order.sort(
  FECS::Sys::PlayerInput,
  FECS::Sys::Movement,
  FECS::Sys::TakePosition,
  FECS::Sys::Render,
)
