EntityGrabbedState = Class{__includes = BaseState}

function EntityGrabbedState:init(entity)
    self.entity = entity

    self.entity:changeAnimation('grabbed-' .. self.entity.direction)

    -- TODO: do some fun dangling animations
end

function EntityGrabbedState:processAI(params, dt)
    
end

function EntityGrabbedState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY))

     --love.graphics.setColor(1, 0, 1, 1)
     --love.graphics.rectangle('line', self.entity.x, self.entity.y, self.entity.width, self.entity.height)
     --love.graphics.setColor(1, 1, 1, 1)
end
