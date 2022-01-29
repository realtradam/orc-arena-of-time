FECS::Cmp.new('Player',
              moved: false,
              state: 'standing',
              state_direction: 'right')
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
FECS::Cmp.new('OverhangTexture',
              :texture,
              :origin,
              :source_rec,
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
              reset: false,
             )
FECS::Cmp.new('ScissorBox',
              :rec)
FECS::Cmp.new('ScissorTime',
              :time)
FECS::Cmp.new('TimedRender',
              :path,
              :texture,
              :origin,
              :source_rec,
              :dest_rec,
              :rotation,
              :tint)
FECS::Cmp.new('DamageHitbox',
              :rec,
              damage: 1,
              offset_x: 0,
              offset_y: 0)
FECS::Cmp.new('EndGoal', :rec)
# none: not transitioning
# into_init: change into starting transtition
# into: iterating over into transtition
#   shrink scissor
#   fade away background
# outof_init: load level change into ending transtition
#   embiggen scissor
#   fade in background
# outof: iterate over init
FECS::Cmp.new('Transition', :state, :rec, :time).new(
  state: 'none',
  rec: Rl::Rectangle.new(0,0,0,0),
  time: 0)

BkgWhite = Rl::Color.new(255,255,255,200)
PlayerBkgWhite = Rl::Color.new(255,200,200,150)
#ScissorPath = Path.new(
#  lambda do |time|
#    [Math.bezier([200, 200, 1183, 200],time)-150,
#     Math.bezier([200, 1183, 200, 200],time)-150]
#  end
#)

#FECS::Cmp::ScissorBox.new(rec: Rl::Rectangle.new(200,200,250,250))

ResetPrompt = Rl::Texture.new('./assets/resetprompt.png')
FECS::Cmp::ScissorTime.new(time: 0)
EndGoal = FECS::Cmp::EndGoal.new
Input = FECS::Cmp::Input.new
MapTexture = FECS::Cmp::Sprite.new
OverhangTexture = FECS::Cmp::OverhangTexture.new

OrcTextures = [
  Rl::Texture.new('./assets/orc_.png'),
  Rl::Texture.new('./assets/orc_two.png'),
  Rl::Texture.new('./assets/orc_three.png'),
  Rl::Texture.new('./assets/orc_four.png'),
]
PlayerTileset = Tileset.new(texture: OrcTextures[3])
PlayerAnimations = {
  standing_left: [], standing_right:[],
  running_left: [], running_right:[],
  turning_right: [], turning_left:[],
  damage_left: [], damage_right:[],
  dead_left: [], dead_right:[],
}
#lancelot.frames.push Rl::Rectangle.new((24 * x), 24*2, 24, 24)
4.times do |x|
  PlayerAnimations[:dead_right].push Rl::Rectangle.new((24 * x), 24*5, 24, 24)
end
4.times do |x|
  PlayerAnimations[:dead_left].push Rl::Rectangle.new((24 * x) + 24*4, 24*5, 24, 24)
end
4.times do |x|
  PlayerAnimations[:turning_left].push Rl::Rectangle.new((24 * x), 24*3, 24, 24)
end
4.times do |x|
  PlayerAnimations[:turning_right].push Rl::Rectangle.new((24 * x) + 24*4, 24*3, 24, 24)
end
4.times do |x|
  PlayerAnimations[:standing_right].push Rl::Rectangle.new((24 * x), 24*0, 24, 24)
end
4.times do |x|
  PlayerAnimations[:standing_left].push Rl::Rectangle.new((24 * x) + 24*4, 24*0, 24, 24)
end
4.times do |x|
  PlayerAnimations[:running_right].push Rl::Rectangle.new((24 * x), 24*2, 24, 24)
end
4.times do |x|
  PlayerAnimations[:running_left].push Rl::Rectangle.new((24 * x) + 24*4, 24*2, 24, 24)
end
4.times do |x|
  PlayerAnimations[:damage_right].push Rl::Rectangle.new((24 * x), 24*4, 24, 24)
