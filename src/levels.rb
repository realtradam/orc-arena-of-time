FECS::Cmp.new('CurrentLevel', level: -1)

CurrentLevel = FECS::Cmp::CurrentLevel.new

Levels = []

# First level
level0 = {
  player_spawn: Rl::Vector2.new(120,300),
  scissor_size: Path.new(
    lambda do |time|
      [300,
       300]
    end
  ),
  scissor_path: Path.new(
    lambda do |time|
      [Math.bezier([200, 200, 1183, 200],time)-150,
       Math.bezier([200, 1183, 200, 200],time)-150]
    end
  ),
  end_goal: Rl::Rectangle.new(40,40,10,10),
  walls: [
    [250,250, 250,150], 
    [350,200, 050,350], 
    [070,470, 200,200], 
    [470,470, 200,020],
  ],
  damage_areas: [
    [10, 0,0, 100,100],
  ],
  damage_walls: [
    [10, 350,200, 050,350], 
  ]
}

Levels.push(level0)

FECS::Sys.new('ConstructLevel') do
  FECS::Sys::DestroyLevel.call
  level = Levels[CurrentLevel.level]

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

  player_pos = @player.component[FECS::Cmp::Position]
  player_vel = @player.component[FECS::Cmp::Velocity]

  player_pos.x = level[:player_spawn].x
  player_pos.y = level[:player_spawn].y
  player_vel.x = 0
  player_vel.y = 0
  # use current_level component to know which level from levels array to load
  # create entities e.g. walls
  # set properties for scissor box
  # set properties for end goal zone
  # move player to start
end

FECS::Sys.new('DestroyLevel') do
  # delete all level specific entities and their components
  # dont delete entities that carry over to next level
end

# changing the level will destroy the current level and set up the next one
FECS::Sys::ConstructLevel.trigger_when_is_changed(CurrentLevel, :level)
#FECS::Sys::DestroyLevel.trigger_when_is_changed(CurrentLevel, :level)
