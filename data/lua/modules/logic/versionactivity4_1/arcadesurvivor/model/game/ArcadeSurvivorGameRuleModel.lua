-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/game/ArcadeSurvivorGameRuleModel.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.game.ArcadeSurvivorGameRuleModel", package.seeall)

local ArcadeSurvivorGameRuleModel = class("ArcadeSurvivorGameRuleModel")

function ArcadeSurvivorGameRuleModel:ctor()
	self._ruleItemDict = {}
end

function ArcadeSurvivorGameRuleModel:_addRule(ruleId)
	local ruleItem = self._ruleItemDict[ruleId]

	if not ruleItem then
		local ruleType = ArcadeSurvivorConfig.instance:getCollectionRuleType(ruleId)
		local cls = ruleType and ArcadeSurvivorGameEnum.RuleTypeCls[ruleType]

		if not cls then
			logError(string.format("ArcadeSurvivorGameRuleModel._addRule error, rule cls is nil, ruleId:%s type:%s", ruleId, ruleType))

			return
		end

		ruleItem = cls.New(ruleId)

		if ArcadeSurvivorGameEnum.RuleTypeOnceApply[ruleType] then
			ruleItem:applyOnceOnGain()
		else
			self._ruleItemDict[ruleId] = ruleItem
		end
	end

	return ruleItem
end

function ArcadeSurvivorGameRuleModel:_readdRule(ruleId, sourceType, sourceId, sourceCount)
	local ruleType = ArcadeSurvivorConfig.instance:getCollectionRuleType(ruleId)

	if ArcadeSurvivorGameEnum.RuleTypeOnceApply[ruleType] then
		return
	end

	local ruleItem = self:_addRule(ruleId)

	if ruleItem then
		ruleItem:addSource(sourceType, sourceId, sourceCount)
	end
end

function ArcadeSurvivorGameRuleModel:rebuildFromCharacter()
	self._ruleItemDict = {}

	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()

	if not characterMO then
		return
	end

	for _, collectionId in ipairs(characterMO:getCollectionIdList()) do
		local ruleIdList = ArcadeSurvivorConfig.instance:getCollectionRuleIdList(collectionId)
		local collectionCount = characterMO:getCollectionCount(collectionId)

		for _, ruleId in ipairs(ruleIdList) do
			self:_readdRule(ruleId, ArcadeSurvivorGameEnum.RuleSourceType.Collection, collectionId, collectionCount)
		end
	end
end

function ArcadeSurvivorGameRuleModel:rebuildFromEventIdList()
	local eventIdList = ArcadeSurvivorGameModel.instance:getEventIdList()

	if not eventIdList then
		return
	end

	for _, eventId in ipairs(eventIdList) do
		local ruleIdList = ArcadeSurvivorConfig.instance:getEventRuleIdList(eventId)

		for _, ruleId in ipairs(ruleIdList) do
			self:_readdRule(ruleId, ArcadeSurvivorGameEnum.RuleSourceType.Event, eventId)
		end
	end
end

function ArcadeSurvivorGameRuleModel:restoreSourceStateDict(stateDict)
	if not stateDict then
		return
	end

	for ruleId, sourceStateDict in pairs(stateDict) do
		local ruleItem = self._ruleItemDict[ruleId]

		if ruleItem then
			for sourceType, typeStateDict in pairs(sourceStateDict) do
				for sourceId, state in pairs(typeStateDict) do
					ruleItem:setSourceState(sourceType, sourceId, state)
				end
			end
		end
	end
end

function ArcadeSurvivorGameRuleModel:getRuleSaveStateList()
	local result = {}

	for ruleId, ruleItem in pairs(self._ruleItemDict) do
		local hasRuleItem = ruleItem ~= nil

		if hasRuleItem then
			local sourceStateList = ruleItem:getSaveSourceStateList()
			local hasState = #sourceStateList > 0

			if hasState then
				result[#result + 1] = {
					ruleId = ruleId,
					sources = sourceStateList
				}
			end
		end
	end

	return result
end

function ArcadeSurvivorGameRuleModel:onEventRuleGained(ruleId, eventId)
	if not ruleId or not eventId then
		return
	end

	local ruleItem = self:_addRule(ruleId)

	if ruleItem then
		ruleItem:addSource(ArcadeSurvivorGameEnum.RuleSourceType.Event, eventId)
		ruleItem:onEventGained(eventId)
	end
end

function ArcadeSurvivorGameRuleModel:onCollectionGained(collectionId)
	if not collectionId then
		return
	end

	local ruleIdList = ArcadeSurvivorConfig.instance:getCollectionRuleIdList(collectionId)

	for _, ruleId in ipairs(ruleIdList) do
		local ruleItem = self:_addRule(ruleId)

		if ruleItem then
			ruleItem:addSource(ArcadeSurvivorGameEnum.RuleSourceType.Collection, collectionId)
			ruleItem:onCollectionGained(collectionId)
			ArcadeSurvivorGameController.instance:dispatchEvent(ArcadeSurvivorEvent.OnGameCollectionRuleChange, collectionId, ruleId)
		end
	end
