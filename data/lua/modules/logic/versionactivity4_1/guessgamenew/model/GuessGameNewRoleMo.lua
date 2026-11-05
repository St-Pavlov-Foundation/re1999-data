-- chunkname: @modules/logic/versionactivity4_1/guessgamenew/model/GuessGameNewRoleMo.lua

module("modules.logic.versionactivity4_1.guessgamenew.model.GuessGameNewRoleMo", package.seeall)

local GuessGameNewRoleMo = pureTable("GuessGameNewRoleMo")

function GuessGameNewRoleMo:init(type)
	self.roleType = type
	self.npcId = 0
	self.npcConfig = nil
	self.hp = GuessGameNewConfig.instance:getConstNumberValue(GuessGameNewEnum.ConstId.LifeValue)
	self.gifts = {}
	self.selectGifts = {}
	self.revealedGiftIndexs = {}
	self.bluffSuccessTimes = 0
	self.bluffFailTimes = 0
	self.guessSuccessTimes = 0
	self.guessFailTimes = 0
	self.truthStreak = 0
	self.doubtedStreak = 0
	self.lastPlayIsReal = nil
	self.playTimes = 0
	self.fakePlayTimes = 0
	self.realPlayTimes = 0
end

function GuessGameNewRoleMo:getRoleType()
	return self.roleType
end

function GuessGameNewRoleMo:setNpc(npcId)
	if self.roleType == GuessGameNewEnum.RoleType.Player then
		return
	end

	self.npcId = npcId
	self.npcConfig = GuessGameNewConfig.instance:getNpcCo(npcId)
end

function GuessGameNewRoleMo:getNpcId()
	return self.npcId
end

function GuessGameNewRoleMo:getNpcConfig()
	return self.npcConfig
end

function GuessGameNewRoleMo:reduceHp()
	if not self.hp then
		return
	end

	self.hp = self.hp - 1

	if self.hp <= 0 then
		self.hp = 0
	end
end

function GuessGameNewRoleMo:setGifts(gifts)
	self.gifts = gifts
end

function GuessGameNewRoleMo:setGiftsSelect(selectGifts)
	self.selectGifts = selectGifts
end

function GuessGameNewRoleMo:resetGiftsState()
	self.selectGifts = {}
	self.revealedGiftIndexs = {}
end

function GuessGameNewRoleMo:addRevealedGiftIndexs(indexs)
	for _, index in pairs(indexs or {}) do
		self.revealedGiftIndexs[index] = true
	end
end

function GuessGameNewRoleMo:isGiftIndexRevealed(index)
	return self.revealedGiftIndexs[index] == true
end

function GuessGameNewRoleMo:setBluffSuccessTime(times)
	self.bluffSuccessTimes = self.bluffSuccessTimes + times
end

function GuessGameNewRoleMo:setBluffFailTime(times)
	self.bluffFailTimes = self.bluffFailTimes + times
end

function GuessGameNewRoleMo:setGuessSuccessTime(times)
	self.guessSuccessTimes = self.guessSuccessTimes + times
end

function GuessGameNewRoleMo:setGuessFailTime(times)
	self.guessFailTimes = self.guessFailTimes + times
end

function GuessGameNewRoleMo:getFailTimes()
	return self.bluffFailTimes + self.guessFailTimes
end

return GuessGameNewRoleMo
