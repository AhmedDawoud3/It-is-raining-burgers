GameOverState = Class {
    __includes = BaseState
}

local font = love.graphics.newFont('asset/fonts/04B_08__.TTF', 30)

function GameOverState:enter(params)
    self.score = params.score
    self.suit = Suit.new()
end

function GameOverState:render()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(font)
    love.graphics.draw(gTextures.background, 0, 0, 0, 4, 4)

    self.suit:draw()

    -- title
    love.graphics.setColor(51 / 255, 60 / 255, 87 / 255)
    -- love.graphics.setFont(font)
    love.graphics.printf("Game Over!", 0, 125, gStateMachine.width, 'center')
    love.graphics.printf("Score :" .. tostring(self.score), 0, 155, gStateMachine.width, 'center')

    -- Press Space to start
    -- love.graphics.printf('Press "Space" to start', 0, gStateMachine.height - 200, gStateMachine.width, 'center')

    -- reset the color
    love.graphics.setColor(1, 1, 1, 1)
end

function GameOverState:update(dt)
    if self.suit:Button('Restart', {
        font = font
    }, 230, 285, 180, 60).hit then
        gStateMachine:change('ready')
    end
    if self.suit:Button('exit', {
        font = font
    }, 230, 385, 180, 60).hit then
        love.event.quit()
    end
end
