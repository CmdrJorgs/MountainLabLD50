local NormalState = Class{_include = BaseState}

local MAX_ANGER = 100
local BASE_ANGER_RATE = -0.1
local CRAVING_ANGER_RATE = 1.1
local MINOR_DEMERIT_ANGER_RATE = 0.5
local MAJOR_DEMERIT_ANGER_RATE = 1.0
local MAX_DEMERIT_AGE = 10
local MIN_CRAVING_INTERVAL = 6
local MAX_CRAVING_INTERVAL = 15
local MIN_CRAVING_PROBABILITY_TO_ROLL_AGAINST = 0.05

-- state management

function NormalState:enter(enterParams)
    self.anger = 0
    self.cravings = {}
    self.demerits = {}
    self.current_time = 0
    self.time_of_last_craving = 0
    self.time_of_last_craving_roll = 0

    -- enter params contains an explode callback
    self.explode_callback = enterParams.explode_callback
    if self.explode_callback == nil then
        error("Did not receive an explode callback")
    end
end

function NormalState:exit()
end

-- update

function NormalState:update(dt)
    self.current_time = self.current_time + dt
    for k,v in self.demerits do
        local age = self.current_time - v.start_time
        if age > MAX_DEMERIT_AGE then
            table.remove(k)
        end
    end
    local anger_rate = calculate_anger_rate(self) * dt
    self.anger = self.anger + anger_rate
    if self.anger > MAX_ANGER then
        self.explode_callback()
    end
end

-- calculates the amount the volcano's anger should change per second
local function calculate_anger_rate(self)
    local base_anger_rate = BASE_ANGER_RATE
    local cravings_anger_rate = table.getn(self.cravings) * CRAVING_ANGER_RATE
    local demerit_anger_rate = 0
    for k,v in self.demerits do
        local age = self.current_time - v.start_time
        if age < 10 then
            demerit_anger_rate = demerit_anger_rate + v.anger_rate
        end
    end
    return base_anger_rate + cravings_anger_rate + demerit_anger_rate
end

-- process AI

function NormalState:processAI(params, dt)
    try_generate_craving(self)
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
            local time_since_last_craving_roll = self.current_time - time_of_last_craving_roll
            local probability_to_roll_against = time_since_last_craving_roll / (MAX_CRAVING_INTERVAL - MIN_CRAVING_INTERVAL)
            if probability_to_roll_against > MIN_CRAVING_PROBABILITY_TO_ROLL_AGAINST then
                self.time_of_last_craving_roll = self.current_time
                if math.random() < probability_to_roll_against then
                    generate_craving(self)
                    return
                end
            end
        end
    end
end

local function generate_craving(self)
    -- TODO: this is where we specify the kind of offering we want. We might want to create craving classes here
    table.insert(self.cravings, {
        is_satisfied_by = function(self, offering) return true end
    })
    self.time_of_last_craving = self.current_time
end

-- accept offerings

function NormalState:accept_offering(offering)
    local satisfied_cravings = {}
    for k,v in self.cravings do
        if v:is_satisfied_by(offering) then
            table.insert(satisfied_cravings, k)
        end
    end
    if table.getn(satisfied_cravings) == 0 then
        table.insert(self.demerits, {
            descriptor = {}, -- TODO: some information describing the demerit
            age = self.current_time,
            anger_rate = MAJOR_DEMERIT_ANGER_RATE
        })
        -- TODO: pop up some speech bubble saying "Nope, that's not what I want"
    else
        for k,v in satisfied_cravings do
            table.remove(self.cravings, v)
        end
        -- TODO: depending on the offering, there might be a minor demerit incurred here,
        -- such as if the cow was sick
    end
end

-- render

function NormalState:render()
    -- TODO: Draw the volcano vibing
end

return NormalState