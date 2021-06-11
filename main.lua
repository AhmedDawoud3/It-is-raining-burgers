require "src/Dependencies"

local gameWidth, gameHeight = 1080, 720 -- fixed game resolution

function love.load()
    love.window.setTitle("It’s Raining Burgers!")
    push:setupScreen(gameWidth, gameHeight, gameWidth, gameHeight)
end

function love.update(dt)

end

function love.draw()

end

function love.resize(w, h)
    push:resize(w, h)
end