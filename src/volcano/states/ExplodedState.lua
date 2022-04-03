local ExplodedState = Class{__includes = BaseState}

function ExplodedState:init(volcano)
    self.volcano = volcano
end

function ExplodedState:is_exploded()
    return true
end

function ExplodedState:render()
    love.graphics.setColor(1,0.7,0)
    love.graphics.rectangle("fill",0,0,VIRTUAL_WIDTH,VIRTUAL_HEIGHT)
end

return ExplodedState