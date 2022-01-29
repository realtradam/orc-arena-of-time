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
      xstartnode = 800
      ystartnode = 440
      xendnode = 780
      yendnode = 354
      xend = 758
      yend = 152
      easeTime = time #1 - Math.cos((time * Math::PI) / 2)
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
      source_rec: Rl::Rectangle.new(0,0,450,325),
      dest_rec: Rl::Rectangle.new(0,0,450*2,325*2),
    },
    {
      path: './assets/mapinit-inside.png',
      time_start: 0.7,
      time_end: -1,
      source_rec: Rl::Rectangle.new(0,0,450,325),
      dest_rec: Rl::Rectangle.new(0,0,450*2,325*2),
    },
    {
      path: './assets/mapinit-ladder.png',
      time_start: 1.3,
      time_end: -1,
      source_rec: Rl::Rectangle.new(0,0,450,325),
      dest_rec: Rl::Rectangle.new(0,0,450*2,325*2),
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
  timed_render: [
    {
      path: './assets/map2-avoidspikes.png',
      time_start: 0.55,
      time_end: -1,
      source_rec: Rl::Rectangle.new(42,170,132,49),
      dest_rec: Rl::Rectangle.new(38*2,170*2,132*2,49*2),
    },
    {
      path: './assets/map2-justin.png',
      time_start: 2.50,
      time_end: -1,
      source_rec: Rl::Rectangle.new(168,133,84,25),
      dest_rec: Rl::Rectangle.new(168*2,133*2,84*2,25*2),
    },
    {
      path: './assets/map2-time.png',
      time_start: 2.9,
      time_end: -1,
      source_rec: Rl::Rectangle.new(273,131,40,22),
      dest_rec: Rl::Rectangle.new(273*2,131*2,40*2,22*2),
    },
  ],
  end_goal: [352*2,240*2,16*2,16*2],
  walls: [
    [178, 180, 60, 56],
    [684, 406, 72, 56],
    [628, 406, 56, 152],
    [618, 320, 80, 24],
    [266, 276, 32, 34],
    [244, 310, 312, 120],
    [468, 430, 88, 70],
    [250, 224, 44, 26], # barrel near water
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
    [1, 612, 186, 24, 54], # made spikes taller downward so player cant just walk below them
    [1, 422, 186, 24, 54],
    [1, 708, 154, 24, 34],
    [1, 516, 154, 24, 34],
    [1, 324, 154, 24, 34]
  ]
}


mazelevel= {
  map_texture: {
    path: './assets/Maze/floormaze.png',
    source_rec: Rl::Rectangle.new(0,0,480,368),
    dest_rec: Rl::Rectangle.new(0,0,480*2,368*2)
  },
  overhang_texture: {
    path: './assets/map2-overhang.png',
    source_rec: Rl::Rectangle.new(0,0,1,1),
    dest_rec: Rl::Rectangle.new(9999,9999,0,0)
  },
  player_spawn: Rl::Vector2.new(460,130),
  scissor_size: Path.new(
    lambda do |time|
      [200,
       607]
    end,
  ),
  scissor_path: Path.new(
    lambda do |time|
      #xstart = 206
      #ystart = 509
      #xstartnode = 204
      #ystartnode = 390
      #xendnode = 228
      #yendnode = 336
      #xend = 153
      #yend = 268
      #easeTime = time #1 - Math.cos((time * Math::PI) / 2)
      #[Math.bezier([xstart, xstartnode, xendnode, xend],easeTime)-(250/2),
      # Math.bezier([ystart, ystartnode, yendnode, yend],easeTime)-(250/2)]
      [(270 * -Math.sin(120 * (time))+510)-(200/2),
       367-(607/2)]
    end,
  ),
  scissor_speed: [1.0/200.0],
  timed_render: [
    {
      path: './assets/Maze/mazewalls.png',
      time_start: 0,
      time_end: -1,
      source_rec: Rl::Rectangle.new(0,0,900,650),
      dest_rec: Rl::Rectangle.new(0*2,0*2,900*2,650*2),
    },
    {
      path: './assets/Maze/invisiblemaze.png',
      time_start: 0,
      time_end: -1,
      source_rec: Rl::Rectangle.new(439,64,153,68),
      dest_rec: Rl::Rectangle.new(438,64,153,58),
    },
  ],
  end_goal: [452,516,24,24],
  walls: [
    [818,180,110,344],
    [842,524,86,42],
    [842,140,86,40],
    [170,42,758,100],
    [97,62,75,526],
    [172,566,732,54],
    [554,180,140,88],
    [554,268,44,10],
    [650,268,44,10],
    [554,278,12,64],
    [556,308,192,34],
    [468,374,184,56],
    [662,404,96,34],
    [746,308,12,130],
    #[652,404,10,26],
    #[650,430,12,38],
    [618,468,140,34],
    [650,502,12,64],
    [406,468,160,34],
    #[394,404,12,162],
    [298,404,96,34],
    [298,438,12,64],
    [234,468,64,34],
    [458,340,12,66],
    [246,340,212,34],
    [234,244,12,194],
    #[246,244,123,24],
    [426,244,44,34],
    [458,180,12,64],
    [172,180,286,34],
    [394,404,12,98],
    [234,244,108,32],
    [566,468,52,34]
  ],
  damage_areas: [
    #[10, 0,0, 100,100],
  ],
  damage_walls: [
    #[1, 612, 186, 24, 54], # made spikes taller downward so player cant just walk below them
    #[1, 422, 186, 24, 54],
    #[1, 708, 154, 24, 34],
    #[1, 516, 154, 24, 34],
    #[1, 324, 154, 24, 34]
  ]
}

