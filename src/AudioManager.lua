AudioManager = Class {}

local sounds = {
	['count'] = {
		source = love.audio.newSource('asset/sounds/count.wav', 'static'),
		volume = 0.72,
	},
	['create a burger'] = {
		source = love.audio.newSource('asset/sounds/createABurger.wav', 'static'),
		volume = 0.86,
	},
	['connect an ingredient'] = {
		source = love.audio.newSource('asset/sounds/connectAnIngredient.wav', 'static'),
		volume = 1,
	},
}

function AudioManager:init()
	self.songs = {}
	self.currentSong = nil
	
	self.sounds = sounds
end

function AudioManager:playSound(sound_)
	local sound = self.sounds[sound_]
	if sound ~= nil then
		love.audio.setVolume(sound.volume or 1)
		love.audio.play(sound.source)
	end
end

function AudioManager:playMusic()

end
