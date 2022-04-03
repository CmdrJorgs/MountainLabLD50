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
    -- decorations over the room
    self.decorations = {}
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
    local function generate_speech_bubble(text)
        table.insert(s.decorations, TextSpeechBubble{
            text = text,
            x = VIRTUAL_WIDTH * 2 / 3,
            y = GROUND_HEIGHT / 2,
            fontName = 'small',
        })
    end
    return {
        -- Called when the volcano is satisfied with its offerings
        report_satisfied = function(craving, offering)
            generate_speech_bubble('That was finger-lickin good')
        end,
        -- Called when the volcano is given something it did not want
        report_non_matching_offering = function(offering)
            generate_speech_bubble('That was not what I wanted')
        end,
        -- Called when the volcano is given something undesirable,
        -- such as a sick animal
        report_defective_offering = function(offering)
            generate_speech_bubble('That was gross, man')
        end,
        report_exploding = function()
            table.insert(s.decorations, VolcanoScreenWipe{})
        end
    }
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('start')
    end

    self.volcano:update(dt)
    if self.volcano:is_exploded() then
        gStateMachine:change("gameOver")
    end

    self.map:update(dt)

    self.cursor:update(dt)

    filter_in_place(self.decorations, function(d) return not d.dead end)
    for k, decoration in pairs(self.decorations) do
        decoration:update(dt)
    end
end

function PlayState:processAI(params, dt)
    self.volcano:processAI(params, dt)
end

function PlayState:render()
    love.graphics.clear(0, 198/255, 266/255)
    self.volcano:render()
    self.map:render()
    self.cursor:render()
    for k, decoration in pairs(self.decorations) do
        decoration:render()
    end
end
