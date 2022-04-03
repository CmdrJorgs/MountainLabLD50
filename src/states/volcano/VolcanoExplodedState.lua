VolcanoExplodedState = Class{__includes = BaseState}

function VolcanoExplodedState:init(volcano)
    self.volcano = volcano
end

function VolcanoExplodedState:is_exploded()
    return true
end

function VolcanoExplodedState:render()
    -- TODO: This should be a separate object in front of everything
    love.graphics.setColor(1,0.7,0)
    love.graphics.rectangle("fill",0,0,VIRTUAL_WIDTH,VIRTUAL_HEIGHT)
end