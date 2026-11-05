-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/base/ArcadeSurvivorGameBaseSelector.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.base.ArcadeSurvivorGameBaseSelector", package.seeall)

local ArcadeSurvivorGameBaseSelector = class("ArcadeSurvivorGameBaseSelector")

function ArcadeSurvivorGameBaseSelector:ctor(paramArr)
	self._targetList = {}
	self._targetDict = {}
	self._gridIdDict = {}
	self._gridIdList = {}
	self._centerGridPosX = nil
	self._centerGridPosY = nil
	self._ignoreSourceUnit = false

	self:_setSource()
	self:_setCenterGridPos()
	self:_setFindTargetType(paramArr[2])
	self:onCtor(unpack(paramArr, 3))
end

function ArcadeSurvivorGameBaseSelector:_setFindTargetType(strTarget)
	self._targetEntityType = nil
	self._targetIdDict = nil

	if string.nilorempty(strTarget) then
		return
	end

	local targetArr = string.split(strTarget, ":")

	self._targetEntityType = targetArr[1]

	local strTargetIds = targetArr[2]

	if not string.nilorempty(strTargetIds) then
		self._targetIdDict = {}

		local targetIdList = string.splitToNumber(strTargetIds, ",")

		for _, targetId in ipairs(targetIdList) do
			self._targetIdDict[targetId] = true
		end
	end
end

function ArcadeSurvivorGameBaseSelector:findByContext(context)
	self:_clear()

	local caster = context and context:getCaster()

	if caster then
		local sourceGridX, sourceGridY = caster:getGridPos()
		local sourceDirection = caster:getDirection()

		self:_setSource(sourceGridX, sourceGridY, sourceDirection)
	end

	local result = callWithCatch(self._onFindByContext, self, context)

	if result then
		return self:getTargetList(), self:getGridIdDict()
	end
end

function ArcadeSurvivorGameBaseSelector:findTarget(sourceGridX, sourceGridY, sourceDirection)
	self:_clear()
	self:_setSource(sourceGridX, sourceGridY, sourceDirection)

	local result = callWithCatch(self._onFindTarget, self)

	if result then
		return self:getTargetList(), self:getGridIdDict()
	end
end

function ArcadeSurvivorGameBaseSelector:_getTargetInGridId(gridId)
	local targetType = self._targetEntityType

	if targetType == ArcadeSurvivorEnum.EntityType.Grid then
		return ArcadeSurvivorGameModel.instance:getEntityMO(ArcadeSurvivorEnum.EntityType.Grid, gridId)
	end

	local gridX, gridY = ArcadeSurvivorGameHelper.getGridXYById(gridId)
	local entityLayer = ArcadeSurvivorGameEnum.EntityType2Layer[targetType]

	if not entityLayer then
		return
	end

	local data = ArcadeSurvivorGameModel.instance:getEntityDataInGrid(gridX, gridY, entityLayer)

	return data and ArcadeSurvivorGameModel.instance:getEntityMO(data.entityType, data.uid)
end