splitlevel = {
  map_texture: {
    path: './assets/split.png',
    source_rec: Rl::Rectangle.new(0,0,450,337),
    dest_rec: Rl::Rectangle.new(-16,0,450*2,337*2)
  },
  overhang_texture: {
    path: './assets/split-overhang.png',
    source_rec: Rl::Rectangle.new(0,0,450,337),
    dest_rec: Rl::Rectangle.new(-16,0,450*2,337*2)
  },
  player_spawn: Rl::Vector2.new(434,140),
  scissor_size: Path.new(
    lambda do |time|
      [150+(728*(-(Math.cos(Math::PI*time)-1)/2)),
       150]
    end,
    lambda do |time|
      [878,
       150-(10*(-(Math.cos(Math::PI*time)-1)/2))]
    end,
    lambda do |time|
      [878-(693*(-(Math.cos(Math::PI*time)-1)/2)),
       140]
    end,
    lambda do |time|
      [185,
       140+(45*(-(Math.cos(Math::PI*time)-1)/2))]
    end,
  ),
  scissor_path: Path.new(
    lambda do |time|
      #[Math.interpolate(389,25,time),
      [373-(364*(-(Math.cos(Math::PI*time)-1)/2)),
       85]
    end,
    lambda do |time|
      [9,
       85+(417*(-(Math.cos(Math::PI*time)-1)/2))]
       #Math.interpolate(85,502,time)]
    end,
    lambda do |time|
      [9+(474*(-(Math.cos(Math::PI*time)-1)/2)),
       502]
      #[Math.interpolate(25,499,time),
      # Math.interpolate(502,274,time)]
    end,
    lambda do |time|
      [483,
       502-(228*(-(Math.cos(Math::PI*time)-1)/2))]
      #[Math.interpolate(25,499,time),
      # Math.interpolate(502,274,time)]
    end,
  ),
  scissor_speed: [1.0/2.0, 1.0/6.0, 1.0/6.0, 1.0/4.0],
  timed_render: [
    {
      path: './assets/text1.png',
      time_start: 0,
      time_end: 1.45,
      source_rec: Rl::Rectangle.new(284,255,442,66),
      dest_rec: Rl::Rectangle.new(284,255,442,66),
    },
    {
      path: './assets/text2.png',
      time_start: 1.45,
      time_end: -1,
      source_rec: Rl::Rectangle.new(284,255,442,66),
      dest_rec: Rl::Rectangle.new(284,255,442,66),
    },
  ],
  end_goal: [560,352,32,32],
  walls: [
    [26,598,844,24],
    [26,374,130,152],
    [156,374,128,56],
    [-12,76,40,546],
    [28,76,840,34],
    [164,110,24,32],
    [258,180,28,32],
    [98,212,604,88],
    [508,404,46,34],
    [598,404,46,34],
    [642,300,60,138],
    [610,438,92,86],
    [354,438,188,86],
    [226,468,128,56],
    [354,300,156,138],
    [868,76,39,546],
    [762,314,44,28],
    [822,500,46,34],
    [698,500,48,34],
  ],
  damage_areas: [
    #[10, 0,0, 100,100],
  ],
  damage_walls: [
    [1,756,380,56,64],
    [1,724,220,24,32],
    [1,820,220,24,32],
    [1,244,556,24,32],
    [1,372,556,24,32],
    [1,500,556,24,32],
    [1,692,556,24,32],
    [1,628,524,24,32],
    [1,436,524,24,32],
    [1,308,524,24,32],
  ]
}

