GameOverState = Class{__includes = BaseState}

function GameOverState:init()

end

function GameOverState:enter(params)

end

function GameOverState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('start')
    end
end

function GameOverState:render()
    love.graphics.clear(0, 0, 0)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf(gText['gameOverText'], 0, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center')
    love.graphics.printf(gText['startScreen'], 0, VIRTUAL_HEIGHT / 2 + 128, VIRTUAL_WIDTH, 'center')
end
