-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/game/rule/ArcadeSurvivorGameBaseRule.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.game.rule.ArcadeSurvivorGameBaseRule", package.seeall)

local ArcadeSurvivorGameBaseRule = class("ArcadeSurvivorGameBaseRule")

function ArcadeSurvivorGameBaseRule:ctor(ruleId)
	self._ruleId = ruleId
	self._typeParam = ArcadeSurvivorConfig.instance:getCollectionRuleTypeParam(ruleId)
	self._sourceDict = {}
end

function ArcadeSurvivorGameBaseRule:addSource(sourceType, sourceId, count)
	if not sourceType or not sourceId then
		return
	end

	local sourceDict = self:_getSourceDict(sourceType)
	local source = sourceDict[sourceId]

	if not source then
		source = {
			count = 0,
			state = {}
		}
		sourceDict[sourceId] = source
	end

	source.count = source.count + (count or 1)
end

function ArcadeSurvivorGameBaseRule:removeSource(sourceType, sourceId, count)
	local sourceDict = self:_getSourceDict(sourceType)
	local source = sourceDict[sourceId]

	if not source then
		return false
	end

	source.count = math.max(0, source.count - (count or 1))

	if source.count <= 0 then
		sourceDict[sourceId] = nil

		return true
	end

	return false
end

function ArcadeSurvivorGameBaseRule:setSourceState(sourceType, sourceId, state)
	local source = self:getSource(sourceType, sourceId)

	if source then
		source.state = state or {}
	end
end

function ArcadeSurvivorGameBaseRule:getRuleId()
	return self._ruleId
end

function ArcadeSurvivorGameBaseRule:getSource(sourceType, sourceId)
	local sourceDict = self._sourceDict[sourceType]

	return sourceDict and sourceDict[sourceId] or nil
end

function ArcadeSurvivorGameBaseRule:getSourceCount(sourceType, sourceId)
	local source = self:getSource(sourceType, sourceId)

	return source and source.count or 0
end

function ArcadeSurvivorGameBaseRule:getSourceState(sourceType, sourceId)
	local source = self:getSource(sourceType, sourceId)

	return source and source.state
end

function ArcadeSurvivorGameBaseRule:getSaveSourceStateList()
	local result = {}

	for sourceType, sourceDict in pairs(self._sourceDict) do
		for sourceId, source in pairs(sourceDict) do
			local state = source and source.state
			local hasState = state and next(state) ~= nil

			if hasState then
				result[#result + 1] = {
					sourceType = sourceType,
					sourceId = sourceId,
					state = state
				}
			end
		end
	end

	return result
end

function ArcadeSurvivorGameBaseRule:hasSource()
	for _, sourceDict in pairs(self._sourceDict) do
		local hasSourceItem = next(sourceDict) ~= nil

		if hasSourceItem then
			return true
		end
	end

	return false
end

function ArcadeSurvivorGameBaseRule:getSourceInfoList()
	local result = {}

	for sourceType, sourceDict in pairs(self._sourceDict) do
		for sourceId, source in pairs(sourceDict) do
			if source and source.count > 0 then
				result[#result + 1] = {
					sourceType = sourceType,
					sourceId = sourceId,
					count = source.count,
					state = source.state
				}
			end
		end
	end

	table.sort(result, function(left, right)
		if left.sourceType ~= right.sourceType then
			return left.sourceType < right.sourceType
		end

		return left.sourceId < right.sourceId
	end)

	return result
end

function ArcadeSurvivorGameBaseRule:getSortedSourceIdList(sourceType)
	local result = {}
	local sourceDict = self._sourceDict[sourceType]

	for sourceId, source in pairs(sourceDict or {}) do
		if source and source.count > 0 then
			result[#result + 1] = sourceId
		end
	end

	table.sort(result)

	return result
end

function ArcadeSurvivorGameBaseRule:getSortedCollectionIdList()
	return self:getSortedSourceIdList(ArcadeSurvivorGameEnum.RuleSourceType.Collection)
end

function ArcadeSurvivorGameBaseRule:_getSourceDict(sourceType)
	local sourceDict = self._sourceDict[sourceType]

	if not sourceDict then
		sourceDict = {}
		self._sourceDict[sourceType] = sourceDict
	end

	return sourceDict
end

function ArcadeSurvivorGameBaseRule:applyOnceOnGain()
	return
end

function ArcadeSurvivorGameBaseRule:onCollectionGained(collectionId)
	return
end

function ArcadeSurvivorGameBaseRule:onCollectionRemoved(collectionId, count)
	return
end

function ArcadeSurvivorGameBaseRule:onShopClosed()
	return
end

function ArcadeSurvivorGameBaseRule:onGoodsPurchased(price, currencyId)
	return
end

function ArcadeSurvivorGameBaseRule:onEnterLevel()
	return
end

function ArcadeSurvivorGameBaseRule:onEventGained(sourceId)
	return
end

return ArcadeSurvivorGameBaseRule
