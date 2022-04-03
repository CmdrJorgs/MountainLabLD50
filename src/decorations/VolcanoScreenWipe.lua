VolcanoScreenWipe = Class{__includes = BaseDecoration}

function VolcanoScreenWipe:init(params)
    self.currentAge = 0
end
function VolcanoScreenWipe:update(dt)
    self.currentAge = self.currentAge + dt
end
function VolcanoScreenWipe:render()
    if self.currentAge < EXPLOSION_ANIMATION_WIPE_START then return end
    local wipeHeightProportion = (self.currentAge - EXPLOSION_ANIMATION_WIPE_START) / (EXPLOSION_ANIMATION_WIPE_END - EXPLOSION_ANIMATION_WIPE_START)
    if wipeHeightProportion > 1 then wipeHeightProportion = 1 end
    love.graphics.setColor(1,0.7,0)
    love.graphics.rectangle("fill", 0, 0, VIRTUAL_WIDTH, wipeHeightProportion * VIRTUAL_HEIGHT)
end