FallingIngredients = Class {}

function FallingIngredients:init()
    self.ingredients = {'tomato', 'meat', 'lettuce', 'upperBun', 'lowerBun'}
    self.falling = {}
end

function FallingIngredients:update(dt)
    if math.random() < 0.05 then
        local a = self.ingredients[math.random(1, #self.ingredients)]
        table.insert(self.falling, Ingredient(a))
    end
    for i, v in ipairs(self.falling) do
        v:update(dt)
    end
    if #self.falling > 0 then
        for i = #self.falling, 1 do
            if self.falling[i].y > gStateMachine.height then
                table.remove(self.falling, i)
            end
        end
    end
end

function FallingIngredients:draw()
    for i, v in ipairs(self.falling) do
        v:draw()
    end
end
