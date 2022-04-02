PlayState = Class{__includes = BaseState}

function PlayState:init()

end

function PlayState:enter(params)
    -- TODO: Add callbacks to allow the volcano to summon feedback entities
    self.volcano = Volcano()
    self.map = Map {}
    --self.cursor = 'cursor'
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('start')
    end
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
    self.map:render()
    self.volcano:render(dt)
    --self.cursor.render()
end
