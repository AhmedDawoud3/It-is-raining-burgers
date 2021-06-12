-- Represents the state of the game in which we are actively playing;
-- player should control the bun, with his mouse cursor
PlayState = Class {
    __includes = BaseState
}
function PlayState:enter(params)
    self.fallingIngredients = params.fallingIngredients
    -- love.mouse.setVisible(false)
end

function PlayState:update(dt)
    if self.paused then
        if love.keyboard.wasPressed('escape') then
            -- love.mouse.setVisible(false)
            self.paused = false
        else
            return
        end
    elseif love.keyboard.wasPressed('escape') then
        -- love.mouse.setVisible(true)
        self.paused = true
        return
    end
    self.fallingIngredients:update(dt)

end

function PlayState:render()
    -- Background
    love.graphics.setDefaultFilter('linear', 'nearest')
    love.graphics.draw(gTextures['background'], 0, 0, 0, 4, 4)
    
    self.fallingIngredients:draw()
    -- pause text, if paused
    if self.paused then
        love.graphics.printf("PAUSED", 0, gStateMachine.height / 2 - 16, gStateMachine.width, 'center')
    end
end

function PlayState:exit()
    -- love.mouse.setVisible(true)
end
