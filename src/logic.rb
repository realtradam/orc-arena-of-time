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
FECS::Cmp.new('Tileset',
              :origin,
              :tileset,
              :dest_rect,
              :rotation,
              :tint)
FECS::Cmp.new('Hitbox',
              :rect,
              offset_x: 0,
              offset_y: 0)
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
  FECS::Cmp::Tileset.new(
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
  FECS::Cmp::Hitbox.new(
    rect: Rl::Rectangle.new(0,0,16,20),
    offset_x: 4,
    offset_y: 4
  ),
)

FECS::Stg.add(FECS::Scn.new('Play'))

FECS::Scn::Play.add(
  FECS::Sys.new('PlayerInput') do
    ent = FECS::Cmp::Player.first.entity
    velocity_cmp = ent.component[FECS::Cmp::Velocity]
    #velocity_cmp.x = 0
    #velocity_cmp.y = 0
    input_x = 0
    input_y = 0
    movement_cmp = ent.component[FECS::Cmp::Movement]
    if Rl.key_down? 87 # UP W
      #velocity_cmp.y += movement_cmp.acceleration
      input_y += 1.0
      #velocity_cmp.y = [velocity_cmp.y,
      #                  (movement_cmp.max_speed + movement_cmp.deceleration)].min
    end
    if Rl.key_down? 83 # DOWN S
      #velocity_cmp.y -= movement_cmp.acceleration 
      input_y -= 1.0
      #velocity_cmp.y = [velocity_cmp.y,
      #                  (-movement_cmp.max_speed - movement_cmp.deceleration)].max
    end
    if Rl.key_down? 65 # LEFT A
      #velocity_cmp.x += movement_cmp.acceleration 
      input_x += 1.0
      #velocity_cmp.x = [velocity_cmp.x,
      #                  (movement_cmp.max_speed + movement_cmp.deceleration)].min
    end
    if Rl.key_down? 68 # RIGHT D
      #velocity_cmp.x -= movement_cmp.acceleration 
      input_x -= 1.0
      #velocity_cmp.x = [velocity_cmp.x,
      #                  (-movement_cmp.max_speed - movement_cmp.deceleration)].max
    end
    # Normalize input
    input_mag = Math.sqrt((input_x**2) + (input_y**2))
    unless input_mag.zero?
      input_x /= input_mag
      input_y /= input_mag
    end

    # Add normalized speed
    velocity_cmp.x += input_x * movement_cmp.acceleration
    velocity_cmp.y += input_y * movement_cmp.acceleration

    # Get magnitude
    velocity_mag = Math.sqrt((velocity_cmp.x**2) + (velocity_cmp.y**2))

    # If going slower then deceleration
    if velocity_mag < movement_cmp.deceleration
      # Set to 0
      velocity_cmp.x = 0
      velocity_cmp.y = 0
    else
      # Normalize Velocity
      velocity_x_mag = velocity_cmp.x / velocity_mag
      velocity_y_mag = velocity_cmp.y / velocity_mag

      # Add deceleration
      velocity_cmp.x -= velocity_x_mag * movement_cmp.deceleration
      velocity_cmp.y -= velocity_y_mag * movement_cmp.deceleration

      velocity_mag = Math.sqrt((velocity_cmp.x**2) + (velocity_cmp.y**2))

      if velocity_mag > movement_cmp.max_speed
        velocity_x_mag = velocity_cmp.x / velocity_mag
        velocity_y_mag = velocity_cmp.y / velocity_mag

        velocity_cmp.x = velocity_x_mag * movement_cmp.max_speed
        velocity_cmp.y = velocity_y_mag * movement_cmp.max_speed
      end
    end
  end,
  FECS::Sys.new('Walls') do
    player = FECS::Cmp::Player.first.entity
    player_hitbox = player.component[FECS::Cmp::Hitbox]
    FECS::Cmp::Hitbox.each do |hitbox|
      next if player_hitbox.equal? hitbox
      if player_hitbox.collide_with_rect? hitbox
      end
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
      sprite = position_cmp.entity.component[FECS::Cmp::Tileset]
      sprite.tileset.step(4 * Rl.frame_time)
      if sprite
        sprite.origin.x = position_cmp.x
        sprite.origin.y = position_cmp.y
      end
    end
  end,
  FECS::Sys.new('ShowSpeed') do
    player = FECS::Cmp::Player.first.entity
    y_vel = player.component[FECS::Cmp::Velocity].y.abs
    x_vel = player.component[FECS::Cmp::Velocity].x.abs
    vel = Math.sqrt(x_vel**2 + y_vel**2)
    movement = player.component[FECS::Cmp::Movement]
    frame = player.component[FECS::Cmp::Tileset].tileset.frame
    max_speed = (movement.max_speed)

    Rl.draw_text(text: "x max: #{"%.1f" % max_speed}", x: 500, y: 0, font_size: 30, color: BLACK)
    Rl.draw_text(text: "animation frame: #{"%.2f" % frame}", x: 500, y: 30, font_size: 30, color: BLACK)
    Rl.draw_text(text: "x vel: #{"%.1f" % x_vel}", x: 500, y: 60, font_size: 30, color: BLACK)
    Rl.draw_text(text: "y vel: #{"%.1f" % y_vel}", x: 500, y: 90, font_size: 30, color: BLACK)
    Rl.draw_text(text: "n vel: #{"%.1f" % vel}", x: 500, y: 120, font_size: 30, color: BLACK)
  end,
  FECS::Sys.new('Render') do
    #FECS::Cmp::Tileset.each do |sprite_cmp|
    #  Rl.draw_texture_pro(texture: sprite_cmp.texture,
    #                      origin: sprite_cmp.origin,
    #                      source_rect: sprite_cmp.source_rect,
    #                      dest_rect: sprite_cmp.dest_rect,
    #                      tint: sprite_cmp.tint,
    #                      rotation: sprite_cmp.rotation)
    #end
    FECS::Cmp::Tileset.each do |sprite_cmp|
      Rl.draw_texture_pro(texture: sprite_cmp.tileset.texture,
                          origin: sprite_cmp.origin,
                          source_rect: sprite_cmp.tileset.rect,
                          dest_rect: sprite_cmp.dest_rect,
                          tint: sprite_cmp.tint,
                          rotation: sprite_cmp.rotation)
    end
  end,
  FelECS::Sys.new('DebugRenderHitbox') do
  end
)

FelECS::Order.sort(
  FECS::Sys::PlayerInput,
  FECS::Sys::Movement,
  FECS::Sys::ApplyPositionToSprite,
  FECS::Sys::Render,
  FECS::Sys::ShowSpeed,
)
