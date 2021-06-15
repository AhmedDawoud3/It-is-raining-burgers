require "src/Dependencies"

gameWidth, gameHeight = 640, 480 -- fixed game resolution

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle("It’s Raining Burgers!")
    -- seed the RNG so that calls to random are always random
    math.randomseed(os.time())

    -- the state machine we'll be using to transition between various states
    -- in our game instead of clumping them together in our update and draw
    -- methods
    --
    -- our current game state can be any of the following:
    -- 1. 'start' (the beginning of the game, where we're told to press Enter)
    gStateMachine = StateMachine {
        ['start'] = function()
            return StartState()
        end,
        ['play'] = function()
            return PlayState()
        end,
        ['ready'] = function()
            return ReadyState()
        end,
        ['award'] = function()
            return AwardState()
        end,
        ['gameOver'] = function()
            return GameOverState()
        end
    }
    gStateMachine:change('start')

    push:setupScreen(gStateMachine.width, gStateMachine.height, gameWidth, gameHeight, {
        -- fullscreen = true
        resizable = true
    })
    push:resize(love.graphics.getDimensions())
    gTextures = {
        ['background'] = love.graphics.newImage('asset/sprites/background.png'),
        ['lettuce'] = love.graphics.newImage('asset/sprites/lettuce.png'),
        ['lowerBun'] = love.graphics.newImage('asset/sprites/lowerBun.png'),
        ['meat'] = love.graphics.newImage('asset/sprites/meat.png'),
        ['tomato'] = love.graphics.newImage('asset/sprites/tomato.png'),
        ['upperBun'] = love.graphics.newImage('asset/sprites/upperBun.png')
    }

		gAudioManager = AudioManager()

    -- a table we'll use to keep track of which keys have been pressed this
    -- frame, to get around the fact that Love's default callback won't let us
    -- test for input from within other functions
    love.keyboard.keysPressed = {}
    love.mouse.keysPressed = {}
    love.mouse.keysReleased = {}
end

function love.update(dt)
    -- we pass in dt to the state object we're currently using
    gStateMachine:update(dt)

    -- reset keys pressed
    love.keyboard.keysPressed = {}
    love.mouse.keysPressed = {}
    love.mouse.keysReleased = {}
end

function love.draw()
    love.graphics.clear(51/255, 60/255, 87/255)
    push:apply('start')
    gStateMachine:render()
    DisplayFPS()
    push:apply('end')
end

function love.resize(w, h)
    push:resize(w, h)
end

-- HANDLING KEY PRESSING 
--[[
    A callback that processes key strokes as they happen, just the once.
    Does not account for keys that are held down, which is handled by a
    separate function (`love.keyboard.isDown`). Useful for when we want
    things to happen right away, just once, like when we want to quit.
]]
function love.keypressed(key)
    -- add to our table of keys pressed this frame
    love.keyboard.keysPressed[key] = true
end

--[[
    A custom function that will let us test for individual keystrokes outside
    of the default `love.keypressed` callback, since we can't call that logic
    elsewhere by default.
]]

function love.mousepressed(x, y, key)
    love.mouse.keysPressed[key] = true
end

function love.mousereleased(x, y, key)
    love.mouse.keysReleased[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.mouse.wasPressed(key)
    return love.mouse.keysPressed[key]
end

function love.mouse.wasReleased(key)
    return love.mouse.keysReleased[key]
end

function DisplayFPS()
    -- simple FPS display across all states
    love.graphics.setColor(0, 1, 0, 1)
    --love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 5, 5)
    love.graphics.setColor(1, 1, 1, 1)
end
