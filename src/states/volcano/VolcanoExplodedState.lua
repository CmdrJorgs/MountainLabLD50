VolcanoExplodedState = Class{__includes = BaseState}

function VolcanoExplodedState:init(volcano)
    self.volcano = volcano
end

function VolcanoExplodedState:is_exploded()
    return true
end

function VolcanoExplodedState:render()
    -- not rendering anything because the game should be over
    -- and the screen should be completely covered in lava
end