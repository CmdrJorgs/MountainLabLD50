CreatureGrabbedState = Class{__includes = BaseState}

function CreatureGrabbedState:init(entity)
    self.entity = entity

    self.entity:changeAnimation('grabbed-' .. 'down' )-- self.entity.direction)

    -- TODO: do some fun dangling animations
end

function CreatureGrabbedState:processAI(params, dt)
    
end

function CreatureGrabbedState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY))

     --love.graphics.setColor(1, 0, 1, 1)
     --love.graphics.rectangle('line', self.entity.x, self.entity.y, self.entity.width, self.entity.height)
     --love.graphics.setColor(1, 1, 1, 1)
end