end

function ArcadeSurvivorGameRuleModel:onCollectionRemoved(collectionId, count)
	local removeCount = count or 1

	for ruleId, ruleItem in pairs(self._ruleItemDict) do
		local sourceCount = ruleItem and ruleItem:getSourceCount(ArcadeSurvivorGameEnum.RuleSourceType.Collection, collectionId) or 0

		if sourceCount > 0 then
			ruleItem:onCollectionRemoved(collectionId, removeCount)
			ruleItem:removeSource(ArcadeSurvivorGameEnum.RuleSourceType.Collection, collectionId, removeCount)
			self:_checkRuleEmpty(ruleId)
			ArcadeSurvivorGameController.instance:dispatchEvent(ArcadeSurvivorEvent.OnGameCollectionRuleChange, collectionId, ruleId)
		end
	end
end

function ArcadeSurvivorGameRuleModel:_checkRuleEmpty(ruleId)
	local ruleItem = self._ruleItemDict[ruleId]
	local hasSource = ruleItem and ruleItem:hasSource()

	if not hasSource then
		self._ruleItemDict[ruleId] = nil
	end
end

function ArcadeSurvivorGameRuleModel:onShopClosed()
	for _, ruleItem in pairs(self._ruleItemDict) do
		ruleItem:onShopClosed()
	end
end

function ArcadeSurvivorGameRuleModel:onGoodsPurchased(price, currencyId)
	for _, ruleItem in pairs(self._ruleItemDict) do
		ruleItem:onGoodsPurchased(price, currencyId)
	end
end

function ArcadeSurvivorGameRuleModel:onEnterLevel()
	for _, ruleItem in pairs(self._ruleItemDict) do
		ruleItem:onEnterLevel()
	end
end

function ArcadeSurvivorGameRuleModel:getShopId()
	for _, ruleItem in pairs(self._ruleItemDict) do
		if ruleItem.getShopId then
			local shopId = ruleItem:getShopId()

			if shopId then
				return shopId
			end
		end
	end
end

function ArcadeSurvivorGameRuleModel:getShopRefreshExtra()
	local result = 0

	for _, ruleItem in pairs(self._ruleItemDict) do
		if ruleItem.getShopRefreshExtra then
			local count = ruleItem:getShopRefreshExtra()

			if count then
				result = result + count
			end
		end
	end

	return result
end

function ArcadeSurvivorGameRuleModel:adjustShopWeightList(weightList)
	local resultList = weightList

	for _, ruleItem in pairs(self._ruleItemDict) do
		if ruleItem.adjustShopWeightList then
			local adjustWeightList = ruleItem:adjustShopWeightList(resultList)

			if adjustWeightList then
				resultList = adjustWeightList
			end
		end
	end

	return resultList
end

function ArcadeSurvivorGameRuleModel:getShopDiscountPercent()
	local result = 0

	for _, ruleItem in pairs(self._ruleItemDict) do
		if ruleItem.getShopDiscountPercent then
			local discountPercent = ruleItem:getShopDiscountPercent()

			if discountPercent then
				result = result + discountPercent
			end
		end
	end

	return result
end

function ArcadeSurvivorGameRuleModel:getCoinPerHp()
	for _, ruleItem in pairs(self._ruleItemDict) do
		if ruleItem.getCoinPerHp then
			local coinPerHp = ruleItem:getCoinPerHp()

			if coinPerHp and coinPerHp > 0 then
				return coinPerHp
			end
		end
	end
end

function ArcadeSurvivorGameRuleModel:getPackSelectableCount()
	for _, ruleItem in pairs(self._ruleItemDict) do
		if ruleItem.getPackSelectableCount then
			local opCount = ruleItem:getPackSelectableCount()

			if opCount then
				return opCount
			end
		end
	end
end

function ArcadeSurvivorGameRuleModel:getCharacterTurnTime()
	for _, ruleItem in pairs(self._ruleItemDict) do
		if ruleItem.getCharacterTurnTime then
			local time = ruleItem:getCharacterTurnTime()

			if time then
				return time
			end
		end
	end
end

function ArcadeSurvivorGameRuleModel:getMonsterSpawnConfig()
	for _, ruleItem in pairs(self._ruleItemDict) do
		if ruleItem.getMonsterSpawnConfig then
			local maxCount, spawnCount = ruleItem:getMonsterSpawnConfig()

			if spawnCount and maxCount then
				return spawnCount, maxCount
			end
		end
	end
end

function ArcadeSurvivorGameRuleModel:clear()
	self._ruleItemDict = {}
end

return ArcadeSurvivorGameRuleModel
