FallingIngredients = Class {}

function FallingIngredients:init()
    self.ingredients = {'tomato', 'meat', 'lettuce', 'upperBun', 'lowerBun'}
    self.falling = {}
    self.selectedIngredients = {}
end

function FallingIngredients:update(dt)

    if love.mouse.wasReleased(1) then
        if #self.selectedIngredients > 1 then
            gStateMachine:change('award', {
                fallingIngredients = gStateMachine.current.fallingIngredients,
                selectedIngredients = self.selectedIngredients,
                effectManager = gStateMachine.current.effectManager,
                falling = self.falling,
                score = gStateMachine.current.score
            })
            for i = #self.falling, 1, -1 do
                v = self.falling[i]
                for _, q in ipairs(self.selectedIngredients) do
                    if v == q then
                        table.remove(self.falling, i)
                    end
                end
            end
        end
        self.selectedIngredients = {}
        return
    end
    if math.random() < 0.05 then
        local a = self.ingredients[math.random(1, #self.ingredients)]
        table.insert(self.falling, Ingredient(a))
    end
    for i, v in ipairs(self.falling) do
        v:update(dt)
        v.marked = v:checkMouse(push:toGame(love.mouse.getX(), love.mouse.getY())[1] or 0,
            push:toGame(love.mouse.getX(), love.mouse.getY())[2] or 0)
        v.selected = false
        if love.mouse.isDown(1) and v.marked and not hasValue(self.selectedIngredients, v) then
            table.insert(self.selectedIngredients, v)
            v.selected = true
            
            gAudioManager:playSound('connect an ingredient')
        end
    end
    if #self.falling > 0 then
        for i = #self.falling, 1, -1 do
            if self.falling[i].y > gStateMachine.height + 16 then
                table.remove(self.falling, i)
                if hasValue(self.selectedIngredients, self.falling[i]) then
                    table.remove(self.selectedIngredients, hasValue(self.selectedIngredients, self.falling[i])[2])
                end
            end
        end
    end
    for i = #self.selectedIngredients, 1, -1 do
        self.selectedIngredients[i].selected = true
        if self.selectedIngredients[i].y > gStateMachine.height + 16 then
            table.remove(self.selectedIngredients, i)
        end
    end

end

function FallingIngredients:draw()
    local v = {}
    for i, q in ipairs(self.selectedIngredients) do
        table.insert(v, q.x + 16)
        table.insert(v, q.y + 16)
    end
    if #v > 3 then
        love.graphics.setLineWidth(5)
        love.graphics.line(v)
    end
    for i, v in ipairs(self.falling) do
        v:draw()
    end
end

function hasValue(table, val)
    for index, value in ipairs(table) do
        if value == val then
            return {true, index}
        end
    end
    return false
end