end
4.times do |x|
  PlayerAnimations[:damage_left].push Rl::Rectangle.new((24 * x) + 24*4, 24*4, 24, 24)
end

PlayerTileset.frames = PlayerAnimations[:standing_right]

=begin
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


Player = FECS::Ent.new(
  FECS::Cmp::Player.new,
  FECS::Cmp::Hp.new(value: 4, max_invincible_time: 1.6),
  FECS::Cmp::Position.new(x: 120, y: 300),
  FECS::Cmp::Velocity.new,
  FECS::Cmp::Tileset.new(
    tileset: PlayerTileset,
    dest_rec: Rl::Rectangle.new(0,0,24*2,24*2),
    origin: Rl::Vector2.new(0,0),
    tint: Rl::Color.new(255,255,255,255),
    rotation: 0
  ),
  FECS::Cmp::Movement.new(
    deceleration: 1500,
    acceleration: 1500,
    max_speed: 300,
  ),
  FECS::Cmp::Hitbox.new(
    #rec: Rl::Rectangle.new(0,0,16*2,20*2),
    rec: Rl::Rectangle.new(0,0,10*2,8*2),
    offset_x: 7*2,
    offset_y: 16*2
  ),
)

Music = false # prevents a longjmp error in browsers
HurtSound = false 
IntroSound = false
DeathSound = false
Resetting = false
ScissorPath = 10000
ScissorSize = 1

#FECS::Scn.new('Common')
#FECS::Scn::Common.add(
FECS::Sys.new('Music') do
  #puts 'check web'
  if Rl.platform == 'web'
    #puts 'check mouse press'
    if Rl.mouse_button_pressed? 0
      #puts 'check if device redy'
      unless Rl.audio_device_ready?
        #puts 'load device'
        Rl.init_audio_device
        #puts 'set master'
        Rl.set_master_volume(0.5)
      end
    end
    #puts 'check if sound exists'
    next unless Rl.audio_device_ready?
    if !Music
      #puts 'load it'
      Music = Rl::Sound.new('./assets/music.ogg')
      HurtSound = Rl::Sound.new('../assets/hurt.wav')
      IntroSound = Rl::Sound.new('../assets/intro.ogg')
      DeathSound = Rl::Sound.new('../assets/death.ogg')
      #puts 'set volume'
      #puts 'check if its playing'
    elsif !Music.playing?
      #puts 'play it'
      Music.play
      Music.volume = 0.09
    end
  end
  #if Rl.key_pressed? 87
  #end
  #unless Music.playing?
  #  Music.play
  #end
end
FECS::Sys.new('IntroSound') do
  button_clicked = FECS::Cmp::Button.first.clicked
  if Rl.audio_device_ready? && IntroSound && !IntroSoundPlayed && button_clicked
    IntroSoundPlayed = true
    IntroSound.play
  end
