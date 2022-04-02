StartState = Class{__includes = BaseState}

function StartState:init()

end

function StartState:enter(params)

end

function StartState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('intro')
    end
end

function StartState:render()
    -- graphic, x, y, rot, scalex, scaley, offsetx, offsety,
    love.graphics.draw(gTextures['badge'], VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2, 0, 1, 1,
        gTextures['badge']:getWidth() / 2,
        gTextures['badge']:getHeight() / 2)

    -- love.graphics.setFont(gFonts['gothic-medium'])
    -- love.graphics.printf('Legend of', 0, VIRTUAL_HEIGHT / 2 - 32, VIRTUAL_WIDTH, 'center')

    -- love.graphics.setFont(gFonts['gothic-large'])
    -- love.graphics.printf('50', 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')

    --love.graphics.setFont(gFonts['zelda'])
    --love.graphics.setColor(34, 34, 34, 255)
    --love.graphics.printf('Legend of 50', 2, VIRTUAL_HEIGHT / 2 - 30, VIRTUAL_WIDTH, 'center')
    --
    --love.graphics.setColor(175, 53, 42, 255)
    --love.graphics.printf('Legend of 50', 0, VIRTUAL_HEIGHT / 2 - 32, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf(gText['startScreen'], 0, VIRTUAL_HEIGHT / 2 + 128, VIRTUAL_WIDTH, 'center')
end
