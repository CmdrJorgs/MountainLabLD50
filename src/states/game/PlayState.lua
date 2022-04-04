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
    local s = self
    local function generate_speech_bubble(text)
        table.insert(s.decorations, TextSpeechBubble{
            text = text,
            x = math.random() / 3 * VIRTUAL_WIDTH,
            y = math.random() / 2 * GROUND_HEIGHT,
            fontName = 'small',
        })
    end
    local function get_offering_text(response_type, offering)
        local offering_species = offering.species
        local defaults = gVolcanoFeedbackText[response_type]['default']
        local specifics = gVolcanoFeedbackText[response_type][offering_species] or {}
        local i = math.random(#defaults + #specifics)
        if i > #defaults then
            return specifics[i - #defaults]
        else
            return defaults[i]
        end
    end
    return {
        -- Called when the volcano is satisfied with its offerings
        report_satisfied = function(self, craving, offering)
            generate_speech_bubble(get_offering_text('satisfied', offering))
        end,
        -- Called when the volcano is given something it did not want
        report_non_matching_offering = function(self, offering)
            generate_speech_bubble(get_offering_text('non-matching', offering))
        end,
        -- Called when the volcano is given something and it has no outstanding cravings
        report_dont_want_anything = function(self, offering)
            generate_speech_bubble(get_offering_text('dont-want-anything', offering))
        end,
        -- Called when the volcano is given something undesirable,
        -- such as a sick animal
        report_defective_offering = function(self, offering)
            generate_speech_bubble(get_offering_text('bad-offering', offering))
        end,
        -- Called when the volcano explodes
        report_exploding = function(self)
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
