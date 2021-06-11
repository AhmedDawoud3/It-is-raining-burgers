require "src/Dependencies"

gameWidth, gameHeight = 1080, 720 -- fixed game resolution

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
        end
    }
    gStateMachine:change('start')

    push:setupScreen(gStateMachine.width, gStateMachine.height, gameWidth, gameHeight, {
        resizable = true
    })

    -- a table we'll use to keep track of which keys have been pressed this
    -- frame, to get around the fact that Love's default callback won't let us
    -- test for input from within other functions
    love.keyboard.keysPressed = {}
end

function love.update(dt)
    -- we pass in dt to the state object we're currently using
    gStateMachine:update(dt)

    -- reset keys pressed
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:apply('start')
    gStateMachine:render()
    push:apply('end')
    DisplayFPS()
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
function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

function DisplayFPS()
    -- simple FPS display across all states
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 5, 5)
    love.graphics.setColor(1, 1, 1, 1)
end
