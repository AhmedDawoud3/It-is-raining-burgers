StartState = Class {
    __includes = BaseState
}

local font = love.graphics.newFont('asset/fonts/04B_08__.TTF', 30)

function StartState:enter(params)
	self.suit = Suit.new()
	self.suit.theme.color = {
		normal   = {bg = { 0.25, 0.27, 0.3}, fg = {0.72,0.72,0.77}},
		hovered  = {bg = { 0.4, 0.65, 0.73}, fg = {1,1,1}},
		active   = {bg = { 0.8,  0.4,  0.3}, fg = {1,1,1}}
	}
end

function StartState:render()
		love.graphics.setColor(1, 1, 1)
		love.graphics.setFont(font)
		love.graphics.draw(gTextures.background, 0, 0, 0, 4, 4)
		
		self.suit:draw()
		
    -- title
		love.graphics.setColor(51/255, 60/255, 87/255)
		--love.graphics.setFont(font)
    love.graphics.printf("It's Raining Burgers!", 0, 125, gStateMachine.width, 'center')

    -- Press Space to start
    --love.graphics.printf('Press "Space" to start', 0, gStateMachine.height - 200, gStateMachine.width, 'center')

    -- reset the color
    love.graphics.setColor(1, 1, 1, 1)
end

function StartState:update(dt)
		if self.suit:Button('play', {font = font}, 230, 255, 180, 60).hit then
			gStateMachine:change('ready')
		end

end
