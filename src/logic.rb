FECS::Cmp.new('Player')
FECS::Cmp.new('Velocity', x: 0, y: 0)
FECS::Cmp.new('Position', x: 0, y: 0)
FECS::Cmp.new('Movement', deceleration: 3, acceleration: 8, max_speed: 15)
FECS::Cmp.new('Sprite',
              :texture,
              :origin,
              :source_rec,
              :dest_rec,
              :rotation,
              :tint)
FECS::Cmp.new('Tileset',
              :origin,
              :tileset,
              :dest_rec,
              :rotation,
              :tint)
FECS::Cmp.new('Hitbox',
              :rec,
              offset_x: 0,
              offset_y: 0)
FECS::Cmp.new('Hp', value: 0)

lancelot = Tileset.new(texture: Rl::Texture.new('./assets/lancelot_.png'))

puts 'about to make rectangles'
8.times do |x|
  lancelot.frames.push Rl::Rectangle.new((24 * x), 0, 24, 24)
end
puts 'finished making rectangles'

FECS::Cmp::Hitbox.new(
  rec: Rl::Rectangle.new(100,100,250,250),
  offset_x: 4*2,
  offset_y: 4*2
)


@player = FECS::Ent.new(
  FECS::Cmp::Player.new,
  FECS::Cmp::Position.new,
  FECS::Cmp::Velocity.new,
  FECS::Cmp::Tileset.new(
    tileset: lancelot,
    dest_rec: Rl::Rectangle.new(0,0,24*2,24*2),
    origin: Rl::Vector2.new(0,0),
    tint: Rl::Color.new(255,255,255,255),
    rotation: 0
  ),
  FECS::Cmp::Movement.new(
    deceleration: 1000,
    acceleration: 1000,
    max_speed: 300,
  ),
  FECS::Cmp::Hitbox.new(
    rec: Rl::Rectangle.new(0,0,16*2,20*2),
    offset_x: 4*2,
    offset_y: 4*2
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
      input_y -= 1.0
    end
    if Rl.key_down? 83 # DOWN S
      input_y += 1.0
    end
    if Rl.key_down? 65 # LEFT A
      input_x -= 1.0
    end
    if Rl.key_down? 68 # RIGHT D
      input_x += 1.0
    end
    # Normalize input
    input_mag = Math.sqrt((input_x**2) + (input_y**2))
    unless input_mag.zero?
      input_x /= input_mag
      input_y /= input_mag

      # Add normalized speed
      velocity_cmp.x += input_x * movement_cmp.acceleration * Rl.frame_time
      velocity_cmp.y += input_y * movement_cmp.acceleration * Rl.frame_time

      # Get magnitude
      velocity_mag = Math.sqrt((velocity_cmp.x**2) + (velocity_cmp.y**2))
      velocity_x_mag = velocity_cmp.x / velocity_mag
      velocity_y_mag = velocity_cmp.y / velocity_mag

      if velocity_mag > movement_cmp.max_speed
        velocity_cmp.x = velocity_x_mag * movement_cmp.max_speed
        velocity_cmp.y = velocity_y_mag * movement_cmp.max_speed
      end
    else
      velocity_mag = Math.sqrt((velocity_cmp.x**2) + (velocity_cmp.y**2))

      # If going slower then deceleration
      if velocity_mag <= (movement_cmp.deceleration * Rl.frame_time)
        # Set to 0
        velocity_cmp.x = 0
        velocity_cmp.y = 0
      else
        velocity_x_mag = velocity_cmp.x / velocity_mag
        velocity_y_mag = velocity_cmp.y / velocity_mag

        # Add deceleration
        velocity_cmp.x -= velocity_x_mag * movement_cmp.deceleration * Rl.frame_time
        velocity_cmp.y -= velocity_y_mag * movement_cmp.deceleration * Rl.frame_time
      end
    end
  end,
  FECS::Sys.new('Walls') do
    player = FECS::Cmp::Player.first.entity
    player_hitbox = player.component[FECS::Cmp::Hitbox]
    position_cmp = player.component[FECS::Cmp::Position]
    velocity_cmp = player.component[FECS::Cmp::Velocity]
    step = Rl::Rectangle.new(
      position_cmp.x + (velocity_cmp.x * Rl.frame_time) + player_hitbox.offset_x,
      position_cmp.y + (velocity_cmp.y * Rl.frame_time) + player_hitbox.offset_y,
      player_hitbox.rec.width,
      player_hitbox.rec.height
    )
    FECS::Cmp::Hitbox.each do |hitbox|
      next if hitbox.equal? player_hitbox
      if step.collide_with_rec? hitbox.rec
        intersection = step.collision_rec hitbox.rec
        #left collision
        if intersection.width < intersection.height
          # Colliding right/left
          # if x equal push right
          if intersection.x.equal? step.x
            position_cmp.x += intersection.width
          # else push left
          else
            position_cmp.x -= intersection.width
          end
          velocity_cmp.x = 0
        elsif intersection.height < intersection.width
          # Colliding up/down
          # if y equal push down
          if intersection.y.equal? step.y
            position_cmp.y += intersection.height
          # else push up
          else
            position_cmp.y -= intersection.height
          end
          velocity_cmp.y = 0
        else
          # Tunneled into a hitbox
        end
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
      ent = position_cmp.entity
      sprite = ent.component[FECS::Cmp::Tileset]
      hitbox = ent.component[FECS::Cmp::Hitbox]
      sprite.tileset.step(4 * Rl.frame_time)
      if sprite
        sprite.dest_rec.x = position_cmp.x
        sprite.dest_rec.y = position_cmp.y
        hitbox.rec.x = position_cmp.x + hitbox.offset_x
        hitbox.rec.y = position_cmp.y + hitbox.offset_y
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
    FECS::Cmp::Tileset.each do |sprite_cmp|
      Rl.draw_texture_pro(texture: sprite_cmp.tileset.texture,
                          origin: sprite_cmp.origin,
                          source_rec: sprite_cmp.tileset.rec,
                          dest_rec: sprite_cmp.dest_rec,
                          tint: sprite_cmp.tint,
                          rotation: sprite_cmp.rotation)
    end
  end,
  FelECS::Sys.new('DebugRenderHitbox') do
    FECS::Cmp::Hitbox.each do |hitbox|
      #hitbox.rec.draw(color: BLACK)
      hitbox.rec.draw_lines(line_thick: 2, color: BLUE)
    end
  end
)

FelECS::Order.sort(
  FECS::Sys::PlayerInput,
  FECS::Sys::Walls,
  FECS::Sys::Movement,
  FECS::Sys::ApplyPositionToSprite,
  FECS::Sys::Render,
  FECS::Sys::ShowSpeed,
  FECS::Sys::DebugRenderHitbox,
)
