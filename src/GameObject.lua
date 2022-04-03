GameObject = Class{}

function GameObject:init(def, x, y)
    -- string identifying this object type
    self.type = def.type

    self.texture = def.texture
    self.frame = def.frame or 1

    -- whether it acts as an obstacle or not
    self.solid = def.solid

    -- dimensions
    self.x = x
    self.y = y
    self.width = def.width
    self.height = def.height

    -- default empty collision callback
    self.onCollide = function() end
end

function GameObject:update(dt)

end

function GameObject:render(adjacentOffsetX, adjacentOffsetY)
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.frame],
            self.x + adjacentOffsetX, self.y + adjacentOffsetY)
end

function GameObject:collides(target)
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
            self.y + self.height < target.y or self.y > target.y + target.height)
end

