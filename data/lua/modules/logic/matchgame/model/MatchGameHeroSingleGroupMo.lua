-- chunkname: @modules/logic/matchgame/model/MatchGameHeroSingleGroupMo.lua

module("modules.logic.matchgame.model.MatchGameHeroSingleGroupMo", package.seeall)

local MatchGameHeroSingleGroupMo = pureTable("MatchGameHeroSingleGroupMo")

function MatchGameHeroSingleGroupMo:ctor()
	self.id = 0
	self.posIndex = 0
end

function MatchGameHeroSingleGroupMo:initData(posIndex, id, heroMo)
	self.posIndex = posIndex
	self.id = id
	self.heroMo = heroMo
	self.heroId = self.heroMo and self.heroMo.heroId
end

function MatchGameHeroSingleGroupMo:getLevel()
	return self.heroMo and self.heroMo.level
end

function MatchGameHeroSingleGroupMo:getAttrValue(attrType)
	return self.heroMo and self.heroMo:getAttrValue(attrType)
end

function MatchGameHeroSingleGroupMo:isTrial()
	return self.id < 0
end

return MatchGameHeroSingleGroupMo