end
FECS::Sys.new('Transition') do
  cmp = FECS::Cmp::Transition.first
  #cmp.state = 'into_init' if Rl.mouse_button_pressed? 0
  next if cmp.state == 'none'
  if cmp.state == 'into_init'
    FECS::Cmp::Player.first.moved = false
    cmp.state = 'into'
    cmp.time = 0
  end
  if cmp.state == 'into'
    cmp.time += (1.0/60.0)#Rl.frame_time
    if cmp.time >= 1
      cmp.state = 'outof_init'
      cmp.time = 1
    end
    #ScissorPath = [(cmp.time**3),
    #               (cmp.time**3)]
    easeTime = (1 - cmp.time) ** 3

    n1 = 7.5625
    d1 = 2.75
    time = (cmp.time)

    if time < (1 / d1)
      easeTime = n1 * time * time
    elsif time < (2 / d1)
      easeTime = n1 * (time -= (1.5 / d1)) * time + 0.75
    elsif time < (2.5 / d1)
      easeTime = n1 * (time -= (2.25 / d1)) * time + 0.9375
    else
      easeTime = n1 * (time -= (2.625 / d1)) * time + 0.984375
    end
    easeTime = 1 - easeTime

    newsize = [easeTime * ScissorSize[0],
               easeTime * ScissorSize[1]]
    ScissorPath = [
      ScissorPath[0] + ((ScissorSize[0] - newsize[0])/2),
      ScissorPath[1] + ((ScissorSize[1] - newsize[1])/2)
    ]
    ScissorSize = newsize
  elsif cmp.state == 'outof_init'
    cmp.state = 'outof'
    cmp.time = -0.5
  end
  if cmp.state == 'outof'
    cmp.time += (1.0/60.0)#Rl.frame_time
    if cmp.time >= 1
      cmp.state = 'none'
      cmp.time = 1
    end
    c1 = 1.70158
    c3 = c1 + 1
    easeTime = [1 + c3 * ((cmp.time - 1)**3) + c1 * ((cmp.time - 1)**2),0].max
    newsize = [easeTime * ScissorSize[0],
               easeTime * ScissorSize[1]]
    ScissorPath = [
      ScissorPath[0] + ((ScissorSize[0] - newsize[0])/2),
      ScissorPath[1] + ((ScissorSize[1] - newsize[1])/2)
    ]
    ScissorSize = newsize
  end
end


FECS::Scn.new('Menu')
FECS::Scn::Menu.add(
  FECS::Sys.new('Button') do
    FECS::Cmp::Button.each do |button|
      ent = button.entity
      sprite = ent.component[FECS::Cmp::Sprite]
      hitbox = ent.component[FECS::Cmp::Hitbox]
      trans = FECS::Cmp::Transition.first
      if button.clicked
        sprite.texture = button.pressed_texture
      else
        sprite.texture = button.unpressed_texture
      end
      if hitbox.rec.collide_with_point?(Rl.mouse_position) && trans.state == 'none'
        if Rl.mouse_button_down? 0
          button.clicked = true
        elsif Rl.mouse_button_up?(0) && button.clicked
          button.clicked = false
          #FECS::Sys::DestroyTitleScreen.call
          trans.state = 'into_init'
        end
      else
        button.clicked = false
      end
      if trans.state == 'outof_init'
        IntroSound.play if Rl.platform == 'web'
        FECS::Sys::DestroyTitleScreen.call
      end
    end
  end,
  FECS::Sys.new('ScissorMenu') do
    ScissorPath = [325,212]
    ScissorSize = [250,250]
  end,
  FECS::Sys.new('RenderMenu') do
    scissor_path = ScissorPath
    scissor_size = ScissorSize
    Rl::Rectangle.new(scissor_path[0], scissor_path[1], scissor_size[0], scissor_size[1]).draw(color: Rl::Color.new(52,52,64,255))
    Rl.scissor_mode(
      x: scissor_path[0],
      y: scissor_path[1],
      width: scissor_size[0],
      height: scissor_size[1]) do
        FECS::Cmp::Sprite.each do |sprite_cmp|
          Rl.draw_texture_pro(texture: sprite_cmp.texture,
                              origin: Rl::Vector2.new(0,0),
                              source_rec: sprite_cmp.source_rec,
                              dest_rec: sprite_cmp.dest_rec)
        end
      end
  end,
  FECS::Sys.new('ApplyPositionToSpriteMenu') do
    FECS::Cmp::Position.each do |position_cmp|
      ent = position_cmp.entity
      next if ent.components[FECS::Cmp::Sprite].nil?
      sprite = ent.component[FECS::Cmp::Sprite]
      hitbox = ent.component[FECS::Cmp::Hitbox]
      sprite.dest_rec.x = position_cmp.x
      sprite.dest_rec.y = position_cmp.y
      hitbox.rec.x = position_cmp.x + hitbox.offset_x
      hitbox.rec.y = position_cmp.y + hitbox.offset_y
    end
  end,
)

