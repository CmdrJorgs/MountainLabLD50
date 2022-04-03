CreatureFallingState = Class{__includes = BaseState}

function CreatureFallingState:init(creature)
    self.creature = creature
    if not self.creature then
        error("Cannot operate falling state with a nil creature")
    end

    self.creature:changeAnimation('fall-' .. 'down' )-- self.entity.direction)
end

function CreatureFallingState:enter(enterParams)
    -- TODO: keep any inertia from earlier
    self.dx = 0
    self.dy = 0
end

function CreatureFallingState:update(dt)
    -- TODO: If the creature has been picked up and moved around a bit,
    --       they should fall some regardless of where they are dropped.
    --       For now, though, only drop if above ground height
    if self.creature.y > GROUND_HEIGHT then
        self.creature:changeState('idle')
        return
    end

    self.dy = self.dy + ENTITY_FALL_ACCEL * dt
    self.creature.x = self.creature.x + self.dx * dt
    self.creature.y = self.creature.y + self.dy * dt
end

function CreatureFallingState:processAI(params, dt)

end

function CreatureFallingState:render()
    local anim = self.creature.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.creature.x - self.creature.offsetX), math.floor(self.creature.y - self.creature.offsetY))
end
