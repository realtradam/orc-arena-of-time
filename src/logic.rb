FECS::Cmp.new('Player')
FECS::Cmp.new('Velocity',
              x: 0,
              y: 0)
FECS::Cmp.new('Position',
              x: 0,
              y: 0)
FECS::Cmp.new('Movement',
              deceleration: 3,
              acceleration: 8,
              max_speed: 15)
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
FECS::Cmp.new('Hp',
              value: 0,
              invincible_timer: 0.1,
              max_invincible_time: 2)
FECS::Cmp.new('Input',
              move_right: false,
              move_left: false,
              move_up: false,
              move_down: false,
              show_debug: false,
             )
FECS::Cmp.new('ScissorBox',
              :rec)
FECS::Cmp.new('DamageHitbox',
             :rec,
             damage: 1,
             offset_x: 0,
             offset_y: 0)

#ScissorPath = Path.new(
#  lambda do |time|
#    [Math.bezier([200, 200, 1183, 200],time)-150,
#     Math.bezier([200, 1183, 200, 200],time)-150]
#  end
#)

#FECS::Cmp::ScissorBox.new(rec: Rl::Rectangle.new(200,200,250,250))

Input = FECS::Cmp::Input.new

lancelot = Tileset.new(texture: Rl::Texture.new('./assets/lancelot_.png'))

FECS::Cmp::Sprite.new(
  texture: Rl::Texture.new('./assets/map1.png'),
  source_rec: Rl::Rectangle.new(0,0,448,336),
  dest_rec: Rl::Rectangle.new(0,0,448*2,336*2)
)

puts 'about to make rectangles'
4.times do |x|
  lancelot.frames.push Rl::Rectangle.new((24 * x), 24*2, 24, 24)
end
puts 'finished making rectangles'
MovingHitbox1 = FECS::Cmp::Hitbox.new(
  rec: Rl::Rectangle.new(150,50,35,150),
  offset_x: 0,#4*2,
  offset_y: 0#4*2
)
MovingHitbox2 = FECS::Cmp::Hitbox.new(
  rec: Rl::Rectangle.new(50,50,35,150),
  offset_x: 0,#4*2,
  offset_y: 0#4*2
)
=begin
FECS::Cmp::Hitbox.new(
  rec: Rl::Rectangle.new(250,250,250,150),
  offset_x: 0,#4*2,
  offset_y: 0#4*2
)
FECS::Cmp::Hitbox.new(
  rec: Rl::Rectangle.new(350,200,50,350),
  offset_x: 0,#4*2,
  offset_y: 0#4*2
)
FECS::Cmp::Hitbox.new(
  rec: Rl::Rectangle.new(70,470,200,200),
  offset_x: 0,#4*2,
  offset_y: 0#4*2
)
FECS::Cmp::Hitbox.new(
  rec: Rl::Rectangle.new(470,470,200,200),
  offset_x: 0,#4*2,
  offset_y: 0#4*2
)
=end


