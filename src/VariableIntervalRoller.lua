--[[
    Utility class to roll for events that need to take place within a variable time interval.

    A min and max time interval are provided - the interval between events will always be at least
    the minimum and at most the maximum. Between these times, the event has a uniform chance
    of occurring.

    Usage:
    - Each update(), call update(dt), then call poll_events(). poll_events() will return the number
      of events that occurred since the last call to poll_events()

    Params:
    - min_seconds: The minimum number of seconds for the interval
    - max_seconds: The maximum number of seconds for the interval
    - roll_interval_seconds: (Optional) If provided, the roller will wait this much time between rolls.
      If not, the roller will roll every time update() is called
]]

VariableIntervalRoller = Class{}

function VariableIntervalRoller:init(params)
    self.min_seconds = params.min_seconds
    self.max_seconds = params.max_seconds
    self.roll_interval_seconds = params.roll_interval_seconds or 0
    
    self.current_time = 0
    self.time_of_last_event = 0
    self.time_of_last_roll = 0
    self.number_of_events = 0
end

function VariableIntervalRoller:update(dt)
    self.current_time = self.current_time + dt

    -- NOTE: If dt is larger than the max interval time, this implementation
    -- heavily favors the max interval. An implementation that accounts for this use
    -- case should do additional random rolling to determine the number of events
    -- that actually happened in this interval. This problem does not exist if
    -- dt is much smaller than the max interval.
    
    local time_since_last_event = self.current_time - self.time_of_last_event
    while time_since_last_event > self.max_seconds do
        self.number_of_events = self.number_of_events + 1
        self.time_of_last_event = self.time_of_last_event + self.max_seconds
        self.time_of_last_roll = self.time_of_last_event
        time_since_last_event = time_since_last_event - self.max_seconds
    end

    if time_since_last_event < self.min_seconds then return end
    if self.current_time < self.time_of_last_roll + self.roll_interval_seconds then return end

    local interval_length = (self.current_time - self.time_of_last_event - self.min_seconds) / (self.max_seconds - self.min_seconds)
    local probability_to_roll_against = interval_length * interval_length
    self.time_of_last_roll = self.current_time
    if math.random() < probability_to_roll_against then
        self.time_of_last_event = self.current_time
        self.number_of_events = self.number_of_events + 1
        return
    end
end

function VariableIntervalRoller:poll_events()
    local number_of_events = self.number_of_events
    self.number_of_events = 0
    return number_of_events
end