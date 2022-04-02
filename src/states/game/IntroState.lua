IntroState = Class{__includes = BaseState}

function IntroState:init()

end

function IntroState:enter(params)

end

function IntroState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end
end

function IntroState:render()
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf(gText['introText'], 0, VIRTUAL_HEIGHT / 2 + 128, VIRTUAL_WIDTH, 'center')
end
