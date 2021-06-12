--[[
    Represents a bun that can move left and right. Used in the main
    program to assamble the burger
]] Bun = Class {}

--[[
    Our Bun will initialize at the same spot every time, in the middle
    of the world horizontally, toward the bottom.
]]
function Bun:init(skin)
    -- "TEMP" photo from the internet
    self.photo = love.graphics.newImage('64353693.png')

    -- starting dimensions
    self.width = self.photo:getWidth() * 0.1
    self.height = self.photo:getHeight() * 0.1

    -- x is placed in the middle
    self.x = math.random(0, 720 - self.width)

    -- y is placed a little above the bottom edge of the screen
    self.y = (720 - 50) - self.height

end

function Bun:update(dt)
    if push:toGame(love.mouse.getPosition())[1] then
        self.x = math.min(math.max(self.width / 2, push:toGame(love.mouse.getPosition())[1]) - self.width / 2,
            gStateMachine.width - self.width)
    end
end

--[[
    Render the Bun by drawing the main texture
]]
function Bun:render()
    love.graphics.draw(self.photo, self.x, self.y, 0, 0.1, 0.1)
end
