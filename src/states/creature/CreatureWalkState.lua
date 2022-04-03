CreatureWalkState = Class{__includes = BaseState}

function CreatureWalkState:init(creature)
    self.creature = creature
    --self.creature:changeAnimation('walk-down')

    -- used for AI control
    self.moveDuration = 0
    self.movementTimer = 0

    -- keeps track of whether we just hit a wall
    self.bumped = false
end

function CreatureWalkState:update(dt)
    
    -- assume we didn't hit a wall
    self.bumped = false

    if self.creature.direction == 'left' then
        self.creature.x = self.creature.x - self.creature.walkSpeed * dt
        
        if self.creature.x <= 0 + self.creature.width then
            self.creature.x = 0 + self.creature.width
            self.bumped = true
        end
    elseif self.creature.direction == 'right' then
        self.creature.x = self.creature.x + self.creature.walkSpeed * dt

        if self.creature.x + self.creature.width >= VIRTUAL_WIDTH - self.creature.width * 2 then
            self.creature.x = VIRTUAL_WIDTH - self.creature.width * 2 - self.creature.width
            self.bumped = true
        end
    elseif self.creature.direction == 'up' then
        self.creature.y = self.creature.y - self.creature.walkSpeed * dt

        if self.creature.y <= GROUND_HEIGHT + self.creature.height - self.creature.height / 2 then
            self.creature.y = GROUND_HEIGHT + self.creature.height - self.creature.height / 2
            self.bumped = true
        end
    elseif self.creature.direction == 'down' then
        self.creature.y = self.creature.y + self.creature.walkSpeed * dt

        local bottomEdge = VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * self.creature.height)
            + 0 - self.creature.height

        if self.creature.y + self.creature.height >= bottomEdge then
            self.creature.y = bottomEdge - self.creature.height
            self.bumped = true
        end
    end
end

function CreatureWalkState:processAI(params, dt)
    local directions = {'left', 'right', 'up', 'down'}

    if self.moveDuration == 0 or self.bumped then
        
        -- set an initial move duration and direction
        self.moveDuration = math.random(5)
        self.creature.direction = directions[math.random(#directions)]
        --self.creature:changeAnimation('walk-' .. tostring(self.creature.direction))
    elseif self.movementTimer > self.moveDuration then
        self.movementTimer = 0

        -- chance to go idle
        if math.random(3) == 1 then
            self.creature:changeState('idle')
        else
            self.moveDuration = math.random(5)
            self.creature.direction = directions[math.random(#directions)]
            --self.creature:changeAnimation('walk-' .. tostring(self.creature.direction))
        end
    end

    self.movementTimer = self.movementTimer + dt
end

function CreatureWalkState:render()
    local anim = self.creature.currentAnimation
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.creature.x - self.creature.offsetX), math.floor(self.creature.y - self.creature.offsetY))
    
    -- love.graphics.setColor(255, 0, 255, 255)
    -- love.graphics.rectangle('line', self.creature.x, self.creature.y, self.creature.width, self.creature.height)
    -- love.graphics.setColor(255, 255, 255, 255)
end
