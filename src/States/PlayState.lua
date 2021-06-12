-- Represents the state of the game in which we are actively playing;
-- player should control the bun, with his mouse cursor
PlayState = Class {
    __includes = BaseState
}

local font = love.graphics.newFont('asset/fonts/04B_03B_.TTF', 30)

function PlayState:enter(params)
    self.fallingIngredients = params.fallingIngredients
    self.score = params.score
    self.timeIncrement = 0
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

    self.timeIncrement = self.timeIncrement + dt
    if self.timeIncrement > 1 then
        gStateMachine.timer = gStateMachine.timer + 1
        self.timeIncrement = self.timeIncrement % 1
    end
    if gStateMachine.timer > 30 then
        gStateMachine.timer = 0
        gStateMachine:change('gameOver', {
            score = self.score
        })
    end
end

function PlayState:render()
    -- Background
    love.graphics.setDefaultFilter('linear', 'nearest')
    love.graphics.draw(gTextures['background'], 0, 0, 0, 4, 4)

    -- love.graphics.setDefaultFilter('nearest', 'nearest')
    self.fallingIngredients:draw()
    love.graphics.setFont(font)
    love.graphics.setColor(51 / 255, 60 / 255, 87 / 255)
    love.graphics.print("Score :" .. self.score, gStateMachine.width - 150, 10)
    love.graphics.print("Time Left :" .. 30 - gStateMachine.timer, 10, 10)
    -- pause text, if paused
    if self.paused then
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.printf("PAUSED", 0, gStateMachine.height / 2 - 16, gStateMachine.width, 'center')
    end
end

function PlayState:exit()
    -- love.mouse.setVisible(true)
end
