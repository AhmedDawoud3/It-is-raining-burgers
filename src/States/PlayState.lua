-- Represents the state of the game in which we are actively playing;
-- player should control the bun, with his mouse cursor

PlayState = Class {
    __includes = BaseState
}


function PlayState:update(dt)
    if self.paused then
        if love.keyboard.wasPressed('escape') then
            self.paused = false
        else
            return
        end
    elseif love.keyboard.wasPressed('escape') then
        self.paused = true
        return
    end

end

function PlayState:render()
    -- pause text, if paused
    if self.paused then
        love.graphics.printf("PAUSED", 0, gStateMachine.height / 2 - 16, gStateMachine.width, 'center')
    end
end
