-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/game/entity/ArcadeSurvivorGameMonsterMO.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.game.entity.ArcadeSurvivorGameMonsterMO", package.seeall)

local ArcadeSurvivorGameMonsterMO = class("ArcadeSurvivorGameMonsterMO", ArcadeSurvivorGameBaseUnitMO)

function ArcadeSurvivorGameMonsterMO:onCtor()
	local id = self:getId()

	self._dialogConditionDict = self:_buildDialogConditionDict(id)

	local skillIdList = ArcadeSurvivorConfig.instance:getMonsterSkillIdList(id)

	for _, skillId in ipairs(skillIdList) do
		self:addSkill(skillId)
	end

	if self:getMonsterType() == ArcadeSurvivorEnum.MonsterType.Neutral then
		return
	end

	local extraSkillDict = ArcadeSurvivorGameModel.instance:getMonsterExtraSkillDict()

	for skillId, _ in pairs(extraSkillDict) do
		self:addSkill(skillId)
	end
end

function ArcadeSurvivorGameMonsterMO:_buildDialogConditionDict(id)
	local result = {}

	for _, groupId in ipairs(ArcadeSurvivorConfig.instance:getMonsterDialogGroupIdList(id)) do
		local condition = ArcadeSurvivorConfig.instance:getDialogCondition(groupId)

		if condition then
			result[condition] = result[condition] or {}

			local groupIdList = result[condition]

			groupIdList[#groupIdList + 1] = groupId
		end
	end

	return result
end

function ArcadeSurvivorGameMonsterMO:setDialogPlayed(groupId)
	self._playedDialogDict = self._playedDialogDict or {}
	self._playedDialogDict[groupId] = true
end

function ArcadeSurvivorGameMonsterMO:getDialogGroupIdListByCondition(conditionType)
	local dict = self._dialogConditionDict

	return dict and dict[conditionType] or {}
end

function ArcadeSurvivorGameMonsterMO:getCanTalkDialogGroupId(conditionType)
	local groupId, skipGroupIdList = ArcadeSurvivorGameHelper.getCanTalkDialogGroupId(self, conditionType)

	if skipGroupIdList then
		for _, skipGroupId in ipairs(skipGroupIdList) do
			self:setDialogPlayed(skipGroupId)
		end
	end

	return groupId
end

function ArcadeSurvivorGameMonsterMO:getDialogHavePlayed(groupId)
	return self._playedDialogDict and self._playedDialogDict[groupId] or false
end

function ArcadeSurvivorGameMonsterMO:getResName()
	local id = self:getId()

	return ArcadeSurvivorConfig.instance:getMonsterRes(id)
end

function ArcadeSurvivorGameMonsterMO:getTipIsUseImg()
	return true
end

function ArcadeSurvivorGameMonsterMO:getMonsterType()
	local id = self:getId()

	return ArcadeSurvivorConfig.instance:getMonsterType(id)
end

function ArcadeSurvivorGameMonsterMO:getTreeId()
	local id = self:getId()
	local difficulty = ArcadeSurvivorGameModel.instance:getDifficulty()

	return ArcadeSurvivorConfig.instance:getMonsterTreeId(id, difficulty)
end

function ArcadeSurvivorGameMonsterMO:getImgOffsetArr()
	local id = self:getId()
	local posArr = ArcadeSurvivorConfig.instance:getMonsterIconOffset(id)

	return posArr
end

function ArcadeSurvivorGameMonsterMO:getImgScaleArr()
	local id = self:getId()
	local scaleArr = ArcadeSurvivorConfig.instance:getMonsterIconScale(id)

	return scaleArr
end

function ArcadeSurvivorGameMonsterMO:getNextMoveGrid()
	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()

	if not characterMO then
		return
	end

	local gridX, gridY = self:getGridPos()
	local playerGridX, playerGridY = characterMO:getGridPos()
	local offsetX = playerGridX - gridX
	local offsetY = playerGridY - gridY
	local directionList = {}
	local offsetList = {}

	if offsetX ~= 0 then
		directionList[#directionList + 1] = offsetX > 0 and ArcadeSurvivorEnum.Direction.Right or ArcadeSurvivorEnum.Direction.Left
		offsetList[#offsetList + 1] = math.abs(offsetX)
	end

	if offsetY ~= 0 then
		directionList[#directionList + 1] = offsetY > 0 and ArcadeSurvivorEnum.Direction.Up or ArcadeSurvivorEnum.Direction.Down
		offsetList[#offsetList + 1] = math.abs(offsetY)
	end

	if #directionList <= 0 then
		return
	end

	local firstOffset, secondOffset = offsetList[1], offsetList[2]

	if firstOffset and secondOffset then
		local isSecondNearer = firstOffset < secondOffset
		local isRandomSwap = firstOffset == secondOffset and math.random(#directionList) ~= 1

		if isSecondNearer or isRandomSwap then
			directionList[1], directionList[2] = directionList[2], directionList[1]
		end
	end

	local entityType, uid = self:getEntityType(), self:getUid()
	local sizeX, sizeY = self:getSize()

	for _, direction in ipairs(directionList) do
		local targetGridX = gridX + (ArcadeSurvivorEnum.DirChangeGridX[direction] or 0)
		local targetGridY = gridY + (ArcadeSurvivorEnum.DirChangeGridY[direction] or 0)

		if ArcadeSurvivorGameModel.instance:isCanPlaceEntity(entityType, uid, targetGridX, targetGridY, sizeX, sizeY) then
			return targetGridX, targetGridY
		end
	end
end

return ArcadeSurvivorGameMonsterMO
