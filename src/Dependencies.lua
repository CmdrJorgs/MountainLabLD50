--
-- libraries
--

Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/Animation'
require 'src/constants/constants'
--require 'src/Entity'
require 'src/StateMachine'
--require 'src/Util'

--require 'src/world/Doorway'
--require 'src/world/Dungeon'
--require 'src/world/Room'

require 'src/states/BaseState'
--
--require 'src/states/entity/EntityIdleState'
--require 'src/states/entity/EntityWalkState'
--
--require 'src/states/entity/projectile/ProjectileExplodeState'
--require 'src/states/entity/projectile/ProjectileMoveState'

--require 'src/states/game/GameOverState'
--require 'src/states/game/PlayState'
require 'src/states/game/StartState'
require 'src/states/game/IntroState'
require 'src/states/game/PlayState'
require 'src/states/game/GameOverState'

require 'src/volcano/Volcano'

require 'src/volcano/Volcano'

gTextures = {
    ['badge'] = love.graphics.newImage('graphics/branding/badge.png'),
    --['tiles'] = love.graphics.newImage('graphics/tilesheet.png'),
    --['character-walk'] = love.graphics.newImage('graphics/character_walk.png'),
    --['character-pot-walk'] = love.graphics.newImage('graphics/character_pot_walk.png'),
}

gFrames = {
    --['tiles'] = GenerateQuads(gTextures['tiles'], 16, 16),
    --['character-walk'] = GenerateQuads(gTextures['character-walk'], 16, 32),
    --['character-pot-walk'] = GenerateQuads(gTextures['character-pot-walk'], 16, 32),
}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 16),
    --['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    --['large'] = love.graphics.newFont('fonts/font.ttf', 32),
}

gSounds = {
    --['music'] = love.audio.newSource('sounds/music.mp3', 'stream'),
}