lastlevel = {
  map_texture: {
    path: './assets/Ending/ending.png',
    source_rec: Rl::Rectangle.new(0,0,464,352),
    dest_rec: Rl::Rectangle.new(0,0,464*2,352*2)
  },
  overhang_texture: {
    path: './assets/Ending/ending-overhang.png',
    source_rec: Rl::Rectangle.new(0,0,252,155),
    dest_rec: Rl::Rectangle.new(0,0,252*2,155*2)
  },
  player_spawn: Rl::Vector2.new(465,557),
  scissor_size: Path.new(
    lambda do |time|
      [Math.interpolate(232.5,94.2,time),
       Math.interpolate(207.0,80.8,time)]
    end,
    lambda do |time|
      [Math.interpolate(94.2,682.2,time),
       Math.interpolate(80.8,357.2,time)]
    end,
  ),
  scissor_path: Path.new(
    lambda do |time|
      xstart = 465.8
      ystart = 558.9
      xstartnode = 465.8
      ystartnode = 558.9
      xendnode = 465.2
      yendnode = 381
      xend = 465.8
      yend = 319.7
      easeTime = time#1 - Math.cos((time * Math::PI) / 2)
      [Math.bezier([xstart, xstartnode, xendnode, xend],easeTime)-(Math.interpolate(232.5,94.2,time)/2),
       Math.bezier([ystart, ystartnode, yendnode, yend],easeTime)-(Math.interpolate(207.0,80.8,time)/2)]
    end,
    lambda do |time|
      xstart = 465.8
      ystart = 319.7
      xstartnode = 473.1
      ystartnode = 263.1
      xendnode = 168.7
      yendnode = 129.4
      xend = 479.9
      yend = 198.0

      [Math.bezier([xstart, xstartnode, xendnode, xend],time)-(Math.interpolate(94.2,682.2,time)/2),
       Math.bezier([ystart, ystartnode, yendnode, yend],time)-(Math.interpolate(80.8,357.2,time)/2)]
    end
  ),
  scissor_speed: [1.0/3.0, 1.0/3.0],
  timed_render: [],
  end_goal: [9999,9999,1,1],
  walls: [
    [106,308,320,167],
    [315,502,59,63],
    [311,475,125,27],
    [320,630,280,47],
    [313,565,49,65],
    [566,566,37,64],
    [554,468,49,98],
    [502,467,52,37],
    [502,344,152,125],
    [480,308,310,36],
    [426,308,22,34],
    [210,116,124,120],
    [626,116,124,120],
    [358,86,52,36],
    [65,52,117,256],
    [182,8,621,80],
    [778,88,77,220],

  ],
  damage_areas: [
    #[10, 0,0, 100,100],
  ],
  damage_walls: [
    #[10, 350,200, 050,350], 
  ]
}

Levels.push(level0)
Levels.push(level1)
Levels.push(mazelevel)
Levels.push(splitlevel)
Levels.push(lastlevel)

FECS::Sys.new('ConstructLevel') do
  FECS::Sys::DestroyLevel.call
  level = Levels[CurrentLevel.level]
  Player.component[FECS::Cmp::Hp].value = 4
  FECS::Cmp::Player.first.state = 'running'
  FECS::Cmp::Player.first.state_direction = 'right'
  PlayerTileset.texture = OrcTextures[3]
  FECS::Cmp::Player.first.moved = false

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
      tint: BkgWhite
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
