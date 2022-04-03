Cursor = Class{}

local function getVirtualCursorPosition()
    local mouse_x, mouse_y = love.mouse.getPosition()
    local window_width, window_height = love.graphics.getDimensions()
    return (mouse_x / window_width * VIRTUAL_WIDTH), (mouse_y / window_height * VIRTUAL_HEIGHT)
end

function Cursor:init(params)
    self.map = params.map
    self.volcano = params.volcano

    self.x = 0
    self.y = 0
    self.dx = 0
    self.dy = 0
    self.grabbed_creature = nil
    self.attempting_grab = false
end

function Cursor:update(dt)
    -- This is the main player control object.

    local mouse_x, mouse_y = getVirtualCursorPosition()
    self.dx = (mouse_x - self.x) / dt
    self.dy = (mouse_y - self.y) / dt
    self.x = mouse_x
    self.y = mouse_y
    local mouse_button_is_down = love.mouse.isDown(1)

    if not self.grabbed_creature then
        if mouse_button_is_down then
            if not self.attempting_grab then
                local best_creature = self:get_best_overlapping_creature()
                if best_creature then
                    self.grabbed_creature = best_creature
                    self.grabbed_creature:enter_grab()
                end
            end
        end
    else
        self.grabbed_creature.x = self.x - self.grabbed_creature.width / 2
        self.grabbed_creature.y = self.y - self.grabbed_creature.height / 2
        if not mouse_button_is_down then
            self.grabbed_creature:exit_grab({
                dx = self.dx,
                dy = self.dy
            })
            -- TODO: This should happen when the falling creature collides
            --       with the volcano's "accept offering" hitbox. For now,
            --       just accept the offering immediately if it's dragged
            --       to the top-center of the screen
            if self.x > VIRTUAL_WIDTH * 0.25 and self.x < VIRTUAL_WIDTH * 0.75
                and self.y < GROUND_HEIGHT / 2 
            then
                self.volcano:accept_offering(self.grabbed_creature)
            end
            self.grabbed_creature = nil
        end
    end
    self.attempting_grab = mouse_button_is_down
end

function Cursor:get_best_overlapping_creature()
    -- Figure out all of the creatures the cursor is currently touching
    local grabbed_creatures = {}
    for i, creature in ipairs(self.map.creatures) do
        local adjusted_width = creature.width + CURSOR_GRAB_RANGE * 2
        local adjusted_height = creature.height + CURSOR_GRAB_RANGE * 2
        local adjusted_x = creature.x - CURSOR_GRAB_RANGE
        local adjusted_y = creature.y - CURSOR_GRAB_RANGE
        if (self.x > adjusted_x) and (self.x < adjusted_x + adjusted_width)
            and (self.y > adjusted_y) and (self.y < adjusted_y + adjusted_height) 
        then
            table.insert(grabbed_creatures, creature)
        end
    end
    if #grabbed_creatures == 0 then
        return nil
    end
    -- If we're grabbing multiple creatures, be kinda nice to the player by
    -- giving them a creature that would satisfy the volcano (the idea being
    -- that if they're darting for one, but they slip too close to another creature,
    -- we give them the one they want). If we REALLY wanted to be mean to the player,
    -- we could reverse this test
    local craved_creatures = {}
    for i, creature in ipairs(grabbed_creatures) do
        for j, craving in self.volcano:get_cravings() do
            if craving:is_satisfied_by(creature) then
                table.insert(craved_creatures, creature)
                break
            end
        end
    end
    -- Finally, pick the eligible creature whose center is closest to the cursor
    local eligible_creatures = (#craved_creatures > 0 and craved_creatures) or grabbed_creatures
    local closest_creature = eligible_creatures[1]
    local closest_creature_distance_squared = VIRTUAL_WIDTH * VIRTUAL_WIDTH + VIRTUAL_HEIGHT * VIRTUAL_HEIGHT
    for i, creature in ipairs(eligible_creatures) do
        local dx = creature.x + creature.width / 2 - self.x
        local dy = creature.y + creature.height / 2 - self.y
        local distance_squared = dx * dx + dy * dy
        if distance_squared < closest_creature_distance_squared then
            closest_creature_distance_squared = distance_squared
            closest_creature = creature
        end
    end
    return closest_creature
end

function Cursor:render()
    love.graphics.setColor(1,1,1,1)
    -- TODO: Don't hardcode the cursor values
    local frameIndex = (self.attempting_grab and 2) or 1
    love.graphics.draw(gTextures['cursor'], gFrames['cursor'][frameIndex], self.x - 8, self.y - 8)
end