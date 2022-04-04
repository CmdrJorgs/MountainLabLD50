VolcanoNormalState = Class{__includes = BaseState}

local MAX_ANGER = 100
local BASE_ANGER_RATE = -0.1
local CRAVING_ANGER_RATE = 1.1
local SATISFACTION_ANGER_REDUCTION = 10
local BAD_OFFERING_OFFENSE_ANGER_RATE = 0.8
local DONT_WANT_ANYTHING_OFFENSE_ANGER_RATE = 0.3
local NON_MATCHING_OFFENSE_ANGER_RATE = 0.2
local MAX_OFFENSE_AGE = 10
local MIN_CRAVING_INTERVAL = 10
local MAX_CRAVING_INTERVAL = 20
local MIN_CRAVING_ROLL_INTERVAL = 2
local TIME_WHEN_ALL_CRAVINGS_ARE_SPECIES_SPECIFIC = 180

-- local helper functions

-- calculates the amount the volcano's anger should change per second
local function calculate_anger_rate(self)
    local base_anger_rate = BASE_ANGER_RATE
    local cravings_anger_rate = table.getn(self.cravings) * CRAVING_ANGER_RATE
    local offenses_anger_rate = 0
    for k,v in ipairs(self.offenses) do
        local age = self.current_time - v.start_time
        if age < 10 then
            offenses_anger_rate = offenses_anger_rate + v.anger_rate
        end
    end
    return base_anger_rate + cravings_anger_rate + offenses_anger_rate
end

local function generate_craving(self)
    local craving_params = {}
    local species_specific_craving_chance = math.min(1, self.current_time / TIME_WHEN_ALL_CRAVINGS_ARE_SPECIES_SPECIFIC)
    if math.random() < species_specific_craving_chance then
        local species_list = {'blueTogaHuman', 'whiteTogaHuman', 'sheep', 'dog', 'goat', 'bird'}
        craving_params.creature_species = species_list[math.random(#species_list)]
    end
    table.insert(self.cravings, VolcanoCraving (craving_params))
    self.time_of_last_craving = self.current_time
end

-- state management
function VolcanoNormalState:init(volcano)
    self.volcano = volcano
end

function VolcanoNormalState:enter(enterParams)
    self.anger = 0
    self.cravings = {}
    self.offenses = {}
    self.current_time = 0
    self.craving_roller = VariableIntervalRoller {
        min_seconds = MIN_CRAVING_INTERVAL,
        max_seconds = MAX_CRAVING_INTERVAL,
        roll_interval_seconds = MIN_CRAVING_ROLL_INTERVAL
    }

    self.feedback_reporter = enterParams.feedback_reporter or {
        report_satisfied = function() end,
        report_non_matching_offering = function() end,
        report_dont_want_anything = function() end,
        report_defective_offering = function() end,
        report_exploding = function() end,
    }
    generate_craving(self)
end

function VolcanoNormalState:exit()
end

-- update

function VolcanoNormalState:update(dt)
    self.current_time = self.current_time + dt
    local current_time = self.current_time
    self.offenses = filter_in_place(self.offenses, function(o)
        local age = current_time - o.start_time
        return age < MAX_OFFENSE_AGE
    end)

    local anger_rate = calculate_anger_rate(self) * dt
    self.anger = math.max(self.anger + anger_rate, 0)
    if self.anger > MAX_ANGER then
        self.volcano.state_machine:change('exploding')
        self.feedback_reporter:report_exploding()
    end
end

-- process AI

function VolcanoNormalState:processAI(params, dt)
    self.craving_roller:update(dt)
    local cravings_to_generate = self.craving_roller:poll_events()
    for i=1,cravings_to_generate do
        generate_craving(self)
    end
end

-- accept offerings

function VolcanoNormalState:get_cravings()
    return ipairs(self.cravings)
end

function VolcanoNormalState:accept_offering(offering)
    if offering.dead then
        -- ignore the offering - we already killed it.
        -- Note that this boolean only refers to cleaning up the
        -- creature from the creatures list - if the creature can actually
        -- die by other means in a way that we can still pick them up
        -- and sacrifice them, then we should accept them if they were
        -- killed in a ritual manner and consider them defective otherwise
        return
    end
    offering.dead = true

    if offering:isDefective() then
        table.insert(self.offenses, {
            descriptor = {
                species = offering.species,
                color = offering.color,
                reason = "BAD OFFERING"
            }, 
            start_time = self.current_time,
            anger_rate = BAD_OFFERING_OFFENSE_ANGER_RATE
        })
        self.feedback_reporter:report_defective_offering(offering)
        return
    end

    if #self.cravings == 0 then
        table.insert(self.offenses, {
            descriptor = {
                species = offering.species,
                color = offering.color,
                reason = "DON'T WANT ANYTHING"
            }, 
            start_time = self.current_time,
            anger_rate = DONT_WANT_ANYTHING_OFFENSE_ANGER_RATE
        })
        self.feedback_reporter:report_dont_want_anything(offering)
        return
    end
    
    local craving_satisfied = false
    for k,v in ipairs(self.cravings) do
        if v:is_satisfied_by(offering) then
            craving_satisfied = true
            table.remove(self.cravings, k)
            self.anger = self.anger - SATISFACTION_ANGER_REDUCTION
            self.feedback_reporter:report_satisfied(v, offering)
            break
        end
    end
    if not craving_satisfied then
        table.insert(self.offenses, {
            descriptor = {
                species = offering.species,
                color = offering.color,
                reason = "NON-MATCHING OFFERING"
            },
            start_time = self.current_time,
            anger_rate = NON_MATCHING_OFFENSE_ANGER_RATE
        })
        self.feedback_reporter:report_non_matching_offering(offering)
    end
end

-- render

function VolcanoNormalState:render()
    local VOLCANO_STAGE = 1
    if self.anger < 1 then
        VOLCANO_STAGE = 1
    elseif self.anger < 40 then
        VOLCANO_STAGE = 2
    elseif self.anger < 70 then
        VOLCANO_STAGE = 3
    elseif self.anger < 90 then
        VOLCANO_STAGE = 4
    else
        VOLCANO_STAGE = 5
    end
    --love.graphics.draw(gTextures['volcano'], gFrames['volcano'][1], VIRTUAL_WIDTH / 2, 0, 0, 1, 1, gTextures['volcano']:getWidth/2, gTextures['volcano']:getHeight/2)
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(
        gTextures['volcano'],
        gFrames['volcano'][VOLCANO_STAGE],
        VIRTUAL_WIDTH / 2,
        GROUND_HEIGHT - (self.volcano.height / 2) + 20,
        0,
        1,
        1,
        self.volcano.width / 2,
        self.volcano.height / 2
    )
end