FECS::Scn.new('Play')
FECS::Scn::Play.add(
  FECS::Sys.new('PlayerInput') do
    Input.move_up = Rl.key_down? 87 # W
    Input.move_left = Rl.key_down? 65 # A
    Input.move_down = Rl.key_down? 83 # S
    Input.move_right = Rl.key_down? 68 # D
    Input.show_debug = Rl.key_down? 80 # P
    Input.reset = Rl.key_down? 82 # R
    #if Rl.key_pressed? 82
    #FECS::Sys::ConstructLevel.call
    #end
  end,
  FECS::Sys.new('PlayerReset') do
    trans = FECS::Cmp::Transition.first
    if Input.reset && trans.state == 'none'
      Resetting = true
      FECS::Cmp::Transition.first.state = 'into_init'
    elsif Resetting && trans.state == 'outof_init'
      FECS::Sys::ConstructLevel.call
    end
  end,
  FECS::Sys.new('PlayerMovement') do
    ent = FECS::Cmp::Player.first.entity
    velocity_cmp = ent.component[FECS::Cmp::Velocity]
    #velocity_cmp.x = 0
    #velocity_cmp.y = 0
    input_x = 0
    input_y = 0
    movement_cmp = ent.component[FECS::Cmp::Movement]
    unless (FECS::Cmp::Player.first.state == 'damaged') || (ent.component[FECS::Cmp::Hp].value <= 0) || (FECS::Cmp::Transition.first.state != 'none')
      if Input.move_up
        input_y -= 1.0
        ent.component[FECS::Cmp::Player].moved = true
      end
      if Input.move_down
        input_y += 1.0
        ent.component[FECS::Cmp::Player].moved = true
      end
      if Input.move_left
        input_x -= 1.0
        ent.component[FECS::Cmp::Player].moved = true
      end
      if Input.move_right
        input_x += 1.0
        ent.component[FECS::Cmp::Player].moved = true
      end
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

    #MovingHitbox1.rec.x = (Math.sin(Rl.time) * 300) + 250 + 50
    #MovingHitbox2.rec.x = (Math.sin(Rl.time) * 300) + 150 + 50

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

    next unless player.component[FECS::Cmp::Player].moved
    next if hp_cmp.value <= 0
    if hp_cmp.invincible_timer >= 0
      hp_cmp.invincible_timer -= Rl.frame_time
    else
      scissor_path = ScissorPath #Levels[CurrentLevel.level][:scissor_path].call(FECS::Cmp::ScissorTime.first.time)
      scissor_size = ScissorSize #Levels[CurrentLevel.level][:scissor_size].call(FECS::Cmp::ScissorTime.first.time)
      if Rl::Rectangle.new(scissor_path[0], scissor_path[1], scissor_size[0], scissor_size[1]).collide_with_rec?(player_hitbox.rec)
        FECS::Cmp::DamageHitbox.each do |dmg_hitbox|
          if player_hitbox.rec.collide_with_rec?(dmg_hitbox.rec) 
            FECS::Cmp::Player.first.state = 'set_damaged'
            hp_cmp.value -= dmg_hitbox.damage
            #puts "oof -#{dmg_hitbox.damage} hp"
            #puts "hp: #{hp_cmp.value}"
            if hp_cmp.value <= 0
              FECS::Cmp::Player.first.state = 'set_dead'
              #puts 'ded'
              DeathSound.play if Rl.platform == 'web'
            else
              hp_cmp.invincible_timer = hp_cmp.max_invincible_time
              if Rl.platform == 'web'
                HurtSound.play
                HurtSound.volume = 0.45
              end
            end
            break
          end
        end
      else
        FECS::Cmp::Player.first.state = 'set_damaged'
        hp_cmp.value -= 1
        #puts "oof -#{1} hp"
        #puts "hp: #{hp_cmp.value}"
        if hp_cmp.value <= 0
          FECS::Cmp::Player.first.state = 'set_dead'
          #puts 'ded'
          DeathSound.play if Rl.platform == 'web'
        else
          hp_cmp.invincible_timer = hp_cmp.max_invincible_time
          if Rl.platform == 'web'
            HurtSound.play
            HurtSound.volume = 0.45
          end
        end
      end
    end
  end,
  FECS::Sys.new('AnimationStateMachine') do
    player = FECS::Cmp::Player.first
    ent = player.entity
    tileset_cmp = ent.component[FECS::Cmp::Tileset]
    y_vel = ent.component[FECS::Cmp::Velocity].y
    x_vel = ent.component[FECS::Cmp::Velocity].x
    velocity_mag = Math.sqrt((x_vel**2) + (y_vel**2))
    # if took damaged
    if player.state == 'set_dead'
      player.state = 'dead_damaged'
      if player.state_direction == 'right'
        PlayerTileset.frames = PlayerAnimations[:damage_right]
      else
        PlayerTileset.frames = PlayerAnimations[:damage_left]
      end
      movement = ent.component[FECS::Cmp::Movement]
      unless y_vel.zero?
        ent.component[FECS::Cmp::Velocity].y = -(y_vel / velocity_mag) * (movement.max_speed)
      end
      unless x_vel.zero?
        ent.component[FECS::Cmp::Velocity].x = -(x_vel / velocity_mag) * (movement.max_speed)
      end
      PlayerTileset.frame = 0
    end
    if player.state == 'dead_damaged'
      anim_speed = 8
      if tileset_cmp.tileset.frame + (anim_speed * Rl.frame_time) <= PlayerTileset.frames.length
        PlayerTileset.step(anim_speed * Rl.frame_time)
      else
        if player.state_direction == 'right'
          PlayerTileset.frames = PlayerAnimations[:dead_right]
        else
          PlayerTileset.frames = PlayerAnimations[:dead_left]
        end
        player.state = 'dead'
        PlayerTileset.frame = 0
      end
    elsif player.state == 'dead'
      anim_speed = 6
      if tileset_cmp.tileset.frame + (anim_speed * Rl.frame_time) <= PlayerTileset.frames.length
        PlayerTileset.step(anim_speed * Rl.frame_time)
      else
        PlayerTileset.frame = PlayerTileset.frames.length - 0.1
      end
    else
      if player.state == 'set_damaged'
        player.state = 'damaged'
        PlayerTileset.frame = 0
        if player.state_direction == 'right'
          PlayerTileset.frames = PlayerAnimations[:damage_right]
        else
          PlayerTileset.frames = PlayerAnimations[:damage_left]
        end
        movement = ent.component[FECS::Cmp::Movement]
        unless y_vel.zero?
          ent.component[FECS::Cmp::Velocity].y = -(y_vel / velocity_mag) * (movement.max_speed)
        end
        unless x_vel.zero?
          ent.component[FECS::Cmp::Velocity].x = -(x_vel / velocity_mag) * (movement.max_speed)
        end
      end
      if player.state == 'damaged'
        iter_speed = 8
        if tileset_cmp.tileset.frame + (iter_speed * Rl.frame_time) > PlayerTileset.frames.length
          if player.state_direction == 'right'
            #       change to standing
            player.state = 'standing'
            PlayerTileset.frames = PlayerAnimations[:standing_right]
          else
            #       change to standing
            player.state = 'standing'
            PlayerTileset.frames = PlayerAnimations[:standing_left]
          end
          PlayerTileset.texture = OrcTextures[
            [
              [ent.component[FECS::Cmp::Hp].value - 1,
               OrcTextures.length - 1
              ].min,
              0
            ].max
          ]
          #       reset frame
          PlayerTileset.frame = 0
          #     else
        else
          #       increment
          tileset_cmp.tileset.step(iter_speed * Rl.frame_time)
          #     end
        end

      else
        #   if velocity opposite of direction
        if ((x_vel.positive?) && (player.state_direction == 'left')) || ((x_vel.negative?) && (player.state_direction == 'right'))
          #     change to changing_direction
          if player.state == 'changing_direction'
            PlayerTileset.frame = 1
          else
            player.state = 'changing_direction'
            #     reset frame
            PlayerTileset.frame = 0
          end
          if player.state_direction == 'right'
            player.state_direction = 'left'
            PlayerTileset.frames = PlayerAnimations[:turning_left]
          else
            player.state_direction = 'right'
            PlayerTileset.frames = PlayerAnimations[:turning_right]
          end
          #   elsif changing direction
        elsif player.state == 'changing_direction'
          #     if reached end of frames
          turn_speed = 8
          if tileset_cmp.tileset.frame + (turn_speed * Rl.frame_time) > PlayerTileset.frames.length
            if player.state_direction == 'right'
              #       change to standing
              player.state = 'standing'
              PlayerTileset.frames = PlayerAnimations[:standing_right]
            else
              #       change to standing
              player.state = 'standing'
              PlayerTileset.frames = PlayerAnimations[:standing_left]
            end
            #       reset frame
            PlayerTileset.frame = 0
            #     else
          else
            #       increment
            tileset_cmp.tileset.step(turn_speed * Rl.frame_time)
            #     end
          end
          #   elsif standing
        elsif player.state == 'standing'
          #     if velocity
          if velocity_mag >= 0.1
            #       change to running
            player.state = 'running'
            if player.state_direction == 'right'
              PlayerTileset.frames = PlayerAnimations[:running_right]
            else
              PlayerTileset.frames = PlayerAnimations[:running_left]
            end
            PlayerTileset.frame = 0
            #     else
          else
            #       increment frame
            #player.state_frame += 
            tileset_cmp.tileset.step(5.0 * Rl.frame_time)
            #player.state_frame %= tileset.frames.length
            #     end
          end
          #   elsif running
        elsif player.state == 'running'
          #     if no velocity
          if velocity_mag < 0.1
            #       change to standing
            player.state = 'standing'
            if player.state_direction == 'right'
              PlayerTileset.frames = PlayerAnimations[:standing_right]
            else
              PlayerTileset.frames = PlayerAnimations[:standing_left]
            end
            PlayerTileset.frame = 0
            #     else
          else
            #       increment frame
            tileset_cmp.tileset.step((velocity_mag*0.04) * Rl.frame_time)
            #     end
          end
          #   end
        end
      end
      # end
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
      if sprite
        sprite.dest_rec.x = position_cmp.x
        sprite.dest_rec.y = position_cmp.y
        hitbox.rec.x = position_cmp.x + hitbox.offset_x
        hitbox.rec.y = position_cmp.y + hitbox.offset_y
      end
    end
  end,
  FECS::Sys.new('CheckEndGoal') do
    player_hitbox = Player.component[FECS::Cmp::Hitbox].rec
    if EndGoal.rec.collide_with_rec? player_hitbox
      puts 'you\'re winner'
      trans = FECS::Cmp::Transition.first
      if trans.state == 'none'
        trans.state = 'into_init'
        Player.component[FECS::Cmp::Velocity].x = 0
        Player.component[FECS::Cmp::Velocity].x = 0
      elsif trans.state == 'outof_init'
        CurrentLevel.level += 1
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
      Rl.draw_text(text: "path time: #{"%.2f" % FECS::Cmp::ScissorTime.first.time}", x: 10, y: 130, font_size: 30, color: WHITE)
    end
  end,
  FECS::Sys.new('Scissor') do
    player_ent = FECS::Cmp::Player.first.entity
    if player_ent.component[FECS::Cmp::Player].moved && (player_ent.component[FECS::Cmp::Hp].value > 0)
      if FECS::Cmp::ScissorTime.first.time < Levels[CurrentLevel.level][:scissor_path].paths.length - 0.00001
        FECS::Cmp::ScissorTime.first.time += Rl.frame_time * Levels[CurrentLevel.level][:scissor_speed][FECS::Cmp::ScissorTime.first.time.to_i]
        if FECS::Cmp::ScissorTime.first.time >= Levels[CurrentLevel.level][:scissor_path].paths.length - 0.00001
          FECS::Cmp::ScissorTime.first.time = Levels[CurrentLevel.level][:scissor_path].paths.length - 0.00001
        end
      else
        FECS::Cmp::ScissorTime.first.time = Levels[CurrentLevel.level][:scissor_path].paths.length - 0.00001
      end
    end
    ScissorPath = Levels[CurrentLevel.level][:scissor_path].call(FECS::Cmp::ScissorTime.first.time)
    ScissorSize = Levels[CurrentLevel.level][:scissor_size].call(FECS::Cmp::ScissorTime.first.time)
  end,
  FECS::Sys.new('TimedRender') do
    # check level > timed_render
    # if it is time > check if texture exists
    #   create if not
    # end
    # render it
    level = Levels[CurrentLevel.level]
    time = FECS::Cmp::ScissorTime.first.time
    level[:timed_render].each do |timed_render|
      if time >= timed_render[:time_start]
        if (time < timed_render[:time_end]) || (timed_render[:time_end] < 0)
          result = FECS::Cmp::TimedRender.find do |n|
            n.path.equal? timed_render[:path]
          end
          Rl.draw_texture_pro(texture: result.texture,
                              origin: Rl::Vector2.new(0,0),
                              source_rec: result.source_rec,
                              dest_rec: result.dest_rec,
                              tint: BkgWhite)
        end
      end
    end
  end,
  FECS::Sys.new('Render') do
    scissor_path = ScissorPath #Levels[CurrentLevel.level][:scissor_path].call(FECS::Cmp::ScissorTime.first.time)
    scissor_size = ScissorSize #Levels[CurrentLevel.level][:scissor_size].call(FECS::Cmp::ScissorTime.first.time)
    Rl::Rectangle.new(scissor_path[0], scissor_path[1], scissor_size[0], scissor_size[1]).draw(color: Rl::Color.new(52,52,64,255))
    player = FECS::Cmp::Player.first.entity
    y_vel = player.component[FECS::Cmp::Velocity].y.abs
    x_vel = player.component[FECS::Cmp::Velocity].x.abs
    vel = Math.sqrt(x_vel**2 + y_vel**2)
    FECS::Cmp::Tileset.each do |sprite_cmp|
      Rl.draw_texture_pro(texture: sprite_cmp.tileset.texture,
                          origin: sprite_cmp.origin,
                          source_rec: sprite_cmp.tileset.rec,
                          dest_rec: sprite_cmp.dest_rec,
                          tint: PlayerBkgWhite,
                          rotation: sprite_cmp.rotation)
    end
    Rl.scissor_mode(
      x: scissor_path[0],
      y: scissor_path[1],
      width: scissor_size[0],
      height: scissor_size[1]) do
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
        FECS::Cmp::OverhangTexture.each do |sprite_cmp|
          Rl.draw_texture_pro(texture: sprite_cmp.texture,
                              origin: Rl::Vector2.new(0,0),
                              source_rec: sprite_cmp.source_rec,
                              dest_rec: sprite_cmp.dest_rec)

        end
        if Input.show_debug
          Rl.draw_text(text: "speed: #{"%.1f" % vel}", x: 10, y: 10, font_size: 30, color: BLACK)
          Rl.draw_text(text: "fps: #{Rl.fps}", x: 10, y: 40, font_size: 30, color: BLACK)
          Rl.draw_text(text: "mouse x: #{Rl.mouse_x}", x: 10, y: 70, font_size: 30, color: BLACK)
          Rl.draw_text(text: "mouse y: #{Rl.mouse_y}", x: 10, y: 100, font_size: 30, color: BLACK)
          Rl.draw_text(text: "path time: #{"%.2f" % FECS::Cmp::ScissorTime.first.time}", x: 10, y: 130, font_size: 30, color: BLACK)
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
    scissor_path = ScissorPath #Levels[CurrentLevel.level][:scissor_path].call(FECS::Cmp::ScissorTime.first.time)
    scissor_size = ScissorSize #Levels[CurrentLevel.level][:scissor_size].call(FECS::Cmp::ScissorTime.first.time)
    if Input.show_debug
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
    end
    if Input.show_debug
      faded_blue = Rl::Color.new(0,121,241,30)
      FECS::Cmp::Hitbox.each do |hitbox|
        #hitbox.rec.draw(color: BLACK)
        hitbox.rec.draw_lines(line_thick: 2, color: faded_blue)
      end
    end
    if FECS::Cmp::Transition.first.state == 'none'
      Rl::Rectangle.new(scissor_path[0]-1, scissor_path[1]-1, scissor_size[0]+1, scissor_size[1]+1).draw_lines(line_thick: 3, color: RED)
    else
      Rl::Rectangle.new(scissor_path[0]-1, scissor_path[1]-1, scissor_size[0]+1, scissor_size[1]+1).draw_lines(line_thick: 3, color: BLACK)
    end
  end
)
FECS::Sys.new('SetBackgroundColor') do
  trans = FECS::Cmp::Transition.first
  if trans.state == 'none'
    BkgWhite.a = 150
    PlayerBkgWhite.a = 100
  elsif trans.state == 'into'
    BkgWhite.a = [Math.interpolate(150,-50,[trans.time,0].max),0].max
    PlayerBkgWhite.a = [Math.interpolate(100,-50,[trans.time,0].max),0].max
  elsif trans.state == 'outof'
    BkgWhite.a = [Math.interpolate(-50,150,[trans.time,0].max),0].max
    PlayerBkgWhite.a = [Math.interpolate(-50,100,[trans.time,0].max),0].max
  end
