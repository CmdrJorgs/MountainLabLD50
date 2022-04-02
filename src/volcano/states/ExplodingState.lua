local ExplodingState = Class{_includes = BaseState}

local EXPLOSION_TIME = 6

function ExplodingState:enter(enterParams)
    self.current_time = 0
    self.exploded_callback = enterParams.exploded_callback
    if self.exploded_callback == nil then
        error("Did not receive an exploded callback")
    end
end

function ExplodingState:update(dt)
    self.current_time = self.current_time + dt
    if self.current_time > EXPLOSION_TIME then
        self.exploded_callback()
    end
end

function ExplodingState:render()
    -- TODO: Draw the volcano exploding here
end

return ExplodingState