@player = FECS::Ent.new(
  FECS::Cmp::Player.new,
  FECS::Cmp::Hp.new(value: 100, max_invincible_time: 2),
  FECS::Cmp::Position.new(x: 120, y: 300),
  FECS::Cmp::Velocity.new,
  FECS::Cmp::Tileset.new(
    tileset: lancelot,
    dest_rec: Rl::Rectangle.new(0,0,24*2,24*2),
    origin: Rl::Vector2.new(0,0),
    tint: Rl::Color.new(255,255,255,255),
    rotation: 0
  ),
  FECS::Cmp::Movement.new(
    deceleration: 2500,
    acceleration: 1000,
    max_speed: 400,
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
    Input.move_up = Rl.key_down? 87 # W
    Input.move_left = Rl.key_down? 65 # A
    Input.move_down = Rl.key_down? 83 # S
    Input.move_right = Rl.key_down? 68 # D
    Input.show_debug = Rl.key_down? 80 # P
  end,
  FECS::Sys.new('PlayerMovement') do
    ent = FECS::Cmp::Player.first.entity
    velocity_cmp = ent.component[FECS::Cmp::Velocity]
    #velocity_cmp.x = 0
    #velocity_cmp.y = 0
    input_x = 0
    input_y = 0
    movement_cmp = ent.component[FECS::Cmp::Movement]
    if Input.move_up
      input_y -= 1.0
    end
    if Input.move_down
      input_y += 1.0
    end
    if Input.move_left
      input_x -= 1.0
    end
    if Input.move_right
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
      Helper.decelerate(velocity_cmp, movement_cmp)
      #velocity_mag = Math.sqrt((velocity_cmp.x**2) + (velocity_cmp.y**2))

      ## If going slower then deceleration
      #if velocity_mag <= (movement_cmp.deceleration * Rl.frame_time)
      #  # Set to 0
      #  velocity_cmp.x = 0
      #  velocity_cmp.y = 0
      #else
      #  velocity_x_mag = velocity_cmp.x / velocity_mag
      #  velocity_y_mag = velocity_cmp.y / velocity_mag

      #  # Add deceleration
      #  velocity_cmp.x -= velocity_x_mag * movement_cmp.deceleration * Rl.frame_time
      #  velocity_cmp.y -= velocity_y_mag * movement_cmp.deceleration * Rl.frame_time
      #end
    end
  end,
  FECS::Sys.new('Walls') do

    MovingHitbox1.rec.x = (Math.sin(Rl.time) * 300) + 250 + 50
    MovingHitbox2.rec.x = (Math.sin(Rl.time) * 300) + 150 + 50

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
            #position_cmp.x += intersection.width + (velocity_cmp.x * Rl.frame_time)
            #move blue.width + blue.x
            position_cmp.x = hitbox.rec.x + hitbox.rec.width - player_hitbox.offset_x
            velocity_cmp.x = 0 if velocity_cmp.x.negative?# && !Input.move_right
            #if !((Input.move_up ^ Input.move_down) || Input.move_right)
            #  Helper.decelerate(
            #    velocity_cmp,
            #    player.component[FECS::Cmp::Movement]
            #  )
            #end

            # else push left
          else
            #position_cmp.x -= intersection.width - (velocity_cmp.x * Rl.frame_time)
            #move blue.x -  green.width
            position_cmp.x = hitbox.rec.x - player_hitbox.rec.width - player_hitbox.offset_x
            velocity_cmp.x = 0 if velocity_cmp.x.positive?# && !Input.move_left
            #if !((Input.move_up ^ Input.move_down) || Input.move_left)
            #  Helper.decelerate(
            #    velocity_cmp,
            #    player.component[FECS::Cmp::Movement]
            #  )
            #end
          end
          if !(Input.move_up ^ Input.move_down)
            Helper.decelerate(
              velocity_cmp,
              player.component[FECS::Cmp::Movement]
            )
          end
        elsif intersection.height < intersection.width
          # Colliding up/down
          # if y equal push down
          if intersection.y.equal? step.y
            #position_cmp.y += intersection.height + (velocity_cmp.y * Rl.frame_time)
            position_cmp.y = hitbox.rec.y + hitbox.rec.height - player_hitbox.offset_y
            #set to blue.y + blue.height
            # else push up
            velocity_cmp.y = 0 if velocity_cmp.y.negative?
          else
            #position_cmp.y -= intersection.height - (velocity_cmp.y * Rl.frame_time)
            position_cmp.y = hitbox.rec.y - player_hitbox.rec.height - player_hitbox.offset_y
            #set to blue.y - green.height
            velocity_cmp.y = 0 if velocity_cmp.y.positive?
          end
          if !(Input.move_left ^ Input.move_right)
            Helper.decelerate(
              velocity_cmp,
              player.component[FECS::Cmp::Movement]
            )
          end
        else
          # Tunneled into a hitbox
          # Dont allow movement
          if (player_hitbox.rec.width.equal? hitbox.rec.width) && (player_hitbox.rec.height.equal? hitbox.rec.height)
            velocity_cmp.x = 0
            velocity_cmp.y = 0
          end
        end
      end
    end
  end,
  FECS::Sys.new('Damage') do
    player = FECS::Cmp::Player.first.entity
    player_hitbox = player.component[FECS::Cmp::Hitbox]
    hp_cmp = player.component[FECS::Cmp::Hp]
    next if hp_cmp.value <= 0
    if hp_cmp.invincible_timer >= 0
      hp_cmp.invincible_timer -= Rl.frame_time
    end
    FECS::Cmp::DamageHitbox.each do |dmg_hitbox|
      if player_hitbox.rec.collide_with_rec?(dmg_hitbox.rec) &&
          hp_cmp.invincible_timer <= 0
        hp_cmp.value -= dmg_hitbox.damage
        hp_cmp.invincible_timer = hp_cmp.max_invincible_time
        puts "oof -#{dmg_hitbox.damage} hp"
        puts "hp: #{hp_cmp.value}"
        if hp_cmp.value <= 0
          puts 'ded'
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
      y_vel = ent.component[FECS::Cmp::Velocity].y
      x_vel = ent.component[FECS::Cmp::Velocity].x
      velocity_mag = Math.sqrt((x_vel**2) + (y_vel**2))
      sprite.tileset.step((velocity_mag*0.04) * Rl.frame_time)
      if sprite
        sprite.dest_rec.x = position_cmp.x
        sprite.dest_rec.y = position_cmp.y
        hitbox.rec.x = position_cmp.x + hitbox.offset_x
        hitbox.rec.y = position_cmp.y + hitbox.offset_y
      end
    end
  end,
  FECS::Sys.new('ShowSpeed') do
    if Input.show_debug
      player = FECS::Cmp::Player.first.entity
      y_vel = player.component[FECS::Cmp::Velocity].y.abs
      x_vel = player.component[FECS::Cmp::Velocity].x.abs
      vel = Math.sqrt(x_vel**2 + y_vel**2)
      movement = player.component[FECS::Cmp::Movement]
      frame = player.component[FECS::Cmp::Tileset].tileset.frame
      max_speed = (movement.max_speed)

      #Rl.draw_text(text: "x max: #{"%.1f" % max_speed}", x: 500, y: 0, font_size: 30, color: BLACK)
      #Rl.draw_text(text: "animation frame: #{"%.2f" % frame}", x: 500, y: 30, font_size: 30, color: BLACK)
      #Rl.draw_text(text: "x vel: #{"%.1f" % x_vel}", x: 500, y: 60, font_size: 30, color: BLACK)
      #Rl.draw_text(text: "y vel: #{"%.1f" % y_vel}", x: 500, y: 90, font_size: 30, color: BLACK)
      Rl.draw_text(text: "speed: #{"%.1f" % vel}", x: 10, y: 10, font_size: 30, color: WHITE)
      Rl.draw_text(text: "fps: #{Rl.fps}", x: 10, y: 40, font_size: 30, color: WHITE)
      Rl.draw_text(text: "mouse x: #{Rl.mouse_x}", x: 10, y: 70, font_size: 30, color: WHITE)
      Rl.draw_text(text: "mouse y: #{Rl.mouse_y}", x: 10, y: 100, font_size: 30, color: WHITE)
    end
  end,
  FECS::Sys.new('Render') do
    scissor_path = Levels[CurrentLevel.level][:scissor_path].call((Rl.time/8) % 1)
    scissor_size = Levels[CurrentLevel.level][:scissor_size].call((Rl.time/8) % 1)
    Rl::Rectangle.new(scissor_path[0], scissor_path[1], scissor_size[0], scissor_size[1]).draw(color: Rl::Color.new(52,52,64,255))
    player = FECS::Cmp::Player.first.entity
    y_vel = player.component[FECS::Cmp::Velocity].y.abs
    x_vel = player.component[FECS::Cmp::Velocity].x.abs
    vel = Math.sqrt(x_vel**2 + y_vel**2)
    Rl.scissor_mode(
      x: scissor_path[0],
      y: scissor_path[1],
      width: scissor_size[0],
      height: scissor_size[1]) do
        if Input.show_debug
          Rl.draw_text(text: "speed: #{"%.1f" % vel}", x: 10, y: 10, font_size: 30, color: BLACK)
          Rl.draw_text(text: "fps: #{Rl.fps}", x: 10, y: 40, font_size: 30, color: BLACK)
          Rl.draw_text(text: "mouse x: #{Rl.mouse_x}", x: 10, y: 70, font_size: 30, color: BLACK)
          Rl.draw_text(text: "mouse y: #{Rl.mouse_y}", x: 10, y: 100, font_size: 30, color: BLACK)
        end
        FECS::Cmp::Sprite.each do |sprite_cmp|
          Rl.draw_texture_pro(texture: sprite_cmp.texture,
                              origin: Rl::Vector2.new(0,0),
                              source_rec: sprite_cmp.source_rec,
                              dest_rec: sprite_cmp.dest_rec)
        end
        FECS::Cmp::Tileset.each do |sprite_cmp|
          Rl.draw_texture_pro(texture: sprite_cmp.tileset.texture,
                              origin: sprite_cmp.origin,
                              source_rec: sprite_cmp.tileset.rec,
                              dest_rec: sprite_cmp.dest_rec,
                              tint: sprite_cmp.tint,
                              rotation: sprite_cmp.rotation)
        end
      end
      if Input.show_debug
        FECS::Cmp::Tileset.each do |sprite_cmp|
          Rl.draw_texture_pro(texture: sprite_cmp.tileset.texture,
                              origin: sprite_cmp.origin,
                              source_rec: sprite_cmp.tileset.rec,
                              dest_rec: sprite_cmp.dest_rec,
                              tint: sprite_cmp.tint,
                              rotation: sprite_cmp.rotation)
        end
      end
  end,
  FelECS::Sys.new('DebugRenderHitbox') do
    scissor_path = Levels[CurrentLevel.level][:scissor_path].call((Rl.time/8) % 1)
    scissor_size = Levels[CurrentLevel.level][:scissor_size].call((Rl.time/8) % 1)
    Rl.scissor_mode(
      x: scissor_path[0],
      y: scissor_path[1],
      width: scissor_size[0],
      height: scissor_size[1]) do
        FECS::Cmp::Hitbox.each do |hitbox|
          #hitbox.rec.draw(color: BLACK)
          hitbox.rec.draw_lines(line_thick: 2, color: BLUE)
        end
      end
      if Input.show_debug
        faded_blue = Rl::Color.new(0,121,241,30)
        FECS::Cmp::Hitbox.each do |hitbox|
          #hitbox.rec.draw(color: BLACK)
          hitbox.rec.draw_lines(line_thick: 2, color: faded_blue)
        end
      end
      Rl::Rectangle.new(scissor_path[0], scissor_path[1], scissor_size[0], scissor_size[1]).draw_lines(line_thick: 3, color: RED)
  end
)

CurrentLevel.level = 0

FelECS::Order.sort(
  FECS::Sys::PlayerInput,
  FECS::Sys::PlayerMovement,
  FECS::Sys::Walls,
  FECS::Sys::Movement,
  FECS::Sys::ApplyPositionToSprite,
  FECS::Sys::ShowSpeed,
  FECS::Sys::Render,
  FECS::Sys::DebugRenderHitbox,
)
