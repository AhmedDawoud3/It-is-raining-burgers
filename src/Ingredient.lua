Ingredient = Class {}

shader = love.graphics.newShader [[
extern float WhiteFactor;

vec4 effect(vec4 vcolor, Image tex, vec2 texcoord, vec2 pixcoord)
{
    vec4 outputcolor = Texel(tex, texcoord) * vcolor;
    outputcolor.rgb += vec3(WhiteFactor);
    return outputcolor;
}
]]

function Ingredient:init(type)
    self.sprite = gTextures[type]

    self.width = self.sprite:getWidth()
    self.height = self.sprite:getHeight()

    self.x = math.random(0, gStateMachine.width - self.width)
    self.y = -self.height
    self.dx = 0
    self.dy = 100
    self.marked = false
end

function Ingredient:update(dt)

    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end
function Ingredient:draw()

    if self.marked then
        love.graphics.setShader(shader)
        shader:send("WhiteFactor", 1)
        love.graphics.draw(self.sprite, self.x - self.width / 3.5, self.y - self.height / 3.5, 0, 2.5, 2.5)
        love.graphics.setShader()
    end
    love.graphics.draw(self.sprite, self.x, self.y, 0, 2, 2)
end

function Ingredient:checkMouse(mouseX, mouseY)
    if mouseX > self.x and mouseX < self.x + self.width * 2 and mouseY > self.y and mouseY < self.y + self.height * 2 then
        return true
    end
    return false
end
