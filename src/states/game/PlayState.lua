PlayState = Class{__includes = BaseState}

function PlayState:init()
    -- TODO: Add callbacks to allow the volcano to summon feedback entities
    self.volcano = Volcano {
        feedback_reporter = self:generateVolcanoFeedbackReporter()
    }
    self.map = Map {}
    --self.cursor = 'cursor'
end

function PlayState:enter(params)

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
    self.map:update(dt)
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('start')
    end
    -- Test code for feeding offerings to the volcano
    if love.keyboard.wasPressed('z') then
        self.volcano:accept_offering({
            is_defective = function(self) return false end
        })
    end
    if love.keyboard.wasPressed('x') then
        self.volcano:accept_offering({
            is_defective = function(self) return true end
        })
    end
    self.volcano:update(dt)
    if self.volcano:is_exploded() then
        gStateMachine:change("gameOver")
    end
end

function PlayState:processAI(params, dt)
    self.volcano:processAI(params, dt)
end

function PlayState:render()
    love.graphics.clear(0.4, 0.4, 0.5)
    self.map:render()
    self.volcano:render(dt)
    --self.cursor.render()
end
