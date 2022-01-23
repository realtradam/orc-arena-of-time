FECS::Cmp.new('Player')
FECS::Cmp.new('Velocity', x: 0, y: 0)
FECS::Cmp.new('Position', x: 0, y: 0)
FECS::Cmp.new('Movement', deceleration: 3, acceleration: 8, max_speed: 15)
FECS::Cmp.new('Sprite',
              :texture,
              :origin,
              :source_rect,
              :dest_rect,
              :rotation,
              :tint)
FECS::Cmp.new('SpriteSheet',
              :origin,
              :tileset,
              :dest_rect,
              :rotation,
              :tint)
FECS::Cmp.new('Hp', value: 0)

lancelot = Tileset.new(texture: Rl::Texture.new('./assets/lancelot_.png'))

8.times do |x|
  lancelot.frames.push Rl::Rectangle.new((24 * x), 0, 24, 24)
end


@player = FECS::Ent.new(
  FECS::Cmp::Player.new,
  FECS::Cmp::Position.new,
  FECS::Cmp::Velocity.new,
  #FECS::Cmp::Sprite.new(
  #  texture: Rl::Texture.new('./assets/lancelot_.png'),
  #  source_rect: Rl::Rectangle.new(0,0,24,24),
  #  dest_rect: Rl::Rectangle.new(0,0,48,48),
  #  origin: Rl::Vector2.new(0,0),
  #  tint: Rl::Color.new(255,255,255,255),
  #  rotation: 0
  #),
  FECS::Cmp::SpriteSheet.new(
    tileset: lancelot,
    dest_rect: Rl::Rectangle.new(0,0,48,48),
    origin: Rl::Vector2.new(0,0),
    tint: Rl::Color.new(255,255,255,255),
    rotation: 0
  ),
  FECS::Cmp::Movement.new(
    deceleration: 2.25,
    acceleration: 3,
    max_speed: 300,
  ),
)



FECS::Stg.add(FECS::Scn.new('Play'))

FECS::Scn::Play.add(
  FECS::Sys.new('PlayerInput') do
    ent = FECS::Cmp::Player.first.entity
    velocity_cmp = ent.component[FECS::Cmp::Velocity]
    #velocity_cmp.x = 0
    #velocity_cmp.y = 0
    movement_cmp = ent.component[FECS::Cmp::Movement]
    if Rl.key_down? 87 # UP W
      velocity_cmp.y += movement_cmp.acceleration 
      velocity_cmp.y = [velocity_cmp.y,
                        (movement_cmp.max_speed + movement_cmp.deceleration)].min
    end
    if Rl.key_down? 83 # DOWN S
      velocity_cmp.y -= movement_cmp.acceleration 
      velocity_cmp.y = [velocity_cmp.y,
                        (-movement_cmp.max_speed - movement_cmp.deceleration)].max
    end
    if Rl.key_down? 65 # LEFT A
      velocity_cmp.x += movement_cmp.acceleration 
      velocity_cmp.x = [velocity_cmp.x,
                        (movement_cmp.max_speed + movement_cmp.deceleration)].min
    end
    if Rl.key_down? 68 # RIGHT D
      velocity_cmp.x -= movement_cmp.acceleration 
      velocity_cmp.x = [velocity_cmp.x,
                        (-movement_cmp.max_speed - movement_cmp.deceleration)].max
    end
    if velocity_cmp.x > (movement_cmp.deceleration)
      velocity_cmp.x -= movement_cmp.deceleration 
    elsif velocity_cmp.x <  (-movement_cmp.deceleration)
      velocity_cmp.x += movement_cmp.deceleration 
    else
      velocity_cmp.x = 0
    end
    if velocity_cmp.y > (movement_cmp.deceleration)
      velocity_cmp.y -= movement_cmp.deceleration 
    elsif velocity_cmp.y <  (-movement_cmp.deceleration)
      velocity_cmp.y += movement_cmp.deceleration 
    else
      velocity_cmp.y = 0
    end
  end,
  FECS::Sys.new('Movement') do
    FECS::Cmp::Velocity.each do |velocity_cmp|
      ent = velocity_cmp.entity
      position_component = ent.component[FECS::Cmp::Position]
      movement_cmp = ent.component[FECS::Cmp::Movement]

      position_component.x += velocity_cmp.x * Rl.frame_time
      position_component.y += velocity_cmp.y * Rl.frame_time
    end
  end,
  FECS::Sys.new('ApplyPositionToSprite') do
    FECS::Cmp::Position.each do |position_cmp|
      sprite = position_cmp.entity.component[FECS::Cmp::SpriteSheet]
      sprite.tileset.step(4 * Rl.frame_time)
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
    frame = player.component[FECS::Cmp::SpriteSheet].tileset.frame
    max_speed = (movement.max_speed)

    Rl.draw_text(text: "x vel: #{"%.1f" % player_accel}", x: 500, y: 0, font_size: 30, color: BLACK)
    Rl.draw_text(text: "x max: #{"%.1f" % max_speed}", x: 500, y: 30, font_size: 30, color: BLACK)
    Rl.draw_text(text: "animation frame: #{"%.2f" % frame}", x: 500, y: 60, font_size: 30, color: BLACK)
  end,
  FECS::Sys.new('Render') do
    #FECS::Cmp::SpriteSheet.each do |sprite_cmp|
    #  Rl.draw_texture_pro(texture: sprite_cmp.texture,
    #                      origin: sprite_cmp.origin,
    #                      source_rect: sprite_cmp.source_rect,
    #                      dest_rect: sprite_cmp.dest_rect,
    #                      tint: sprite_cmp.tint,
    #                      rotation: sprite_cmp.rotation)
    #end
    FECS::Cmp::SpriteSheet.each do |sprite_cmp|
      Rl.draw_texture_pro(texture: sprite_cmp.tileset.texture,
                          origin: sprite_cmp.origin,
                          source_rect: sprite_cmp.tileset.rect,
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
