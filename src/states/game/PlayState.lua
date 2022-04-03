PlayState = Class{__includes = BaseState}

function PlayState:init()
    -- TODO: Add callbacks to allow the volcano to summon feedback entities
    self.volcano = Volcano {
        feedback_reporter = self:generateVolcanoFeedbackReporter()
    }
    self.map = Map {}
    self.cursor = Cursor {
        volcano = self.volcano,
        map = self.map,
    }
end

function PlayState:enter(params)
    love.mouse.setVisible(false)
end

function PlayState:exit()
    love.mouse.setVisible(true)
end

function PlayState:generateVolcanoFeedbackReporter()
    -- TODO: Make these functions actually do something
    local s = self
    return {
        -- Called when the volcano is satisfied with its offerings
        report_satisfied = function(craving, offering)
            print("Volcano satisfied a craving with this offering")
        end,
        -- Called when the volcano is given something it did not want
        report_non_matching_offering = function(offering)
            print("Volcano given something it did not want")
        end,
        -- Called when the volcano is given something undesirable,
        -- such as a sick animal
        report_defective_offering = function(offering)
            print("Volcano given something defective")
        end
    }
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('start')
    end

    self.map:update(dt)

    self.volcano:update(dt)
    if self.volcano:is_exploded() then
        gStateMachine:change("gameOver")
    end

    self.cursor:update(dt)
end

function PlayState:processAI(params, dt)
    self.volcano:processAI(params, dt)
end

function PlayState:render()
    love.graphics.clear(0.4, 0.4, 0.5)
    self.map:render()
    self.volcano:render()
    self.cursor:render()
end
