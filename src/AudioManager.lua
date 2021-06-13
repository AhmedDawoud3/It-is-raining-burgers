AudioManager = Class {}

local sounds = {
	['count'] = love.audio.newSource('asset/sounds/count.wav', 'static'),
	['create a burger'] = love.audio.newSource('asset/sounds/createABurger.wav', 'static'),
	['connect an ingredient'] = love.audio.newSource('asset/sounds/connectAnIngredient.wav', 'static'),
}
sounds['count']:setVolume(0.72)
sounds['create a burger']:setVolume(0.86)
sounds['connect an ingredient']:setVolume(1)

local songs = {
	['main theme'] = love.audio.newSource('asset/sounds/Shiny.mp3', 'static'),
}
songs['main theme']:setVolume(0.76)

function AudioManager:init()
	self.songs = songs
	self.currentSong = nil
	
	self.sounds = sounds
end

function AudioManager:playSound(sound_)
	local sound = self.sounds[sound_]
	if sound ~= nil then
		love.audio.play(sound)
	end
end

function AudioManager:playSong(song_)
	local song = self.songs[song_]

	if song ~= nil then
		if self.currentSong ~= nil then
			love.audio.stop(self.currentSong)
		end
		self.currentSong = song
		
		love.audio.play(self.currentSong)
		self.currentSong:setLooping(true)
	end
end

function AudioManager:stopSong(waitUntilEnd)
	if not waitUntilEnd then
		love.audio.stop(self.currentSong)
		
	elseif waitUntilEnd then
		self.currentSong:setLooping(false)
	end
end
