-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/game/rule/ArcadeSurvivorGameDupRewardRule.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.game.rule.ArcadeSurvivorGameDupRewardRule", package.seeall)

local ArcadeSurvivorGameDupRewardRule = class("ArcadeSurvivorGameDupRewardRule", ArcadeSurvivorGameBaseRule)

function ArcadeSurvivorGameDupRewardRule:checkCondition(collectionId)
	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()
	local collectionCount = characterMO and characterMO:getCollectionCount(collectionId) or 0
	local paramList = string.splitToNumber(self._typeParam, "#")
	local targetCount = paramList[1] or 0

	return targetCount <= collectionCount
end

function ArcadeSurvivorGameDupRewardRule:onCollectionGained(collectionId)
	local canTrigger = self:checkCondition(collectionId)

	if not canTrigger then
		return
	end

	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()

	if not characterMO then
		return
	end

	local collectionCount = characterMO:getCollectionCount(collectionId)
	local paramList = string.splitToNumber(self._typeParam, "#")
	local gainCoin = paramList[2] or 0
	local gainRespawnTimes = paramList[3] or 0

	ArcadeSurvivorGameController.instance:changeCurrencyCount(ArcadeSurvivorEnum.Currency.Coin, gainCoin)
	ArcadeSurvivorGameController.instance:changeEntityAttr(characterMO:getEntityType(), characterMO:getUid(), ArcadeSurvivorEnum.Attribute.respawnTimes, gainRespawnTimes)
	ArcadeSurvivorGameModel.instance:removeCollection(collectionId, collectionCount)
end

return ArcadeSurvivorGameDupRewardRule
