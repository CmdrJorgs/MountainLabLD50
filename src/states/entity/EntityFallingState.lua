EntityFallingState = Class{__includes = BaseState}

function EntityFallingState:init(entity)
    self.entity = entity

    self.entity:changeAnimation('fall-' .. self.entity.direction)
end

function EntityFallingState:enter(enterParams)
    -- TODO: keep any inertia from earlier
    self.dx = 0
    self.dy = 0
end

function EntityFallingState:update(dt)
    -- TODO: If the entity has been picked up and moved around a bit,
    --       they should fall some regardless of where they are dropped.
    --       For now, though, only drop if above ground height
    if self.entity.y > GROUND_HEIGHT then
        self.entity:changeState('idle')
        return
    end

    self.dy = self.dy + ENTITY_FALL_ACCEL * dt
    self.entity.x = self.entity.x + self.dx * dt
    self.entity.y = self.entity.y + self.dy * dt
end

function EntityFallingState:processAI(params, dt)

end

function EntityFallingState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY))

     --love.graphics.setColor(1, 0, 1, 1)
     --love.graphics.rectangle('line', self.entity.x, self.entity.y, self.entity.width, self.entity.height)
     --love.graphics.setColor(1, 1, 1, 1)
end
