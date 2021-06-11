StartState = Class {
    __includes = BaseState
}

function StartState:render()
    -- title
    love.graphics.print("It's Raining Burgers!", gStateMachine.width / 2 - 64, 100)

    -- Press Space to start
    love.graphics.print('Press "Space" to start', gStateMachine.width / 2 - 64, gStateMachine.height - 200)

    -- reset the color
    love.graphics.setColor(1, 1, 1, 1)
end

function StartState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        -- gStateMachine:change('Hello')
    end

    if love.keyboard.wasPressed('enter') then
        love.event.quit()
    end
end
