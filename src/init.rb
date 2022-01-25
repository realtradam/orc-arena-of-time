GameName = 'Orc: Arena of Time'
Rl.init_window(900, 675, GameName)
Rl.init_audio_device if Rl.platform == 'web'

Rl.target_fps = 60

WHITE = Rl::Color.new(255,255,255,255)
BLACK = Rl::Color.new(0,0,0,255)
BLUE = Rl::Color.new(0, 121, 241, 255)
RED = Rl::Color.new(230, 41, 55, 255)
