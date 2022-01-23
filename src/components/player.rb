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
FECS::Cmp.new('Hp', value: 0)

@player = FECS::Ent.new(
  FECS::Cmp::Player.new,
  FECS::Cmp::Position.new,
  FECS::Cmp::Velocity.new,
  FECS::Cmp::Sprite.new(
    texture: Rl::Texture.new('./assets/lancelot_.png'),
    source_rect: Rl::Rectangle.new(0,0,24,24),
    dest_rect: Rl::Rectangle.new(0,0,48,48),
    origin: Rl::Vector2.new(0,0),
    tint: Rl::Color.new(255,255,255,255),
    rotation: 0
  ),
  FECS::Cmp::Movement.new(
    deceleration: 1.1,
    acceleration: 1.5,
    max_speed: 900,
  ),
)



