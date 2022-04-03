--[[
    Class describing the Volcano object.
    The Volcano is the main focus of the game state - the volcano
    slowly gets angrier over time, the player drops animals and people
    into it to appease it, and when it eventually reaches full anger,
    it erupts and the game ends.
    Author: Hans Jorgensen
]]

Volcano = Class{}

--[[
    The volcano has three main states:
    - Normal: The normal gameplay loop - the volcano slowly builds up anger, develops cravings,
      accepts offerings, etc.
    - Exploding: The volcano has hit max anger and is playing a mad sick explosion animation of some kind
    - Exploded: The volcano has erupted - we should transfer the main game to Game Over at this point
]]

function Volcano:init(params)
    self.width = 440
    self.height = 220
    local volcano = self
    self.state_machine = StateMachine{
        normal = function() return VolcanoNormalState(volcano) end,
        exploding = function() return VolcanoExplodingState(volcano) end,
        exploded = function() return VolcanoExplodedState(volcano) end,
    }
    -- Enter the normal state, passing state change functions into the parameters
    self.state_machine:change("normal", { 
        feedback_reporter = params.feedback_reporter,
    })
end

function Volcano:is_exploded()
    local current = self.state_machine.current
    if current.is_exploded ~= nil then
        return current:is_exploded()
    else
        return false
    end
end

function Volcano:update(dt)
    self.state_machine:update(dt)
end

function Volcano:processAI(params, dt)
    self.state_machine:processAI(params, dt)
end

function Volcano:get_cravings()
    local current = self.state_machine.current
    if current.get_cravings ~= nil then
        return current:get_cravings()
    else
        return ipairs({})
    end
end

function Volcano:accept_offering(offering)
    local current = self.state_machine.current
    if current.accept_offering ~= nil then
        current:accept_offering(offering)
    end
end

function Volcano:render()
    self.state_machine:render()
end
