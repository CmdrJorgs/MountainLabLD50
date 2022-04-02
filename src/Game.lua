Game = Class{}

function Game:init()

    -- current room we're operating in
    self.map = Map()

    -- love.graphics.translate values, only when shifting screens
    self.cameraX = 0
    self.cameraY = 0
end

function Game:update(dt)
    self.currentRoom:update(dt)
end

function Game:render()
    self.currentRoom:render()
end
