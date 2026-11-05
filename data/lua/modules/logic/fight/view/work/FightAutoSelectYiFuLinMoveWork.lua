-- chunkname: @modules/logic/fight/view/work/FightAutoSelectYiFuLinMoveWork.lua

module("modules.logic.fight.view.work.FightAutoSelectYiFuLinMoveWork", package.seeall)

local FightAutoSelectYiFuLinMoveWork = class("FightAutoSelectYiFuLinMoveWork", FightWorkItem)

function FightAutoSelectYiFuLinMoveWork:onConstructor()
	self.SAFETIME = 10
end

function FightAutoSelectYiFuLinMoveWork:onStart()
	local yiFuLinUid = self:_getYiFuLinUid()

	if not yiFuLinUid then
		return self:onDone(true)
	end

	local pos2Entity, entity2Pos = self:_initPositionData()

	if not pos2Entity then
		return self:onDone(true)
	end

	local lockedPos, lockedEntity = self:_searchLockResult(pos2Entity)
	local positionData, changed = self:_buildPositionData(pos2Entity, entity2Pos, lockedPos, lockedEntity)

	if not changed then
		return self:onDone(true)
	end

	FightController.instance:registerCallback(FightEvent.RespUseClothSkillFail, self._onRespUseClothSkillFail, self)
	self:cancelFightWorkSafeTimer()

	local jsonStr = cjson.encode(positionData)

	FightRpc.instance:sendUseClothSkillRequest(0, yiFuLinUid, nil, FightEnum.ClothSkillType.PositionSort, jsonStr)
end

function FightAutoSelectYiFuLinMoveWork:_getYiFuLinUid()
	local entityList = FightDataHelper.entityMgr:getSideList(FightEnum.EntitySide.MySide)

	if not entityList then
		return nil
	end

	for _, entityMO in ipairs(entityList) do
		if entityMO:hasBuffFeature(FightEnum.BuffFeature.PositionSortSelect) then
			return entityMO.uid
		end
	end

	return nil
end

function FightAutoSelectYiFuLinMoveWork:_initPositionData()
	local battleId = FightModel.instance:getBattleId()
	local battleCo = battleId and lua_battle.configDict[battleId]
	local totalPositions = battleCo and battleCo.playerMax or 3
	local pos2Entity = {}
	local entity2Pos = {}
	local entityList = FightDataHelper.entityMgr:getMyNormalList()

	if entityList then
		for _, entityMO in ipairs(entityList) do
			local pos = entityMO.position

			if pos and pos > 0 and pos <= totalPositions then
				pos2Entity[pos] = entityMO.uid
				entity2Pos[entityMO.uid] = pos
			end
		end
	end

	return pos2Entity, entity2Pos, totalPositions
end

function FightAutoSelectYiFuLinMoveWork:_searchLockResult(pos2Entity)
	local lockedPos = {}
	local lockedEntity = {}

	while true do
		local remainCount = 0

		for pos, entityId in pairs(pos2Entity) do
			if not lockedPos[pos] and not lockedEntity[entityId] then
				remainCount = remainCount + 1
			end
		end

		if remainCount < 2 then
			break
		end

		local best = self:_selectBestCandidate(pos2Entity, lockedPos, lockedEntity)

		if not best then
			break
		end

		lockedPos[best.position] = best.ownerUid
		lockedEntity[best.ownerUid] = true
	end

	return lockedPos, lockedEntity
end

function FightAutoSelectYiFuLinMoveWork:_selectBestCandidate(pos2Entity, lockedPos, lockedEntity)
	local best

	for pos, entityId in pairs(pos2Entity) do
		if not lockedPos[pos] and not lockedEntity[entityId] then
			local count, clueId, ownerUid = self:_getPosDominantClue(pos, lockedEntity)

			if ownerUid then
				local ownerMO = FightDataHelper.entityMgr:getById(ownerUid)
				local modelId = ownerMO and ownerMO.modelId or 0

				if not best or count > best.count or count == best.count and pos < best.position or count == best.count and pos == best.position and modelId > best.modelId then
					best = {
						position = pos,
						count = count,
						clueId = clueId,
						ownerUid = ownerUid,
						modelId = modelId
					}
				end
			end
		end
	end

	return best
end

function FightAutoSelectYiFuLinMoveWork:_getPosDominantClue(position, lockedEntity)
	local clueArea = FightDataHelper.getClueArea(FightEnum.TeamType.MySide)
	local positionData = clueArea and clueArea:getPositionData(position)
	local clueList = positionData and positionData.clues

	if not clueList or #clueList < 1 then
		return 0, 0, nil
	end

	local typeCount = {}
	local typeOwner = {}

	for _, clueData in ipairs(clueList) do
		local clueId = clueData.clueId

		typeCount[clueId] = (typeCount[clueId] or 0) + 1
		typeOwner[clueId] = clueData.entityUid
	end

	local maxCount = 0
	local maxClueId

	for clueId, count in pairs(typeCount) do
		if maxCount < count then
			maxCount = count
			maxClueId = clueId
		end
	end

	if not maxClueId then
		return 0, 0, nil
	end

	local ownerUid = typeOwner[maxClueId]
	local ownerMO = ownerUid and FightDataHelper.entityMgr:getById(ownerUid)

	if not ownerMO or ownerMO:isEnemySide() or lockedEntity[ownerUid] then
		return maxCount, maxClueId, nil
	end

	return maxCount, maxClueId, ownerUid
end

function FightAutoSelectYiFuLinMoveWork:_buildPositionData(pos2Entity, entity2Pos, lockedPos, lockedEntity)
	local finalPos2Entity = {}

	for pos, entityId in pairs(pos2Entity) do
		finalPos2Entity[pos] = entityId
	end

	for pos, entityId in pairs(pos2Entity) do
		if lockedEntity[entityId] then
			finalPos2Entity[pos] = nil
		end
	end

	for pos, entityId in pairs(lockedPos) do
		finalPos2Entity[pos] = entityId
	end

	local positionData = {}
	local changed = false

	for pos, entityId in pairs(finalPos2Entity) do
		positionData[entityId] = pos

		if entity2Pos[entityId] ~= pos then
			changed = true
		end
	end

	return positionData, changed
end

function FightAutoSelectYiFuLinMoveWork:_onRespUseClothSkillFail()
	logError("伊芙琳 自动位置交换失败")
	self:onDone(true)
end

function FightAutoSelectYiFuLinMoveWork:clearWork()
	FightController.instance:unregisterCallback(FightEvent.RespUseClothSkillFail, self._onRespUseClothSkillFail, self)
end

return FightAutoSelectYiFuLinMoveWork
