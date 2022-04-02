require 'src/Dependencies'

development = true

if development then
    function love.conf(t)
        t.console = true
    end
end

function love.load()
    math.randomseed(os.time())
    love.window.setTitle('Vesuvius')
    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })

    love.graphics.setFont(gFonts['small'])

    gStateMachine = StateMachine {
        ['start'] = function() return StartState() end,
        ['intro'] = function() return IntroState() end,
        ['play'] = function() return PlayState() end,
        ['gameOver'] = function() return GameOverState() end,
    }
    gStateMachine:change('start')

    --gSounds['music']:setLooping(true)
    --gSounds['music']:play()

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    Timer.update(dt)
    gStateMachine:update(dt)
    gStateMachine:processAI({}, dt)

    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
    gStateMachine:render()
    push:finish()
end
