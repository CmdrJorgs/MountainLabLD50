VolcanoExplodingState = Class{__includes = BaseState}

local SCREEN_WIPE_TIME = 5
local EXPLOSION_TIME = 6

function VolcanoExplodingState:init(volcano)
    self.volcano = volcano
end

function VolcanoExplodingState:enter(enterParams)
    self.current_time = 0
end

function VolcanoExplodingState:update(dt)
    self.current_time = self.current_time + dt
    if self.current_time > EXPLOSION_TIME then
        self.volcano.state_machine:change('exploded')
    end
end

function VolcanoExplodingState:render()
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

    -- TODO: This should be a separate object in front of everything
    love.graphics.setColor(1,0.7,0)
    love.graphics.rectangle("fill",0,0,VIRTUAL_WIDTH,self.current_time / SCREEN_WIPE_TIME * VIRTUAL_HEIGHT)
end