end

FECS::Sys.new('RenderResetText') do
  trans = FECS::Cmp::Transition.first
  if Player.component[FECS::Cmp::Hp].value <= 0
    if trans.state == 'into'
      Rl.draw_texture_pro(texture: ResetPrompt,
                          origin: Rl::Vector2.new(0,0),
                          source_rec: Rl::Rectangle.new(0,0,900,650),
                          dest_rec: Rl::Rectangle.new(0,0,900,650),
                          tint: Rl::Color.new(255,255,255,Math.interpolate(255,0,trans.time)))
    elsif trans.state == 'none'
      Rl.draw_texture_pro(texture: ResetPrompt,
                          origin: Rl::Vector2.new(0,0),
                          source_rec: Rl::Rectangle.new(0,0,900,650),
                          dest_rec: Rl::Rectangle.new(0,0,900,650),
                          tint: WHITE)

    end
  end
end

#CurrentLevel.level = 0
FECS::Sys::ConstructTitleScreen.call
FECS::Scn::Menu.add(
  FECS::Sys::Transition,
  #FECS::Sys::IntroSound,
  FECS::Sys::Music,
)
FECS::Scn::Play.add(
  FECS::Sys::Transition,
  FECS::Sys::Music,
  FECS::Sys::SetBackgroundColor,
  FECS::Sys::RenderResetText,
)
FECS::Stg.add(
  FECS::Scn::Menu,
)

FelECS::Order.sort(
  #FECS::Sys::IntroSound,
  FECS::Sys::Music,
  FECS::Sys::PlayerInput,
  FECS::Sys::PlayerReset,
  FECS::Sys::Button,
  FECS::Sys::ScissorMenu,
  FECS::Sys::Scissor,
  FECS::Sys::Transition,
  FECS::Sys::RenderMenu,
  FECS::Sys::PlayerMovement,
  FECS::Sys::Damage,
  FECS::Sys::Walls,
  FECS::Sys::Movement,
  FECS::Sys::AnimationStateMachine,
  FECS::Sys::ApplyPositionToSprite,
  # Render debug text
  FECS::Sys::ShowSpeed,
  # Renders things for levels outside of scissor
  FECS::Sys::TimedRender,
  # Renders any other game element
  FECS::Sys::Render,
  # Renders the debug hitboxes
  FECS::Sys::DebugRenderHitbox,
  FECS::Sys::RenderResetText,
)
