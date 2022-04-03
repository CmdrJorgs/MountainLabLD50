Map = Class{}

function Map:init()
    self.width = MAP_WIDTH
    self.height = MAP_HEIGHT

    --self.tiles = {}
    --self:generateWallsAndFloors()

    -- entities in the room
    self.creatures = {}
    self:generateCreatures()

    -- game objects in the room
    self.objects = {}
    --self:generateObjects()

    -- used for centering the dungeon rendering
    --self.renderOffsetX = MAP_RENDER_OFFSET_X
    --self.renderOffsetY = MAP_RENDER_OFFSET_Y

    -- if we ever have to move the viewport we can use this
    self.adjacentOffsetX = 0
    self.adjacentOffsetY = 0
end

--[[
    Randomly creates an assortment of enemies for the player to fight.
]]
function Map:generateCreatures()
    local species = {'bull', 'goat', 'lamb', 'dog', 'bird', 'wheat', 'wine', 'purple toga human', 'pants barbarian', 'white toga human', 'blue tunic human', 'egyptian hat human'}
    --local color = {'none', 'white', 'purple', 'blue'} TODO

    for i = 1, INIT_CREATURE_COUNT do
        --local type = species[math.random(#species)]
        local type = 'bull'

        table.insert(self.creatures, Creature {
            animations = CREATURE_DEFS[type].animations,
            walkSpeed = CREATURE_DEFS[type].walkSpeed or 20,
            x = math.random(0, VIRTUAL_WIDTH - CREATURE_DEFS[type].width),
            y = math.random(GROUND_HEIGHT, VIRTUAL_HEIGHT - CREATURE_DEFS[type].height),
            width = CREATURE_DEFS[type].width,
            height =  CREATURE_DEFS[type].height,
        })

        self.creatures[i].stateMachine = StateMachine {
            ['idle'] = function() return EntityIdleState(self.creatures[i]) end,
            ['grabbed'] = function() return EntityGrabbedState(self.creatures[i]) end,
            ['falling'] = function() return EntityFallingState(self.creatures[i]) end,
        }

        self.creatures[i]:changeState('idle')
    end
end

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
    -- self.cursor:update(dt)

    for k, creature in pairs(self.creatures) do
        creature:processAI({}, dt)
        creature:update(dt)
    end

    for k, object in pairs(self.objects) do
        object:update(dt)
    end
end

function Map:render()
    love.graphics.setColor(0, 198/255, 266/255, 1)
    love.graphics.rectangle("fill", 0, 0, VIRTUAL_WIDTH, GROUND_HEIGHT)
    love.graphics.setColor(204/255, 192/255, 0, 1)
    love.graphics.rectangle("fill", 0, GROUND_HEIGHT, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    --for k, object in pairs(self.objects) do
    --    object:render(self.adjacentOffsetX, self.adjacentOffsetY)
    --end

    for k, entity in pairs(self.creatures) do
        entity:render(self.adjacentOffsetX, self.adjacentOffsetY)
    end
end
