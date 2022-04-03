CreatureGrabbedState = Class{__includes = BaseState}

function CreatureGrabbedState:init(creature)
    self.creature = creature
    if not self.creature then
        error("Cannot operate grabbed state with a nil creature")
    end

    self.creature:changeAnimation('grabbed-' .. 'down' )-- self.creature.direction)

    -- TODO: do some fun dangling animations
end

function CreatureGrabbedState:processAI(params, dt)
    
end

function CreatureGrabbedState:render()
    local anim = self.creature.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.creature.x - self.creature.offsetX), math.floor(self.creature.y - self.creature.offsetY))
end
