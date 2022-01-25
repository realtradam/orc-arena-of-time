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
    [350,200, 050,350], 
    [470,470, 200,020]
  ],
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
