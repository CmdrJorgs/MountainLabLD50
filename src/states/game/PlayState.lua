PlayState = Class{__includes = BaseState}

function PlayState:init()

end

function PlayState:enter(params)
    --self.volcano = 'volcano'
    self.map = Map {}
    --self.cursor = 'cursor'
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('start')
    end
end

function PlayState:render()
    --self.volcano.render()
    self.map.render()
    --self.cursor.render()
end
