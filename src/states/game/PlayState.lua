PlayState = Class{__includes = BaseState}

function PlayState:enter(enterParams)
    -- TODO: Add callbacks to allow the volcano to summon feedback entities
    self.volcano = Volcano()
end

function PlayState:update(dt)
    self.volcano:update(dt)
    if self.volcano:is_exploded() then
        gStateMachine:change("gameOver")
    end
end

function PlayState:processAI(params, dt)
    self.volcano:processAI(params, dt)
end

function PlayState:render()
    love.graphics.clear(0.4, 0.4, 0.5)
    self.volcano:render(dt) -- TODO: insert position params here too
end