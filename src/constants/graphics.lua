

gTextures = {
    ['badge'] = love.graphics.newImage('graphics/branding/badge.png'),
    ['bull'] = love.graphics.newImage('graphics/creatures/cow180x126.png'),
    ['blueTogaHuman'] = love.graphics.newImage('graphics/creatures/greek_citizen25x25.png'),
    ['sheep'] = love.graphics.newImage('graphics/creatures/sheep20x50.png'),
    ['house'] = love.graphics.newImage('graphics/map/house32x32.png'),
    --['tiles'] = love.graphics.newImage('graphics/tilesheet.png'),
    --['character-walk'] = love.graphics.newImage('graphics/character_walk.png'),
    --['character-pot-walk'] = love.graphics.newImage('graphics/character_pot_walk.png'),
}

gFrames = {
    --['bull'] = GenerateQuads(gTextures['bull'], CREATURE_DEFS['bull'].width, CREATURE_DEFS['bull'].height)
    ['blueTogaHuman'] = GenerateQuads(gTextures['blueTogaHuman'], CREATURE_DEFS['blueTogaHuman'].width, CREATURE_DEFS['blueTogaHuman'].height),
    ['sheep'] = GenerateQuads(gTextures['sheep'], CREATURE_DEFS['sheep'].width, CREATURE_DEFS['sheep'].height),
    ['house'] = GenerateQuads(gTextures['house'], GAME_OBJECT_DEFS['house'].width, GAME_OBJECT_DEFS['house'].height)
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
