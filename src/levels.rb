FECS::Cmp.new('CurrentLevel', level: 0)

@current_level = FECS::Cmp::CurrentLevel.new

@levels = []

level0 = {
  start: [0,0],
  scissor_dimensions: [300,300],
  #scissor_path: [],
  end: [40,40,10,10],
  walls: [
    [250,250,250,150],
    [350,200,50,350],
    [70,470,200,200],
    [350,200,50,350],
    [470,470,200,200]
  ],
}

@levels.push(level0)

FECS::Sys.new('ConstructLevel') do
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
FECS::Sys::ConstructLevel.trigger_when_is_changed(@current_level, :level)
FECS::Sys::DestroyLevel.trigger_when_is_changed(@current_level, :level)
