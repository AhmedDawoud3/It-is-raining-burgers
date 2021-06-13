AwardState = Class {
    __includes = BaseState
}
local font = love.graphics.newFont('asset/fonts/04B_08__.TTF', 30)

function AwardState:enter(params)
    self.selectedIngredients = SortBurger(params.selectedIngredients)
    self.fallingIngredients = params.fallingIngredients
    self.falling = params.falling
    self.effectManager = params.effectManager
    self.score = params.score
    self._y = 25
    self.rating, self.comment = RateBurger(self.selectedIngredients)[1], RateBurger(self.selectedIngredients)[2]
    self.score = self.score + self.rating
    
    gAudioManager:playSound('create a burger')
end

function AwardState:update(dt)
    self._y = math.max(0, self._y - dt * 10)

    if self._y == 0 and math.random(0, 10) == 1 then
        gStateMachine:change('play', {
            fallingIngredients = self.fallingIngredients,
            effectManager = self.effectManager,
            score = self.score
        })
    end
end

function AwardState:render()
    -- Background
    love.graphics.setDefaultFilter('linear', 'nearest')
    love.graphics.draw(gTextures['background'], 0, 0, 0, 4, 4)

    for i, v in ipairs(self.falling) do
        v:draw()
    end

    love.graphics.setColor(0.3, 0.3, 0.3, 0.3)
    love.graphics.rectangle('fill', 0, 0, gStateMachine.width, gStateMachine.height)
    love.graphics.setColor(1, 1, 1, 1)

    for i = #self.selectedIngredients, 1, -1 do
        self.selectedIngredients[i]:drawCustom(gStateMachine.width / 2 - 32,
            gStateMachine.height / 2 - 100 + i * (10 + self._y), 4, 4)
    end
    love.graphics.setFont(font)
    love.graphics.printf("Rating: " .. (self.rating / 10) .. "%", 0, gStateMachine.height - 150, gStateMachine.width,
        'center')
    love.graphics.printf(self.comment, 0, gStateMachine.height - 100, gStateMachine.width, 'center')
end

function AwardState:exit()
    -- love.mouse.setVisible(true)
end

function SortBurger(selectedIngredients)
    sorted = {}

    for i, v in ipairs(selectedIngredients) do
        if v.type == "upperBun" then
            table.insert(sorted, v)
        end
    end
    for i, v in ipairs(selectedIngredients) do
        if v.type ~= "lowerBun" and v.type ~= "upperBun" then
            table.insert(sorted, v)
        end
    end
    for i, v in ipairs(selectedIngredients) do
        if v.type == "lowerBun" then
            table.insert(sorted, v)
        end
    end
    return sorted
end

-- To rate the burgers
function RateBurger(selectedIngredients)
    local lettuceCount = 0
    local lowerBunCount = 0
    local meatCount = 0
    local tomatoCount = 0
    local upperBunCount = 0
    local overallCount = 0
    local comment = ''

    for i, v in ipairs(selectedIngredients) do
        if v.type == "lowerBun" then
            lowerBunCount = lowerBunCount + 1
        end
        if v.type == "lettuce" then
            lettuceCount = lettuceCount + 1
        end
        if v.type == "upperBun" then
            upperBunCount = upperBunCount + 1
        end
        if v.type == "meat" then
            meatCount = meatCount + 1
        end
        if v.type == "tomato" then
            tomatoCount = tomatoCount + 1
        end
    end

    if upperBunCount == 1 then
        overallCount = overallCount + 100
    elseif upperBunCount < 1 then
        comment = "You forgot the upper bun!"
    elseif upperBunCount > 1 then
        return {0, "You can't have more than one upper bun!"}
    end
    if lowerBunCount == 1 then
        overallCount = overallCount + 100
    elseif lowerBunCount < 1 then
        comment = "You forgot the lower bun!"
    elseif lowerBunCount > 1 then
        return {0, "You can't have more than one lower bun!"}
    end

    if lowerBunCount == upperBunCount and upperBunCount == 0 then
        comment = "You forgot the Bread!!!"
    end

    -- Lettuce only Case
    if AllZeros({meatCount, tomatoCount, upperBunCount, lowerBunCount}) then
        comment = "Lettuce!!!! But why"
    end

    -- Tomato only Case
    if AllZeros({meatCount, lettuceCount, upperBunCount, lowerBunCount}) then
        comment = "People want food not Tomato"
    end

    -- Tomato only Case
    if AllZeros({meatCount}) and overallCount > 100 then
        if lettuceCount > 0 and tomatoCount > 0 then
            return {700 + math.random(50, 100), "A vegan choice"}
        end
        return {650 + math.random(0, 50), "A vegan choice"}
    end

    if lowerBunCount == upperBunCount and upperBunCount == 1 then
        overallCount = overallCount + math.random(40, 50)
    end

    if (meatCount / tomatoCount) < 2 and (meatCount / tomatoCount) > 1 then
        overallCount = overallCount + 100 + math.random(40, 50)
    end

    if (meatCount / lettuceCount) < 2 and (meatCount / lettuceCount) > 1 then
        overallCount = overallCount + 100 + math.random(40, 50)
    end

    if meatCount > 0 and upperBunCount == 1 and lowerBunCount == 1 then
        if AllZeros({tomatoCount, lettuce}) then
            return {800 + math.random(0, 100), "Try adding some tomatos and lettuce"}
        end
        goodWords = {'nice', 'well done', 'good', 'tasty', 'delicious'}
        comment = goodWords[math.random(#goodWords)]
        overallCount = 950 + math.random(0, 50)
    end

    return {overallCount, comment}

end

function AllZeros(table)
    for i, v in ipairs(table) do
        if v ~= 0 then
            return false
        end
    end
    return true
end
