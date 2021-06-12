StartState = Class {
    __includes = BaseState
}

love.graphics.setDefaultFilter('nearest', 'nearest')
local background = love.graphics.newImage('asset/sprites/background.png')
local font = love.graphics.newFont('asset/fonts/04B_08__.TTF', 30)

function StartState:enter(params)
	self.suit = Suit.new()
end

function StartState:render()
		love.graphics.setColor(1, 1, 1)
		love.graphics.draw(background, 0, 0, 0, 4, 4)
		
		self.suit:draw()
		
    -- title
		love.graphics.setColor(51/255, 60/255, 87/255)
		love.graphics.setFont(font)
    love.graphics.printf("It's Raining Burgers!", 0, 125, gStateMachine.width, 'center')

    -- Press Space to start
    --love.graphics.printf('Press "Space" to start', 0, gStateMachine.height - 200, gStateMachine.width, 'center')

    -- reset the color
    love.graphics.setColor(1, 1, 1, 1)
end

function StartState:update(dt)
		if self.suit:Button('play', 230, 285, 180, 60).hit then
			gStateMachine:change('play', {bun = Bun()})
		end
		
    --if love.keyboard.wasPressed('space') then
        --gStateMachine:change('play', {bun = Bun()})
    --end

    if love.keyboard.wasPressed('enter') then
        love.event.quit()
    end
end
