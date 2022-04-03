VolcanoNormalState = Class{__includes = BaseState}

local MAX_ANGER = 100
local BASE_ANGER_RATE = -0.1
local CRAVING_ANGER_RATE = 1.1
local BAD_OFFERING_OFFENSE_ANGER_RATE = 0.5
local NON_MATCHING_OFFENSE_ANGER_RATE = 0.3
local MAX_OFFENSE_AGE = 10
local MIN_CRAVING_INTERVAL = 6
local MAX_CRAVING_INTERVAL = 15
local MIN_CRAVING_PROBABILITY_TO_ROLL_AGAINST = 0.05

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
    local species_list = {'blueTogaHuman', 'sheep'}
    table.insert(self.cravings, VolcanoCraving {
        creature_species = species_list[math.random(#species_list)]
    })
    self.time_of_last_craving = self.current_time
end

local function try_generate_craving(self)
    local time_since_last_craving = self.current_time - self.time_of_last_craving
    if time_since_last_craving > MIN_CRAVING_INTERVAL then
        if time_since_last_craving > MAX_CRAVING_INTERVAL then
            generate_craving(self)
            return
        else
            -- Roll a random number to decide whether we should generate a craving.
            -- The probability CDF is essentially a long, thin rectangle from MIN_INTERVAL to MAX_INTERVAL
            -- whose total area is 1
            local time_since_last_craving_roll = self.current_time - self.time_of_last_craving_roll
            local probability_to_roll_against = time_since_last_craving_roll / (MAX_CRAVING_INTERVAL - MIN_CRAVING_INTERVAL)
            if probability_to_roll_against > MIN_CRAVING_PROBABILITY_TO_ROLL_AGAINST then
                self.time_of_last_craving_roll = self.current_time
                if love.math.random() < probability_to_roll_against then
                    generate_craving(self)
                    return
                end
            end
        end
    end
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
    self.time_of_last_craving = 0
    self.time_of_last_craving_roll = 0

    self.feedback_reporter = enterParams.feedback_reporter or {
        report_satisfied = function() end,
        report_non_matching_offering = function() end,
        report_defective_offering = function() end,
    }
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
    end
end

-- process AI

function VolcanoNormalState:processAI(params, dt)
    try_generate_craving(self)
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
                -- TODO: add information drawn from the offering
                reason = "BAD OFFERING"
            }, 
            start_time = self.current_time,
            anger_rate = BAD_OFFERING_OFFENSE_ANGER_RATE
        })
        self.feedback_reporter:report_defective_offering(offering)
        return
    end
    
    local craving_satisfied = false
    for k,v in ipairs(self.cravings) do
        if v:is_satisfied_by(offering) then
            craving_satisfied = true
            table.remove(self.cravings, k)
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
    if self.anger < 10 then
        VOLCANO_STAGE = 1
    elseif self.anger < 50 then
        VOLCANO_STAGE = 2
    elseif self.anger < 75 then
        VOLCANO_STAGE = 3
    elseif self.anger < 95 then
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

    -- TODO: Definitely decide where this should go
    love.graphics.setFont(gFonts['small'])
    love.graphics.print("Anger Level: "..self.anger, 10, 10)
    for k,v in ipairs(self.cravings) do
        local craving_text = "Species: "..tostring(v.creature_species)..", Color: "..tostring(v.creature_color)
        love.graphics.print("Craving: "..craving_text, 20, k * 16 + 20)
    end
    for k,v in ipairs(self.offenses) do
        local offense_text = v.descriptor.reason
        love.graphics.print("Offense: "..offense_text, VIRTUAL_WIDTH / 2, k * 16 + 20)
    end
end