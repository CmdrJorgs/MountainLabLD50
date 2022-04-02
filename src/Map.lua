Map = Class{}

function Map:init()
    self.width = MAP_WIDTH
    self.height = MAP_HEIGHT

    --self.tiles = {}
    --self:generateWallsAndFloors()

    -- entities in the room
    self.entities = {}
    --self:generateEntities()

    -- game objects in the room
    self.objects = {}
    --self:generateObjects()

    -- used for centering the dungeon rendering
    --self.renderOffsetX = MAP_RENDER_OFFSET_X
    --self.renderOffsetY = MAP_RENDER_OFFSET_Y
end

--[[
    Randomly creates an assortment of enemies for the player to fight.
]]
--function Map:generateEntities()
--    local types = {'skeleton', 'slime', 'bat', 'ghost', 'spider'}
--
--    for i = 1, 10 do
--        local type = types[math.random(#types)]
--
--        table.insert(self.entities, Entity {
--            animations = ENTITY_DEFS[type].animations,
--            walkSpeed = ENTITY_DEFS[type].walkSpeed or 20,
--
--            -- ensure X and Y are within bounds of the map
--            x = math.random(MAP_RENDER_OFFSET_X + TILE_SIZE,
--                VIRTUAL_WIDTH - TILE_SIZE * 2 - 16),
--            y = math.random(MAP_RENDER_OFFSET_Y + TILE_SIZE,
--                VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) + MAP_RENDER_OFFSET_Y - TILE_SIZE - 16),
--
--            width = 16,
--            height = 16,
--
--            health = 1
--        })
--
--        self.entities[i].stateMachine = StateMachine {
--            ['walk'] = function() return EntityWalkState(self.entities[i]) end,
--            ['idle'] = function() return EntityIdleState(self.entities[i]) end
--        }
--
--        self.entities[i]:changeState('walk')
--    end
--end

--[[
    Randomly creates an assortment of obstacles for the player to navigate around.
]]
--function Map:generateObjects()
--    table.insert(self.objects, GameObject(
--        GAME_OBJECT_DEFS['switch'],
--        math.random(MAP_RENDER_OFFSET_X + TILE_SIZE,
--                    VIRTUAL_WIDTH - TILE_SIZE * 2 - 16),
--        math.random(MAP_RENDER_OFFSET_Y + TILE_SIZE,
--                    VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) + MAP_RENDER_OFFSET_Y - TILE_SIZE - 16)
--    ))
--
--    -- get a reference to the switch
--    local switch = self.objects[1]
--
--    -- define a function for the switch that will open all doors in the room
--    switch.onCollide = function()
--        if switch.state == 'unpressed' then
--            switch.state = 'pressed'
--
--            -- open every door in the room if we press the switch
--            for k, doorway in pairs(self.doorways) do
--                doorway.open = true
--            end
--
--            gSounds['door']:play()
--        end
--    end
--
--    for x = 1, math.random(MIN_POTS, MAX_POTS) do
--        addPot(self.objects)
--    end
--end

--[[
    Generates the walls and floors of the room, randomizing the various varieties
    of said tiles for visual variety.
]]
--function Map:generateWallsAndFloors()
--    for y = 1, self.height do
--        table.insert(self.tiles, {})
--
--        for x = 1, self.width do
--            local id = TILE_EMPTY
--
--            if x == 1 and y == 1 then
--                id = TILE_TOP_LEFT_CORNER
--            elseif x == 1 and y == self.height then
--                id = TILE_BOTTOM_LEFT_CORNER
--            elseif x == self.width and y == 1 then
--                id = TILE_TOP_RIGHT_CORNER
--            elseif x == self.width and y == self.height then
--                id = TILE_BOTTOM_RIGHT_CORNER
--
--            -- random left-hand walls, right walls, top, bottom, and floors
--            elseif x == 1 then
--                id = TILE_LEFT_WALLS[math.random(#TILE_LEFT_WALLS)]
--            elseif x == self.width then
--                id = TILE_RIGHT_WALLS[math.random(#TILE_RIGHT_WALLS)]
--            elseif y == 1 then
--                id = TILE_TOP_WALLS[math.random(#TILE_TOP_WALLS)]
--            elseif y == self.height then
--                id = TILE_BOTTOM_WALLS[math.random(#TILE_BOTTOM_WALLS)]
--            else
--                id = TILE_FLOORS[math.random(#TILE_FLOORS)]
--            end
--
--            table.insert(self.tiles[y], {
--                id = id
--            })
--        end
--    end
--end

function Map:update(dt)
    -- don't update anything if we are sliding to another room (we have offsets)
    --if self.adjacentOffsetX ~= 0 or self.adjacentOffsetY ~= 0 then return end
    --
    --self.player:update(dt)
    --
    --for i = #self.entities, 1, -1 do
    --    local entity = self.entities[i]
    --
    --    -- remove entity from the table if health is <= 0
    --    if entity.health <= 0 then
    --        entity.dead = true
    --    elseif not entity.dead then
    --        entity:processAI({room = self}, dt)
    --        entity:update(dt)
    --    end
    --
    --    -- collision between the player and entities in the room
    --    if not entity.dead and self.player:collides(entity) and not self.player.invulnerable then
    --        gSounds['hit-player']:play()
    --        self.player:damage(1)
    --        self.player:goInvulnerable(1.5)
    --
    --        if self.player.health == 0 then
    --            gStateMachine:change('game-over')
    --        end
    --    end
    --
    --    if not entity.dead then
    --        for k,projectile in pairs(self.projectiles) do
    --            if not projectile.dead and projectile:collides(entity) then
    --                entity:damage(1)
    --                gSounds['hit-enemy']:play()
    --                projectile:changeState('explode')
    --            end
    --        end
    --    end
    --end
    --
    --for k, object in pairs(self.objects) do
    --    object:update(dt)
    --
    --    -- trigger collision callback on object
    --    if self.player:collides(object) then
    --        object:onCollide()
    --    end
    --end
    --
    --for k, projectile in pairs(self.projectiles) do
    --    projectile:update(dt)
    --
    --    -- trigger collision callback on object
    --    --if self.player:collides(projectile) then
    --    --    projectile:onCollide()
    --    --end
    --end
end

function Map:render()
    love.graphics.setColor(0, 198/255, 266/255, 1)
    love.graphics.rectangle("fill", 0, 0, VIRTUAL_WIDTH, GROUND_HEIGHT)
    love.graphics.setColor(204/255, 192/255, 0, 1)
    love.graphics.rectangle("fill", 0, GROUND_HEIGHT, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
end
