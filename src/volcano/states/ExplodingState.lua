local ExplodingState = Class{__includes = BaseState}

local SCREEN_WIPE_TIME = 5
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
    love.graphics.setColor(1,0.7,0)
    love.graphics.rectangle("fill",0,0,VIRTUAL_WIDTH,self.current_time / SCREEN_WIPE_TIME * VIRTUAL_HEIGHT)
    -- TODO: Draw the volcano exploding here
end

return ExplodingState