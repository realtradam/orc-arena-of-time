FECS::Cmp.new('CurrentLevel', level: -1)

CurrentLevel = FECS::Cmp::CurrentLevel.new


Levels = []

# First level
level0 = {
  map_texture: {
    path: './assets/mapinit.png',
    source_rec: Rl::Rectangle.new(0,0,448,336),
    dest_rec: Rl::Rectangle.new(0,0,448*2,336*2)
  },
  overhang_texture: {
    path: './assets/mapinit-overhang.png',
    source_rec: Rl::Rectangle.new(0,0,140,220),
    dest_rec: Rl::Rectangle.new(0,0,140*2,220*2)
  },
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

# Second level
level1 = {
  map_texture: {
    path: './assets/map2.png',
    source_rec: Rl::Rectangle.new(0,0,480,368),
    dest_rec: Rl::Rectangle.new(0,0,480*2,368*2)
  },
  overhang_texture: {
    path: './assets/map2-overhang.png',
    source_rec: Rl::Rectangle.new(0,0,480,368),
    dest_rec: Rl::Rectangle.new(0,0,480*2,368*2)
  },
  player_spawn: Rl::Vector2.new(187,465),
  scissor_size: Path.new(
    lambda do |time|
      [250,
       250]
    end,
    lambda do |time|
      [250,
       250]
    end,
    lambda do |time|
      [250,
       250]
    end,
    lambda do |time|
      [250,
       250]
    end,
    lambda do |time|
      [250+(50*(-(Math.cos(Math::PI*time)-1)/2)),
       250-(80*(-(Math.cos(Math::PI*time)-1)/2))]
    end
  ),
  scissor_path: Path.new(
    lambda do |time|
      xstart = 206
      ystart = 509
      xstartnode = 204
      ystartnode = 390
      xendnode = 228
      yendnode = 336
      xend = 153
      yend = 268
      easeTime = time #1 - Math.cos((time * Math::PI) / 2)
      [Math.bezier([xstart, xstartnode, xendnode, xend],easeTime)-(250/2),
       Math.bezier([ystart, ystartnode, yendnode, yend],easeTime)-(250/2)]
    end,
    lambda do |time|
      xstart = 153
      ystart = 268
      xstartnode = 78
      ystartnode = 202
      xendnode = 205
      yendnode = 75
      xend = 273
      yend = 186
      [Math.bezier([xstart, xstartnode, xendnode, xend],time)-(250/2),
       Math.bezier([ystart, ystartnode, yendnode, yend],time)-(250/2)]
    end,
    lambda do |time|
      xstart = 273
      ystart = 186
      xstartnode = 342
      ystartnode = 298
      xendnode = 634
      yendnode = 153
      xend = 691
      yend = 209
      [Math.bezier([xstart, xstartnode, xendnode, xend],time)-(250/2),
       Math.bezier([ystart, ystartnode, yendnode, yend],time)-(250/2)]
    end,
    lambda do |time|
      xstart = 691
      ystart = 209
      xstartnode = 749
      ystartnode = 266
      xendnode = 716
      yendnode = 316
      xend = 717
      yend = 373
      [Math.bezier([xstart, xstartnode, xendnode, xend],time)-(250/2),
       Math.bezier([ystart, ystartnode, yendnode, yend],time)-(250/2)]
    end,
    lambda do |time|
      xstart = 717
      ystart = 373
      xstartnode = 718
      ystartnode = 429
      xendnode = 720
      yendnode = 482
      xend = 721
      yend = 532
      [Math.bezier([xstart, xstartnode, xendnode, xend],time)-((250+(50*(-(Math.cos(Math::PI*time)-1)/2)))/2),
       Math.bezier([ystart, ystartnode, yendnode, yend],time)-((250-(80*(-(Math.cos(Math::PI*time)-1)/2)))/2)]
    end
  ),
  scissor_speed: [1.0/2.0, 1.0/3.5, 1.0/6.0, 1.0/4.5, 1.0/3.0],
  timed_render: [],
  end_goal: [352*2,240*2,16*2,16*2],
  walls: [
    [178, 180, 60, 56],
    [684, 406, 72, 56],
    [628, 406, 56, 152],
    [618, 320, 80, 24],
    [266, 276, 32, 34],
    [244, 310, 312, 120],
    [468, 430, 88, 70],
    [262, 224, 20, 26],
    [886, 306, 42, 226],
    [756, 406, 56, 152],
    [566, 596, 64, 34],
    [808, 614, 16, 16],
    [566, 630, 276, 40],
    [842, 596, 66, 74],
    [874, 532, 54, 64],
    [76, 84, 106, 34],
    [182, 84, 52, 24],
    [234, 84, 76, 34],
    [310, 84, 448, 56],
    [758, 84, 128, 248],
    [742, 320, 80, 24],
    [298, 246, 386, 88],
    [166, 516, 84, 16],
    [298, 500, 268, 154],
    [90, 532, 208, 58],
    [90, 468, 28, 64],
    [106, 310, 64, 118],
    [50, 214, 56, 254],
    [50, 118, 68, 96]
  ],
  damage_areas: [
    #[10, 0,0, 100,100],
  ],
  damage_walls: [
    [1, 612, 186, 24, 34],
    [1, 422, 186, 24, 34],
    [1, 708, 154, 24, 34],
    [1, 516, 154, 24, 34],
    [1, 324, 154, 24, 34]
  ]
}

Levels.push(level0)
Levels.push(level1)

FECS::Sys.new('ConstructLevel') do
  FECS::Sys::DestroyLevel.call
  level = Levels[CurrentLevel.level]
  Player.component[FECS::Cmp::Hp].value = 4
  FECS::Cmp::Player.first.state = 'running'
  FECS::Cmp::Player.first.state_direction = 'right'
  PlayerTileset.texture = OrcTextures[3]

  MapTexture.texture = Rl::Texture.new(level[:map_texture][:path])
  MapTexture.source_rec = level[:map_texture][:source_rec]
  MapTexture.dest_rec = level[:map_texture][:dest_rec]

  OverhangTexture.texture = Rl::Texture.new(level[:overhang_texture][:path])
  OverhangTexture.source_rec = level[:overhang_texture][:source_rec]
  OverhangTexture.dest_rec = level[:overhang_texture][:dest_rec]

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
