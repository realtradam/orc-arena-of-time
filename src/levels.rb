FECS::Cmp.new('CurrentLevel', level: -1)

CurrentLevel = FECS::Cmp::CurrentLevel.new

Levels = []

# First level
level0 = {
  player_spawn: Rl::Vector2.new(425,325),
  scissor_size: Path.new(
    lambda do |time|
      [250,
       250]
    end,
    lambda do |time|
      [250,
       250]
    end
  ),
  scissor_path: Path.new(
    lambda do |time|
      xstart = 494
      ystart = 355
      xstartnode = 827
      ystartnode = 431
      xendnode = 816
      yendnode = 354
      xend = 758
      yend = 152
      easeTime = 1 - Math.cos((time * Math::PI) / 2)
      [Math.bezier([xstart, xstartnode, xendnode, xend],easeTime)-(250/2),
       Math.bezier([ystart, ystartnode, yendnode, yend],easeTime)-(250/2)]
    end,
    lambda do |time|
      xstart = 758
      ystart = 152
      xstartnode = -44
      ystartnode = 56
      xendnode = 128
      yendnode = 556
      xend = 289
      yend = 533
      [Math.bezier([xstart, xstartnode, xendnode, xend],time)-(250/2),
       Math.bezier([ystart, ystartnode, yendnode, yend],time)-(250/2)]
    end
  ),
  scissor_speed: [1.0/7.0, 1.0/11.0],
  timed_render: [
    {
      path: './assets/mapinit-wasd.png',
      time_start: 0,
      time_end: -1,
      source_rec: Rl::Rectangle.new(0,0,284,204),
      dest_rec: Rl::Rectangle.new(0,0,284*2,204*2),
    },
    {
      path: './assets/mapinit-inside.png',
      time_start: 0.7,
      time_end: -1,
      source_rec: Rl::Rectangle.new(0,0,421,190),
      dest_rec: Rl::Rectangle.new(0,0,421*2,190*2),
    },
    {
      path: './assets/mapinit-ladder.png',
      time_start: 1.3,
      time_end: -1,
      source_rec: Rl::Rectangle.new(0,0,192,81),
      dest_rec: Rl::Rectangle.new(0,0,192*2,81*2),
    },
  ],
  end_goal: [160*2,272*2,16*2,16*2],
  walls: [
    [308,182,290,86],
    [598,182,118,124],
    [596,372,118,90],
    [714,372,12,90],
    [726,404,116,34],
    [842,84,12,354],
    [810,84,32,34],
    [214,84,596,24],
    [86,84,128,34],
    [518,128,20,26],
    [234,182,42,36],
    [74,84,12,130],
    [166,244,142,34],
    [74,244,48,34],
    [310,268,84,224],
    [310,492,52,38],
    [74,340,144,34],
    [262,340,48,34],
    [74,436,80,34],
    [198,436,112,34],
    [74,532,12,122],
    [86,596,64,34],
    [31,84,43,570],
    [86,629,320,25],
    [406,492,54,162],
    [394,438,202,54],
  ],
  damage_areas: [
    #[10, 0,0, 100,100],
  ],
  damage_walls: [
    #[10, 350,200, 050,350], 
  ]
}

Levels.push(level0)

FECS::Sys.new('ConstructLevel') do
  FECS::Sys::DestroyLevel.call
  level = Levels[CurrentLevel.level]
  Player.component[FECS::Cmp::Hp].value = 4
  FECS::Cmp::Player.first.state = 'running'
  FECS::Cmp::Player.first.state_direction = 'right'
  PlayerTileset.texture = OrcTextures[3]

  level[:walls].each do |wall|
    FECS::Cmp::Hitbox.new(
      rec: Rl::Rectangle.new(*wall),
      offset_x: 0,
      offset_y: 0
    )
  end
  level[:damage_areas].each do |dmg|
    FECS::Cmp::DamageHitbox.new(
      rec: Rl::Rectangle.new(*dmg[1..]),
      damage: dmg[0],
    )
  end
  level[:damage_walls].each do |dmg|
    FECS::Cmp::DamageHitbox.new(
      rec: Rl::Rectangle.new(dmg[1]-1, dmg[2]-1, dmg[3]+2, dmg[4]+2),
      damage: dmg[0],
    )
    FECS::Cmp::Hitbox.new(
      rec: Rl::Rectangle.new(*dmg[1..]),
    )
  end
  level[:timed_render].each do |rndr|
    FECS::Cmp::TimedRender.new(
      path: rndr[:path],
      texture: Rl::Texture.new(rndr[:path]),
      origin: Rl::Vector2.new(0,0),
      source_rec: rndr[:source_rec],
      dest_rec: rndr[:dest_rec],
      rotation: 0,
      tint: RED
    )
  end

  EndGoal.rec = Rl::Rectangle.new(
    level[:end_goal][0],
    level[:end_goal][1],
    level[:end_goal][2],
    level[:end_goal][3],
  )

  player_pos = Player.component[FECS::Cmp::Position]
  player_vel = Player.component[FECS::Cmp::Velocity]

  player_pos.x = level[:player_spawn].x
  player_pos.y = level[:player_spawn].y
  player_vel.x = 0
  player_vel.y = 0

  Player.component[FECS::Cmp::Player].moved = false

  FECS::Cmp::ScissorTime.first.time = 0
end

FECS::Sys.new('DestroyLevel') do
  FECS::Cmp::Hitbox.reverse_each do |hitbox_cmp|
    unless hitbox_cmp.entities.empty?
      next if hitbox_cmp.entity.equal? Player
    end
    hitbox_cmp.delete
  end

  FECS::Cmp::DamageHitbox.reverse_each do |hitbox_cmp|
    hitbox_cmp.delete
  end

  FECS::Cmp::TimedRender.reverse_each do |timedrender_cmp|
    timedrender_cmp.delete
  end
end

# changing the level will destroy the current level and set up the next one
FECS::Sys::ConstructLevel.trigger_when_is_changed(CurrentLevel, :level)
#FECS::Sys::DestroyLevel.trigger_when_is_changed(CurrentLevel, :level)
