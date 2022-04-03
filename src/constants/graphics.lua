

gTextures = {
    ['badge'] = love.graphics.newImage('graphics/branding/badge.png'),
    ['bull'] = love.graphics.newImage('graphics/creatures/cow180x126.png'),
    ['blueTogaHuman'] = love.graphics.newImage('graphics/creatures/blue_toga_human.png'),
    ['whiteTogaHuman'] = love.graphics.newImage('graphics/creatures/white_toga_human46x22.png'),
    ['cursor'] = love.graphics.newImage('graphics/cursor/cursor16x16.png'),
    ['sheep'] = love.graphics.newImage('graphics/creatures/sheep20x50.png'),
    ['house'] = love.graphics.newImage('graphics/map/house32x32.png'),
    ['volcano'] = love.graphics.newImage('graphics/map/volcano440x220.png'),
    ['goat'] = love.graphics.newImage('graphics/creatures/goat20x19.png'),
    ['bird'] = love.graphics.newImage('graphics/creatures/bird30x28.png'),
    --['greekCitizen'] = love.graphics.newImage('graphics/creatures/greek_citizen25x25.png'),
    --['character-walk'] = love.graphics.newImage('graphics/character_walk.png'),
    --['character-pot-walk'] = love.graphics.newImage('graphics/character_pot_walk.png'),
}

gFrames = {
    --['bull'] = GenerateQuads(gTextures['bull'], CREATURE_DEFS['bull'].width, CREATURE_DEFS['bull'].height)
    ['blueTogaHuman'] = GenerateQuads(gTextures['blueTogaHuman'], CREATURE_DEFS['blueTogaHuman'].width, CREATURE_DEFS['blueTogaHuman'].height),
    ['whiteTogaHuman'] = GenerateQuads(gTextures['whiteTogaHuman'], CREATURE_DEFS['whiteTogaHuman'].width, CREATURE_DEFS['whiteTogaHuman'].height),
    ['cursor'] = GenerateQuads(gTextures['cursor'], 16, 16),
    ['sheep'] = GenerateQuads(gTextures['sheep'], CREATURE_DEFS['sheep'].width, CREATURE_DEFS['sheep'].height),
    ['house'] = GenerateQuads(gTextures['house'], GAME_OBJECT_DEFS['house'].width, GAME_OBJECT_DEFS['house'].height),
    ['volcano'] = GenerateQuads(gTextures['volcano'], 440, 200),
    ['goat'] = GenerateQuads(gTextures['goat'], CREATURE_DEFS['goat'].width, CREATURE_DEFS['goat'].height),
    ['bird'] = GenerateQuads(gTextures['bird'], CREATURE_DEFS['bird'].width, CREATURE_DEFS['bird'].height),
    --['greekCitizen'] = GenerateQuads(gTextures['greekCitizen'], CREATURE_DEFS['greekCitizen'].width, CREATURE_DEFS['greekCitizen'].height)
    --['tiles'] = GenerateQuads(gTextures['tiles'], 16, 16),
    --['character-walk'] = GenerateQuads(gTextures['character-walk'], 16, 32),
    --['character-pot-walk'] = GenerateQuads(gTextures['character-pot-walk'], 16, 32),
}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 16),
    --['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    --['large'] = love.graphics.newFont('fonts/font.ttf', 32),
}
