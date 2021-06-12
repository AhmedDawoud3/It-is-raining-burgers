-- Represents the state of the game in which we are actively playing;
-- player should control the bun, with his mouse cursor
PlayState = Class {
    __includes = BaseState
}

function PlayState:enter(params)
    self.bun = params.bun
    love.mouse.setVisible(false)
end

function PlayState:update(dt)
    if self.paused then
        if love.keyboard.wasPressed('escape') then
            love.mouse.setVisible(false)
            self.paused = false
        else
            return
        end
    elseif love.keyboard.wasPressed('escape') then
        love.mouse.setVisible(true)
        self.paused = true
        return
    end
    
    self.bun:update(dt)
end

function PlayState:render()
    -- pause text, if paused
    self.bun:render()
    if self.paused then
        love.graphics.printf("PAUSED", 0, gStateMachine.height / 2 - 16, gStateMachine.width, 'center')
    end
end

function PlayState:exit()
    love.mouse.setVisible(true)
end