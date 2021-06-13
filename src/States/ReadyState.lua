ReadyState = Class {
    __includes = BaseState
}

local font = love.graphics.newFont('asset/fonts/04B_08__.TTF', 70)

function ReadyState:enter(params)
	self.timer = 0
	self.timeIncrement = 0
	
	gAudioManager:playSound('count')
end

function ReadyState:render()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(font)
    love.graphics.draw(gTextures.background, 0, 0, 0, 4, 4)

    -- title
    love.graphics.setColor(51 / 255, 60 / 255, 87 / 255)
    -- love.graphics.setFont(font)
    love.graphics.printf(tostring(3 - self.timer), 0, gStateMachine.height / 2 - 32, gStateMachine.width, 'center')

    -- reset the color
    love.graphics.setColor(1, 1, 1, 1)
end

function ReadyState:update(dt)
    self.timeIncrement = self.timeIncrement + dt
    if self.timeIncrement > 1 then
        self.timer = self.timer + 1
        self.timeIncrement = self.timeIncrement % 1
        
        if self.timer ~= 3 then
					gAudioManager:playSound('count')
				end
    end
    if self.timer == 3 then
        gStateMachine:change('play', {
            fallingIngredients = FallingIngredients(),
						effectManager = EffectManager(),
						score = 0,
        })
    end
end
