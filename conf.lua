require 'src/constants/screen_constants'

DEVELOPMENT = true

function love.conf(t)
    if DEVELOPMENT then
        t.console = true
    end

    t.identity = "mountainlab_vesuvius_ld50"
    t.window.title = "Vesuvius"
    -- t.window.icon = "path/to/icon"
    t.window.width = WINDOW_WIDTH
    t.window.height = WINDOW_HEIGHT

    if not DEVELOPMENT then
        -- Disable modules we don't use
        t.modules.joystick = false
        t.modules.physics = false
    end
end