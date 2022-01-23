FECS::Stg.add(FECS::Scn.new('Play'))

FECS::Scn::Play.add(
  FECS::Sys.new('PlayerInput') do
    ent = FECS::Cmp::Player.first.entity
    velocity_cmp = ent.component[FECS::Cmp::Velocity]
    #velocity_cmp.x = 0
    #velocity_cmp.y = 0
    movement_cmp = ent.component[FECS::Cmp::Movement]
    if Rl.key_down? 87 # UP W
      velocity_cmp.y += movement_cmp.acceleration * Rl.frame_time 
      velocity_cmp.y = [velocity_cmp.y,
                        (movement_cmp.max_speed + movement_cmp.deceleration) * Rl.frame_time].min
    end
    if Rl.key_down? 83 # DOWN S
      velocity_cmp.y -= movement_cmp.acceleration * Rl.frame_time 
      velocity_cmp.y = [velocity_cmp.y,
                        (-movement_cmp.max_speed - movement_cmp.deceleration) * Rl.frame_time].max
    end
    if Rl.key_down? 65 # LEFT A
      velocity_cmp.x += movement_cmp.acceleration * Rl.frame_time 
      velocity_cmp.x = [velocity_cmp.x,
                        (movement_cmp.max_speed + movement_cmp.deceleration) * Rl.frame_time].min
    end
    if Rl.key_down? 68 # RIGHT D
      velocity_cmp.x -= movement_cmp.acceleration * Rl.frame_time 
      velocity_cmp.x = [velocity_cmp.x,
                        (-movement_cmp.max_speed - movement_cmp.deceleration) * Rl.frame_time].max
    end
    if velocity_cmp.x > (movement_cmp.deceleration * Rl.frame_time)
      velocity_cmp.x -= movement_cmp.deceleration * Rl.frame_time
    elsif velocity_cmp.x <  (-movement_cmp.deceleration * Rl.frame_time)
      velocity_cmp.x += movement_cmp.deceleration * Rl.frame_time
    else
      velocity_cmp.x = 0
    end
    if velocity_cmp.y > (movement_cmp.deceleration * Rl.frame_time)
      velocity_cmp.y -= movement_cmp.deceleration * Rl.frame_time
    elsif velocity_cmp.y <  (-movement_cmp.deceleration * Rl.frame_time)
      velocity_cmp.y += movement_cmp.deceleration * Rl.frame_time
    else
      velocity_cmp.y = 0
    end
  end,
  FECS::Sys.new('Movement') do
    FECS::Cmp::Velocity.each do |velocity_cmp|
      ent = velocity_cmp.entity
      position_component = ent.component[FECS::Cmp::Position]
      movement_cmp = ent.component[FECS::Cmp::Movement]

      position_component.x += velocity_cmp.x
      position_component.y += velocity_cmp.y
    end
  end,
  FECS::Sys.new('ApplyPositionToSprite') do
    FECS::Cmp::Position.each do |position_cmp|
      sprite = position_cmp.entity.component[FECS::Cmp::Sprite]
      if sprite
        sprite.origin.x = position_cmp.x
        sprite.origin.y = position_cmp.y
      end
    end
  end,
  FECS::Sys.new('ShowSpeed') do
    player = FECS::Cmp::Player.first.entity
    player_accel = player.component[FECS::Cmp::Velocity].x
    movement = player.component[FECS::Cmp::Movement]
    max_speed = (movement.max_speed + movement.deceleration) * Rl.frame_time

    Rl.draw_text(text: "x vel: #{"%.3f" % player_accel}", x: 500, y: 0, font_size: 30, color: BLACK)
    Rl.draw_text(text: "x max: #{"%.3f" % max_speed}", x: 500, y: 30, font_size: 30, color: BLACK)
  end,
  FECS::Sys.new('Render') do
    FECS::Cmp::Sprite.each do |sprite_cmp|
      Rl.draw_texture_pro(texture: sprite_cmp.texture,
                          origin: sprite_cmp.origin,
                          source_rect: sprite_cmp.source_rect,
                          dest_rect: sprite_cmp.dest_rect,
                          tint: sprite_cmp.tint,
                          rotation: sprite_cmp.rotation)
    end
  end,
)

FelECS::Order.sort(
  FECS::Sys::PlayerInput,
  FECS::Sys::Movement,
  FECS::Sys::ApplyPositionToSprite,
  FECS::Sys::Render,
)
