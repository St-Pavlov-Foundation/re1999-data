-- chunkname: @modules/logic/versionactivity4_1/library/scene/comp/V4a1_LibrarySceneEntityMgr.lua

local math_abs = math.abs

module("modules.logic.versionactivity4_1.library.scene.comp.V4a1_LibrarySceneEntityMgr", package.seeall)

local V4a1_LibrarySceneEntityMgr = class("V4a1_LibrarySceneEntityMgr", V4a1_LibraryBaseSceneComp)

function V4a1_LibrarySceneEntityMgr:ctor(...)
	V4a1_LibrarySceneEntityMgr.super.ctor(self, ...)

	self._tagUnitDict = {}
end

function V4a1_LibrarySceneEntityMgr:addUnit(unit)
	gohelper.addChild(self:containerGO(), unit.go)

	local tag = unit.go.tag
	local tagUnits = self._tagUnitDict[tag]

	if not tagUnits then
		tagUnits = {}
		self._tagUnitDict[tag] = tagUnits
	end

	tagUnits[unit.id] = unit
end

function V4a1_LibrarySceneEntityMgr:removeUnit(unitTag, unitId)
	local tagUnits = self._tagUnitDict[unitTag]

	if tagUnits then
		local unit = tagUnits[unitId]

		if unit then
			tagUnits[unitId] = nil

			self:destroyUnit(unit)
		end
	end
end

function V4a1_LibrarySceneEntityMgr:removeUnitData(unitTag, unitId)
	if self._tagUnitDict[unitTag] and self._tagUnitDict[unitTag][unitId] then
		local unit = self._tagUnitDict[unitTag][unitId]

		self._tagUnitDict[unitTag][unitId] = nil

		return unit
	end
end

function V4a1_LibrarySceneEntityMgr:removeUnits(unitTag)
	local tagUnits = self._tagUnitDict[unitTag]

	if tagUnits then
		for id, unit in pairs(tagUnits) do
			tagUnits[id] = nil

			self:destroyUnit(unit)
		end
	end
end

function V4a1_LibrarySceneEntityMgr:removeAllUnits()
	for _, tagUnits in pairs(self._tagUnitDict) do
		for id, unit in pairs(tagUnits) do
			tagUnits[id] = nil

			self:destroyUnit(unit)
		end
	end
end

function V4a1_LibrarySceneEntityMgr:getUnit(unitTag, unitId)
	local tagUnits = self._tagUnitDict[unitTag]

	if tagUnits then
		return tagUnits[unitId]
	end
end

function V4a1_LibrarySceneEntityMgr:getTagUnitDict(unitTag)
	return self._tagUnitDict[unitTag]
end

function V4a1_LibrarySceneEntityMgr:destroyUnit(unit)
	if unit.beforeDestroy then
		unit:beforeDestroy()
	end

	gohelper.destroy(unit.go)
end

function V4a1_LibrarySceneEntityMgr:onExec_LibAsyncTaskWork()
	self:_refreshAllCharEntities()
end

function V4a1_LibrarySceneEntityMgr:_onDailyRefresh()
	self:_refreshAllCharEntities()
end

function V4a1_LibrarySceneEntityMgr:_refreshAllCharEntities()
	local skinIdList = V4a1_LibrarySceneModel.instance:refreshDailyShow()
	local entityDict = self:getCharEntityDict()
	local removeList = {}

	for skinId, entity in pairs(entityDict) do
		local isKeep = false

		for _, keepSkinId in ipairs(skinIdList) do
			if skinId == keepSkinId then
				isKeep = true

				break
			end
		end

		if not isKeep then
			table.insert(removeList, entity)
		end
	end

	for _, entity in ipairs(removeList) do
		self:removeUnit(entity:tag(), entity.id)
	end

	for _, skinId in ipairs(skinIdList) do
		self:addCharEntity(skinId)
	end

	self:dispatchEvent(V4a1_LibraryEvent.OnShowCharsChanged, skinIdList)
end

function V4a1_LibrarySceneEntityMgr:addCharEntity(skinId)
	if not V4a1_LibraryConfig.instance:getCharCO(skinId) then
		return
	end

	if self:getCharEntity(skinId) then
		return
	end

	local ctorParam = {
		parent = self,
		sceneObj = self:sceneObj(),
		id = skinId
	}
	local item = self:newGoMonoBehavior(V4a1_LibraryCharEntity, ctorParam)

	self:addUnit(item)

	return item
end

function V4a1_LibrarySceneEntityMgr:getRaycastChar(screenPos)
	if not screenPos then
		return
	end

	local csRay = self:getCSRay(screenPos)
	local entityDict = self:getCharEntityDict()

	for skinId, entity in pairs(entityDict) do
		local csBoxCollider2D = entity:spineComp():getBoxCollider2D()
		local posV3 = entity:getPosition()

		if self:isRayOverlapCollider2DAtZ(csRay, csBoxCollider2D, posV3.z) then
			return skinId, entity
		end
	end
end

function V4a1_LibrarySceneEntityMgr:getCharEntity(skinId)
	return self:getCharEntityDict()[skinId]
end

function V4a1_LibrarySceneEntityMgr:getCharEntityDict()
	return self._tagUnitDict[SceneTag.Untagged] or {}
end

function V4a1_LibrarySceneEntityMgr:containerGO()
	return self:sceneGoComp():getCharsRootGo()
end

function V4a1_LibrarySceneEntityMgr:onSceneStart()
	V4a1_LibrarySceneEntityMgr.super.onSceneStart(self)
end

function V4a1_LibrarySceneEntityMgr:onSceneClose()
	self:removeAllUnits()
	V4a1_LibrarySceneEntityMgr.super.onSceneClose(self)
end

function V4a1_LibrarySceneEntityMgr:addEventListeners()
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
end

function V4a1_LibrarySceneEntityMgr:removeEventListeners()
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
end

return V4a1_LibrarySceneEntityMgr
