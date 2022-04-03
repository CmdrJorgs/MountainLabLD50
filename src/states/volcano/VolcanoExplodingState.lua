VolcanoExplodingState = Class{__includes = BaseState}

function VolcanoExplodingState:init(volcano)
    self.volcano = volcano
end

function VolcanoExplodingState:enter(enterParams)
    self.current_time = 0
end

function VolcanoExplodingState:update(dt)
    self.current_time = self.current_time + dt
    if self.current_time > EXPLOSION_ANIMATION_TOTAL_DURATION then
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
end