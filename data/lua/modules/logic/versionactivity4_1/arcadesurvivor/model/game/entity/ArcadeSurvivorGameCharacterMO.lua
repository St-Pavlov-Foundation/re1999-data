-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/game/entity/ArcadeSurvivorGameCharacterMO.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.game.entity.ArcadeSurvivorGameCharacterMO", package.seeall)

local ArcadeSurvivorGameCharacterMO = class("ArcadeSurvivorGameCharacterMO", ArcadeSurvivorGameBaseUnitMO)

function ArcadeSurvivorGameCharacterMO:onCtor(isRestart)
	local id = self:getId()
	local weaponCollectionId = ArcadeSurvivorConfig.instance:getCharacterWeaponCollectionId(id)

	self._weaponSkillIdList = ArcadeSurvivorConfig.instance:getCollectionAddSkillIdList(weaponCollectionId)
	self._lastWeaponSkillCastRound = nil
	self._collectionIdList = {}
	self._collectionCountDict = {}

	if not isRestart then
		for _, skillId in ipairs(self._weaponSkillIdList) do
			self:addSkill(skillId, ArcadeSurvivorGameEnum.SkillSourceType.Collection, weaponCollectionId)
		end

		local collectionId = ArcadeSurvivorConfig.instance:getCharacterCollectionId(id)

		if collectionId and collectionId > 0 then
			self:addCollection(collectionId)
		end
	end
end

function ArcadeSurvivorGameCharacterMO:setServerInfo(attrInfo, skillInfo, collectionInfo)
	local curHp = 0

	if attrInfo then
		for _, data in ipairs(attrInfo.attrValues) do
			local attrId = data.id

			if attrId == ArcadeSurvivorEnum.Attribute.hp then
				curHp = data.base
			else
				self:changeAttr(attrId, data.increase)
			end
		end
	end

	self:setHp(curHp)

	if collectionInfo then
		for _, collection in ipairs(collectionInfo.collections) do
			self:_addCollectionRecord(collection.id, collection.count)
		end
	end

	if skillInfo then
		for _, skill in ipairs(skillInfo.skills) do
			self:_addSkillFromSave(skill.id, skill.customMap)
		end
	end
end

function ArcadeSurvivorGameCharacterMO:_addSkillFromSave(skillId, customMap)
	local sourceList = self:_parseSkillSourceCountList(customMap)

	if #sourceList <= 0 then
		logError(string.format("ArcadeSurvivorGameCharacterMO:_addSkillFromSave error, no valid skill source, skillId:%s", tostring(skillId)))

		return
	end

	for _, source in ipairs(sourceList) do
		for _ = 1, source.count do
			self:addSkill(skillId, source.sourceType, source.sourceId)
		end
	end
end

