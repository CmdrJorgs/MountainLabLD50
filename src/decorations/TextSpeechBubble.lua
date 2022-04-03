TextSpeechBubble = Class{__includes = BaseDecoration}

function TextSpeechBubble:init(params)
    self.text = params.text
    self.fontName = params.fontName or 'small'
    self.x = params.x
    self.y = params.y
    self.duration = params.duration or 6
    self.currentAge = 0
    self.dead = false

    self.font = gFonts[self.fontName]
    self.textWidth = self.font:getWidth(self.text) + TEXT_SPEECH_BUBBLE_PADDING * 2
    self.textHeight = self.font:getHeight() + TEXT_SPEECH_BUBBLE_PADDING * 2
end
function TextSpeechBubble:update(dt)
    self.currentAge = self.currentAge + dt
    self.dead = self.currentAge > self.duration
end
function TextSpeechBubble:render()
    -- TODO: Draw the text bubble surroundings as an actual graphic
    love.graphics.setColor(0.9,0.9,0.8,0.8)
    love.graphics.rectangle('fill', self.x, self.y, self.textWidth, self.textHeight)

    love.graphics.setColor(0,0,0,1)
    love.graphics.setFont(self.font)
    love.graphics.print(self.text, self.x + TEXT_SPEECH_BUBBLE_PADDING, self.y + TEXT_SPEECH_BUBBLE_PADDING)
end