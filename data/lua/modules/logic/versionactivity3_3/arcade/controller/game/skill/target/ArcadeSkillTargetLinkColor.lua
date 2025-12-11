-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/target/ArcadeSkillTargetLinkColor.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.target.ArcadeSkillTargetLinkColor", package.seeall)

local ArcadeSkillTargetLinkColor = class("ArcadeSkillTargetLinkColor", ArcadeSkillTargetBase)

function ArcadeSkillTargetLinkColor:onFindTarget()
	local curRoom = ArcadeGameController.instance:getCurRoom()

	if not curRoom or not self.gridX or not self.gridY then
		return
	end

	local entityData = curRoom:getEntityDataInTargetGrid(self.gridX, self.gridY)

	if not entityData then
		return
	end

	local entityType = entityData.entityType
	local uid = entityData.uid
	local mo = ArcadeGameModel.instance:getMOWithType(entityType, uid)
	local targetRace = mo and ArcadeConfig.instance:getMonsterRace(mo:getId())

	if not targetRace then
		return
	end

	self:addTarget(mo)

	local hasCheckGridDict = {}
	local occupyGridList = curRoom:getEntityOccupyGridList(entityType, uid)

	for _, occupyGridId in ipairs(occupyGridList) do
		hasCheckGridDict[occupyGridId] = true
	end

	local nextMOKey = uid
	local waitCheckMODict = {
		[uid] = mo
	}

	while nextMOKey do
		local nextMO = waitCheckMODict[nextMOKey]

		if not nextMO then
			break
		end

		local nextMOUid = nextMO:getUid()

		waitCheckMODict[nextMOUid] = nil

		local borderGridList = nextMO:getBorderGridList()

		for _, gridData in ipairs(borderGridList) do
			local borderGridX = gridData.gridX
			local borderGridY = gridData.gridY
			local adjEntityData = curRoom:getEntityDataInTargetGrid(borderGridX, borderGridY)
			local adjEntityType = adjEntityData and adjEntityData.entityType
			local gridId = ArcadeGameHelper.getGridId(borderGridX, borderGridY)

			if adjEntityData and not hasCheckGridDict[gridId] and adjEntityType == ArcadeGameEnum.EntityType.Monster then
				local adjUid = adjEntityData.uid
				local adjMO = ArcadeGameModel.instance:getMOWithType(adjEntityType, adjUid)

				if adjMO and not self._targetIdDict[adjUid] then
					local adjId = adjMO:getId()
					local race = ArcadeConfig.instance:getMonsterRace(adjId)

					if race == targetRace then
						self:addTarget(adjMO)

						local adjOccupyGridList = curRoom:getEntityOccupyGridList(adjEntityType, adjUid)

						for _, adjGridId in ipairs(adjOccupyGridList) do
							hasCheckGridDict[adjGridId] = true
						end

						waitCheckMODict[adjUid] = adjMO
					end
				end
			end
		end

		nextMOKey = next(waitCheckMODict)
	end
end

return ArcadeSkillTargetLinkColor