function ArcadeSurvivorGameCharacterMO:_parseSkillSourceCountList(customMap)
	local result = {}
	local mapEntryList = customMap or {}

	for _, mapEntry in ipairs(mapEntryList) do
		local sourceType = tonumber(mapEntry.key)
		local isValidSourceType = ArcadeSurvivorGameEnum.SkillSourceTypeValidDict[sourceType]

		if not isValidSourceType or string.nilorempty(mapEntry.val) then
			logError(string.format("ArcadeSurvivorGameCharacterMO:_parseSkillSourceCountList error, invalid source type, sourceType:%s val:%s", tostring(mapEntry.key), tostring(mapEntry.val)))
		else
			local sourcePairList = string.split(mapEntry.val, "|")

			for _, sourcePair in ipairs(sourcePairList) do
				local source = self:_parseSourceCountPair(sourcePair, sourceType)

				if source then
					result[#result + 1] = source
				end
			end
		end
	end

	return result
end

function ArcadeSurvivorGameCharacterMO:_parseSourceCountPair(sourcePair, sourceType)
	local pairList = string.split(sourcePair, "#")
	local sourceId = tonumber(pairList[1])
	local count = tonumber(pairList[2])
	local isValidSource

	if not sourceId or not count then
		isValidSource = false
	elseif sourceType == ArcadeSurvivorGameEnum.SkillSourceType.Normal then
		isValidSource = sourceId >= ArcadeSurvivorGameEnum.Const.NoneSkillSourceId and count == 1
	else
		isValidSource = sourceId > 0 and count > 0
	end

	if not isValidSource then
		logError(string.format("ArcadeSurvivorGameCharacterMO:_parseSkillSourceCountList error, invalid source, sourceType:%s pair:%s", tostring(sourceType), tostring(sourcePair)))

		return
	end

	return {
		sourceType = sourceType,
		sourceId = sourceId,
		count = count
	}
end

function ArcadeSurvivorGameCharacterMO:addCollection(collectionId)
	if not self:canAddCollection(collectionId) then
		return false
	end

	local skillIds = ArcadeSurvivorConfig.instance:getCollectionAddSkillIdList(collectionId)

	for _, skillId in ipairs(skillIds) do
		self:addSkill(skillId, ArcadeSurvivorGameEnum.SkillSourceType.Collection, collectionId)
	end

	self:_addCollectionRecord(collectionId)

	return true
end

function ArcadeSurvivorGameCharacterMO:canAddCollection(collectionId)
	local maxStacks = ArcadeSurvivorConfig.instance:getCollectionMaxStacks(collectionId)

	return maxStacks <= 0 or maxStacks > self:getCollectionCount(collectionId)
end

function ArcadeSurvivorGameCharacterMO:_addCollectionRecord(collectionId, argsAddCount)
	local addCount
	local numArgsAddCount = tonumber(argsAddCount)

	if numArgsAddCount and numArgsAddCount > 0 then
		addCount = numArgsAddCount
	else
		addCount = 1
	end

	local count = self._collectionCountDict[collectionId] or 0

	self._collectionCountDict[collectionId] = count + addCount

	if count <= 0 then
		self._collectionIdList[#self._collectionIdList + 1] = collectionId
	end
end

function ArcadeSurvivorGameCharacterMO:removeCollection(collectionId, count)
	if not collectionId or not self._collectionCountDict[collectionId] then
		return false
	end

	local removeCount = math.min(count or 1, self._collectionCountDict[collectionId])
	local skillIds = ArcadeSurvivorConfig.instance:getCollectionAddSkillIdList(collectionId)

	for _ = 1, removeCount do
		for _, skillId in ipairs(skillIds) do
			self:removeSkill(skillId, ArcadeSurvivorGameEnum.SkillSourceType.Collection, collectionId)
		end
	end

	local remainCount = self._collectionCountDict[collectionId] - removeCount

	if remainCount > 0 then
		self._collectionCountDict[collectionId] = remainCount
	else
		self._collectionCountDict[collectionId] = nil

		for index, id in ipairs(self._collectionIdList) do
			if id == collectionId then
				table.remove(self._collectionIdList, index)

				break
			end
		end
	end

	return removeCount > 0
end

function ArcadeSurvivorGameCharacterMO:setLastWeaponSkillCastRound(round)
	self._lastWeaponSkillCastRound = round
end

function ArcadeSurvivorGameCharacterMO:setTurnMoveDirection(direction)
	self._turnMoveDirection = direction
end

function ArcadeSurvivorGameCharacterMO:getTurnMoveDirection()
	return self._turnMoveDirection
end

function ArcadeSurvivorGameCharacterMO:getCollectionDict()
	return self._collectionCountDict
end

function ArcadeSurvivorGameCharacterMO:getCollectionIdList()
	return self._collectionIdList
end

function ArcadeSurvivorGameCharacterMO:getCollectionCount(collectionId)
	if collectionId then
		return self._collectionCountDict[collectionId] or 0
	else
		local count = 0

		for _, collectionCount in pairs(self._collectionCountDict) do
			count = count + collectionCount
		end

		return count
	end
end

function ArcadeSurvivorGameCharacterMO:getResName()
	local id = self:getId()

	return ArcadeSurvivorConfig.instance:getCharacterRes(id)
end

function ArcadeSurvivorGameCharacterMO:getWeaponSkillIdList()
	return self._weaponSkillIdList
end

function ArcadeSurvivorGameCharacterMO:getLastWeaponSkillCastRound()
	return self._lastWeaponSkillCastRound
end

function ArcadeSurvivorGameCharacterMO:getHaveCollectionTag(targetTag)
	for _, collectionId in ipairs(self._collectionIdList) do
		local tagDict = ArcadeSurvivorConfig.instance:getCollectionTagIds(collectionId, true)

		if tagDict and tagDict[targetTag] then
			return true
		end
	end
end

function ArcadeSurvivorGameCharacterMO:getImgOffsetArr()
	local id = self:getId()
	local posArr = ArcadeSurvivorConfig.instance:getCharacterPortraitOffset(id)

	return posArr
end

function ArcadeSurvivorGameCharacterMO:getImgScaleArr()
	local id = self:getId()
	local scaleArr = ArcadeSurvivorConfig.instance:getCharacterPortraitScale(id)

	return scaleArr
end

return ArcadeSurvivorGameCharacterMO
