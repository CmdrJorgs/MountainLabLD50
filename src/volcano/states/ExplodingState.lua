local ExplodingState = Class{__includes = BaseState}

local SCREEN_WIPE_TIME = 5
local EXPLOSION_TIME = 6

function ExplodingState:init(volcano)
    self.volcano = volcano
end

function ExplodingState:enter(enterParams)
    self.current_time = 0
end

function ExplodingState:update(dt)
    self.current_time = self.current_time + dt
    if self.current_time > EXPLOSION_TIME then
        self.volcano.state_machine:change('exploded')
    end
end

function ExplodingState:render()
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(
        gTextures['volcano'],
        gFrames['volcano'][5],
        VIRTUAL_WIDTH / 2,
        GROUND_HEIGHT - (self.volcano.height / 2) + 20,
        0,
        1,
        1,
        self.volcano.width / 2,
        self.volcano.height / 2
    )

    love.graphics.setColor(1,0.7,0)
    love.graphics.rectangle("fill",0,0,VIRTUAL_WIDTH,self.current_time / SCREEN_WIPE_TIME * VIRTUAL_HEIGHT)
    -- TODO: Draw the volcano exploding here
end

return ExplodingState