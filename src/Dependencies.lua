-- UI lib
Suit = require 'lib/suit'

-- Timing stuff
Timer = require 'lib/timer'

-- https://github.com/Ulydev/push
push = require 'lib/push'

-- the "Class" library we're using will allow us to represent anything in
-- our game as code, rather than keeping track of many disparate variables and
-- methods

-- https://github.com/vrld/hump/blob/master/class.lua
Class = require 'lib/class'

require 'src/StateMachine'

require 'src/FallingIngredients'
require 'src/Ingredient'
require 'src/EffectManager'
require 'src/AudioManager'

require 'src/States/BaseState'
require 'src/States/StartState'
require 'src/States/PlayState'
require 'src/States/ReadyState'
require 'src/States/AwardState'
require 'src/States/GameOverState'
