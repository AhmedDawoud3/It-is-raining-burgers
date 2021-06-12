Ingredient = Class {}

function Ingredient:init(type)
    self.sprite = gTextures[type]

    self.width = self.sprite:getWidth()
    self.height = self.sprite:getHeight()

    self.x = math.random(0, gStateMachine.width - self.width)
    self.y = -self.height
    self.dx = 0
    self.dy = 100
end

function Ingredient:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ingredient:draw()
    love.graphics.draw(self.sprite, self.x, self.y, 0, 2, 2)
end