function ArcadeSurvivorGameBaseSelector:getTargetListInGrids(gridIdDict)
	local targetList, repeatDict = {}, {}

	for gridId, _ in pairs(gridIdDict) do
		local targetMO = self:_getTargetInGridId(gridId)

		if targetMO and not repeatDict[targetMO] and self:_checkTargetIsValid(targetMO) then
			repeatDict[targetMO] = true
			targetList[#targetList + 1] = targetMO
		end
	end

	return targetList
end

function ArcadeSurvivorGameBaseSelector:_setSource(sourceGridX, sourceGridY, sourceDirection)
	self._sourceGridX = sourceGridX
	self._sourceGridY = sourceGridY
	self._sourceDirection = sourceDirection
end

function ArcadeSurvivorGameBaseSelector:_setCenterGridPos(centerGridPosX, centerGridPosY)
	self._centerGridPosX = centerGridPosX
	self._centerGridPosY = centerGridPosY
end

function ArcadeSurvivorGameBaseSelector:_addTarget(target, needOccupyGrid)
	local isCanAdd = self:_checkTargetIsValid(target)

	if not isCanAdd then
		return false
	end

	local uid = target:getUid()
	local entityType = target:getEntityType()
	local alreadyHas = self:getHaveTarget(entityType, uid)

	if alreadyHas then
		return false
	end

	local typeDict = GameUtil.tabletool_checkDictTable(self._targetDict, entityType)

	typeDict[uid] = true
	self._targetList[#self._targetList + 1] = target

	if needOccupyGrid then
		local gridIdList = ArcadeSurvivorGameModel.instance:getEntityOccupyGridList(entityType, uid)

		for index = 1, #gridIdList do
			self:_addGridId(gridIdList[index])
		end
	end

	return true
end

function ArcadeSurvivorGameBaseSelector:_checkTargetIsValid(target)
	local isAlive = target and target:getIsAlive()

	if not isAlive then
		return
	end

	if target:getIsOffBoard() and not self._allowOffBoard then
		return
	end

	local gridX, gridY = target:getGridPos()
	local curLevelId = ArcadeSurvivorGameModel.instance:getCurLevelId()

	if curLevelId then
		local isOutside = ArcadeSurvivorGameHelper.isOutsideMap(gridX, gridY)

		if isOutside then
			return
		end
	end

	local entityType = target:getEntityType()

	if self._targetEntityType and self._targetEntityType ~= entityType then
		return
	end

	local id = target:getId()

	if self._targetIdDict and not self._targetIdDict[id] then
		return
	end

	if self._ignoreSourceUnit then
		local sourceUnitMO = self:_getSourceUnitMO()

		if sourceUnitMO then
			local isSourceUnit = target:getEntityType() == sourceUnitMO:getEntityType() and target:getUid() == sourceUnitMO:getUid()

			if isSourceUnit then
				return
			end
		end
	end

	return self:_canAddTarget(target)
end

function ArcadeSurvivorGameBaseSelector:_addGridId(gridId)
	local x, y = ArcadeSurvivorGameHelper.getGridXYById(gridId)

	return self:_addGridXY(x, y)
end

function ArcadeSurvivorGameBaseSelector:_addGridXY(x, y)
	if ArcadeSurvivorGameHelper.isOutsideMap(x, y) then
		return false
	end

	local gridId = ArcadeSurvivorGameHelper.getGridId(x, y)

	if self._gridIdDict[gridId] then
		return false
	end

	self._gridIdDict[gridId] = true
	self._gridIdList[#self._gridIdList + 1] = gridId

	return true
end

function ArcadeSurvivorGameBaseSelector:_clear()
	for _, typeDict in pairs(self._targetDict) do
		tabletool.clear(typeDict)
	end

	tabletool.clear(self._targetList)
	tabletool.clear(self._gridIdDict)
	tabletool.clear(self._gridIdList)
	self:_setSource()
	self:_setCenterGridPos()
end

function ArcadeSurvivorGameBaseSelector:getGridIdDict()
	return self._gridIdDict
end

function ArcadeSurvivorGameBaseSelector:getGridIdList()
	return self._gridIdList
end

function ArcadeSurvivorGameBaseSelector:getTargetList()
	return self._targetList
end

function ArcadeSurvivorGameBaseSelector:getHaveTarget(entityType, uid)
	local dict = self._targetDict[entityType]

	return dict and dict[uid]
end

function ArcadeSurvivorGameBaseSelector:getCenterGridPos()
	return self._centerGridPosX, self._centerGridPosY
end

function ArcadeSurvivorGameBaseSelector:_getSourceUnitMO()
	if not self._sourceGridX or not self._sourceGridY then
		return
	end

	local entityData = ArcadeSurvivorGameModel.instance:getEntityDataInGrid(self._sourceGridX, self._sourceGridY, ArcadeSurvivorGameEnum.EntityLayer.Normal)

	if not entityData then
		return
	end

	return ArcadeSurvivorGameModel.instance:getEntityMO(entityData.entityType, entityData.uid)
end

function ArcadeSurvivorGameBaseSelector:onCtor(...)
	return
end

function ArcadeSurvivorGameBaseSelector:_onFindTarget()
	return
end

function ArcadeSurvivorGameBaseSelector:_onFindByContext(context)
	return
end

function ArcadeSurvivorGameBaseSelector:_canAddTarget(target)
	return true
end

return ArcadeSurvivorGameBaseSelector
