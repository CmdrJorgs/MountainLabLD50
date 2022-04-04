Map = Class{}

function Map:init()
    self.width = MAP_WIDTH
    self.height = MAP_HEIGHT

    --self.tiles = {}
    --self:generateWallsAndFloors()

    -- entities in the room
    self.creatures = {}
    self:generateCreatures()

    self.creature_generation_roller = VariableIntervalRoller{
        min_seconds = MIN_CREATURE_RESPAWN_TIME,
        max_seconds = MAX_CREATURE_RESPAWN_TIME,
        roll_interval_seconds = CREATURE_RESPAWN_ROLL_INTERVAL,
    }

    -- game objects in the room
    self.objects = {}
    self:generateObjects()

    -- used for centering the dungeon rendering
    --self.renderOffsetX = MAP_RENDER_OFFSET_X
    --self.renderOffsetY = MAP_RENDER_OFFSET_Y

    -- if we ever have to move the viewport we can use this
    self.adjacentOffsetX = 0
    self.adjacentOffsetY = 0
end

--[[
    Randomly creates an assortment of creatures for the player to sacrifice.
]]
function Map:generateCreatures()
    for i = 1, INIT_CREATURE_COUNT do
        self:generateCreature()
    end
end

function Map:generateCreature()
    local type_list = {'blueTogaHuman', 'whiteTogaHuman', 'sheep', 'dog', 'goat', 'bird'}
    local type = type_list[math.random(#type_list)]
    --local color = {'none', 'white', 'purple', 'blue'} TODO

    local creature = Creature {
        type = type,
        species = CREATURE_DEFS[type].species,
        color = CREATURE_DEFS[type].color,
        animations = CREATURE_DEFS[type].animations,
        walkSpeed = CREATURE_DEFS[type].walkSpeed or 20,
        x = math.random(0, VIRTUAL_WIDTH - CREATURE_DEFS[type].width),
        y = math.random(GROUND_HEIGHT, VIRTUAL_HEIGHT - CREATURE_DEFS[type].height),
        width = CREATURE_DEFS[type].width,
        height =  CREATURE_DEFS[type].height,
        isSickly = (math.random() < CREATURE_SICKLY_CHANCE),
        grabSound = CREATURE_DEFS[type].grabSound,
    }

    table.insert(self.creatures, creature)

    creature.stateMachine = StateMachine {
        ['walk'] = function() return CreatureWalkState(creature) end,
        ['idle'] = function() return CreatureIdleState(creature) end,
        ['grabbed'] = function() return CreatureGrabbedState(creature) end,
        ['falling'] = function() return CreatureFallingState(creature) end,
    }

    creature:changeState('idle')
end

--[[
    Randomly creates an assortment of obstacles for the player to navigate around.
]]
function Map:generateObjects()
    local props = { 'house' , 'umbrella_tree' , 'tall_tree' }
    for i = 1, INIT_CREATURE_COUNT do
        local type = props[math.random(#props)]

        table.insert(self.objects, GameObject(
                GAME_OBJECT_DEFS[type],
                math.random(0, VIRTUAL_WIDTH - GAME_OBJECT_DEFS[type].width),
                math.random(GROUND_HEIGHT, VIRTUAL_HEIGHT - GAME_OBJECT_DEFS[type].height)
        ))

    end
end

function Map:update(dt)
    filter_in_place(self.creatures, function(c) return not c.dead end)
    filter_in_place(self.objects, function(o) return not o.dead end)

    self.current_time = (self.current_time or 0) + dt

    self.creature_generation_roller:update(dt)
    local creature_count_to_generate = self.creature_generation_roller:poll_events()
    for i=1,creature_count_to_generate do
        self:generateCreature()
    end

    for i = 1, #self.creatures, 1 do
        local creatureA = self.creatures[i]
        for j = i, #self.objects, 1 do
            local objectB = self.objects[j]
            if creatureA:collides(objectB) then
                creatureA:handleCollision()
            end
        end
        for j = i, #self.creatures, 1 do
            local creatureB = self.creatures[j]
            if creatureA:collides(creatureB) then
                creatureA:handleCollision()
                creatureB:handleCollision()
            end
        end

        creatureA:processAI({}, dt)
        creatureA:update(dt)
    end

    for k, object in pairs(self.objects) do
        object:update(dt)
    end
end

function Map:render()
    love.graphics.setColor(204/255, 192/255, 0, 1)
    love.graphics.rectangle("fill", 0, GROUND_HEIGHT, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    for k, object in pairs(self.objects) do
        object:render(self.adjacentOffsetX, self.adjacentOffsetY)
    end

    for k, creature in pairs(self.creatures) do
        creature:render(self.adjacentOffsetX, self.adjacentOffsetY)
    end
end
