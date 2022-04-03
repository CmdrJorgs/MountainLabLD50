CreatureIdleState = Class{__includes = BaseState}

function CreatureIdleState:init(creature)
    self.creature = creature

    --self.creature:changeAnimation('idle-' .. self.creature.direction)
    self.creature:changeAnimation('idle-' .. 'down') -- todo when we have the sprites for each direction remove this

    -- used for AI waiting
    self.waitDuration = 0
    self.waitTimer = 0
end

function CreatureIdleState:processAI(params, dt)
    if self.waitDuration == 0 then
        self.waitDuration = math.random(5)
    else
        self.waitTimer = self.waitTimer + dt

        if self.waitTimer > self.waitDuration then
            self.creature:changeState('walk')
        end
    end
end

function CreatureIdleState:render()
    local anim = self.creature.currentAnimation
    love.graphics.setColor(1,1,1,1) -- sometimes love will be stuck on a different color from a previous graphics call
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.creature.x - self.creature.offsetX), math.floor(self.creature.y - self.creature.offsetY))

     --love.graphics.setColor(1, 0, 1, 1)
     --love.graphics.rectangle('line', self.creature.x, self.creature.y, self.creature.width, self.creature.height)
     --love.graphics.setColor(1, 1, 1, 1)
end
