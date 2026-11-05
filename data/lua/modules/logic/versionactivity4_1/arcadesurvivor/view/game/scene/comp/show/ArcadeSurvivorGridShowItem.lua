-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/scene/comp/show/ArcadeSurvivorGridShowItem.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.scene.comp.show.ArcadeSurvivorGridShowItem", package.seeall)

local ArcadeSurvivorGridShowItem = class("ArcadeSurvivorGridShowItem")

function ArcadeSurvivorGridShowItem:ctor(effectMgr, showId, resName, activeHandlerCls)
	self._showId = showId
	self._resName = resName
	self._effectMgr = effectMgr
	self._activeHandler = nil

	if activeHandlerCls then
		self._activeHandler = activeHandlerCls.New()
	end

	self._activeEffectDict = {}
	self._tempEffectDict = {}
end

function ArcadeSurvivorGridShowItem:playShow(gridX, gridY, direction, extraData)
	local duration = ArcadeSurvivorConfig.instance:getShowDuration(self._showId)
	local gridId = ArcadeSurvivorGameHelper.getGridId(gridX, gridY)

	if duration and duration > 0 then
		self:_playTempEffect(gridId, direction, duration)
	else
		self:_playActiveEffect(gridId, direction, extraData)
	end
end

function ArcadeSurvivorGridShowItem:onUpdate()
	self:updateTempEffects()

	if self._activeHandler and self._activeHandler.onUpdate then
		self._activeHandler:onUpdate()
	end
end

function ArcadeSurvivorGridShowItem:_playActiveEffect(gridId, direction, extraData)
	local effectGO = self._activeEffectDict[gridId]

	if effectGO and self._activeHandler then
		self._activeHandler:onRefresh(gridId, extraData)
	else
		local needGrayscaleExclude = false

		if self._activeHandler and self._activeHandler.getGrayscaleExcludeTrans then
			needGrayscaleExclude = true
		end

		local param = {
			gridId = gridId,
			direction = direction,
			extraData = extraData,
			needGrayscaleExclude = needGrayscaleExclude
		}
		local reusableEffectGO

		if self._activeHandler and self._activeHandler.getReusableEffectGO then
			reusableEffectGO = self._activeHandler:getReusableEffectGO(gridId)
		end

		if reusableEffectGO then
			param.vfxGO = reusableEffectGO

			self:_onGetActiveEffectGOFinished(param)
		else
			self._effectMgr:getVfxGO(self._resName, self._onGetActiveEffectGOFinished, self, param)
		end
	end
end

function ArcadeSurvivorGridShowItem:_onGetActiveEffectGOFinished(param)
	local isInit = self._effectMgr and self._effectMgr:isInitialized()

	if not isInit or not param then
		return
	end

	local gridId = param.gridId
	local newEffectGO = param.vfxGO
	local existEffectGO = self._activeEffectDict[gridId]

	if existEffectGO then
		self._effectMgr:recycleVfxGO(self._resName, newEffectGO)

		return
	end

	if gohelper.isNil(newEffectGO) then
		return
	end

	local gridX, gridY = ArcadeSurvivorGameHelper.getGridXYById(gridId)

	self:_setEffectGOTrans(newEffectGO, gridX, gridY, param.direction)

	self._activeEffectDict[gridId] = newEffectGO

	if self._activeHandler then
		self._activeHandler:onGetGO(gridId, newEffectGO, param.extraData)

		if param.needGrayscaleExclude then
			local grayscaleExcludeTrans = self._activeHandler:getGrayscaleExcludeTrans()

			self._effectMgr:registerGrayscaleGO(newEffectGO, grayscaleExcludeTrans)
		end
	end

	gohelper.setActive(newEffectGO, true)
	self._effectMgr:_playShowAudioId(self._showId)
end

function ArcadeSurvivorGridShowItem:removeActiveEffect(gridId)
	local effectGO = self._activeEffectDict[gridId]

	if not effectGO then
		return false
	end

	self._activeEffectDict[gridId] = nil

	local retainEffectGO = false

	if self._activeHandler then
		retainEffectGO = self._activeHandler:onRemoved(gridId)
	end

	if not retainEffectGO then
		self._effectMgr:recycleVfxGO(self._resName, effectGO)
	end

	return true
end

function ArcadeSurvivorGridShowItem:getActiveEffectDict()
	return self._activeEffectDict
end

function ArcadeSurvivorGridShowItem:playPositionShow(posX, posY, direction)
	local param = {
		posX = posX,
		posY = posY,
		direction = direction,
		duration = ArcadeSurvivorConfig.instance:getShowDuration(self._showId)
	}

	self._effectMgr:getVfxGO(self._resName, self._onGetPositionEffectGOFinished, self, param)
end

function ArcadeSurvivorGridShowItem:_onGetPositionEffectGOFinished(param)
	if not self._effectMgr:isInitialized() then
		return
	end

	local effectGO = param.vfxGO
	local transform = effectGO.transform
	local item = {
		effectGO = effectGO,
		startTime = Time.time,
		duration = param.duration,
		originalRotation = transform.localRotation,
		originalScale = transform.localScale
	}

	self._tempEffectDict[param] = item

	self:_setEffectPosition(effectGO, param.posX, param.posY, param.direction)
	gohelper.setActive(effectGO, true)
	self._effectMgr:_playShowAudioId(self._showId)
end

function ArcadeSurvivorGridShowItem:_playTempEffect(gridId, direction, duration)
	local item = self._tempEffectDict[gridId]

	if item then
		self:_resetTempEffect(item, gridId, direction, duration)
	else
		local param = {
			gridId = gridId,
			direction = direction,
			duration = duration
		}

		self._effectMgr:getVfxGO(self._resName, self._onGetTempEffectGOFinished, self, param)
	end
end

function ArcadeSurvivorGridShowItem:_onGetTempEffectGOFinished(param)
	local isInit = self._effectMgr:isInitialized()

	if not isInit or not param then
		return
	end

	local gridId = param.gridId
	local duration = param.duration
	local newEffectGO = param.vfxGO
	local direction = param.direction
	local item = self._tempEffectDict[gridId]

	if item then
		self._effectMgr:recycleVfxGO(self._resName, newEffectGO)
		self:_resetTempEffect(item, gridId, direction, duration)

		return
	end

	item = {
		effectGO = newEffectGO
	}
	self._tempEffectDict[gridId] = item

	self:_resetTempEffect(item, gridId, direction, duration)
end

function ArcadeSurvivorGridShowItem:_resetTempEffect(item, gridId, direction, duration)
	if not item then
		return
	end

	item.startTime = Time.time
	item.duration = duration

	local gridX, gridY = ArcadeSurvivorGameHelper.getGridXYById(gridId)

	self:_setEffectGOTrans(item.effectGO, gridX, gridY, direction)
	gohelper.setActive(item.effectGO, false)
	gohelper.setActive(item.effectGO, true)
	self._effectMgr:_playShowAudioId(self._showId)
end

function ArcadeSurvivorGridShowItem:updateTempEffects()
	local now = Time.time
	local aliveCount = 0

	for gridId, item in pairs(self._tempEffectDict) do
		if now - item.startTime >= item.duration then
			self:_recycleTempEffect(item)

			self._tempEffectDict[gridId] = nil
		else
			aliveCount = aliveCount + 1
		end
	end

	return aliveCount > 0
end

function ArcadeSurvivorGridShowItem:_setEffectGOTrans(effectGO, gridX, gridY, direction)
	local posX, posY = ArcadeSurvivorGameHelper.grid2Position(gridX, gridY)

	self:_setEffectPosition(effectGO, posX, posY, direction)
end

function ArcadeSurvivorGridShowItem:_setEffectPosition(effectGO, posX, posY, direction)
	local transform = effectGO and effectGO.transform

	if not transform then
		return
	end

	local offsetX, offsetY = ArcadeSurvivorConfig.instance:getShowOffset(self._showId)

	transformhelper.setLocalPos(transform, posX + offsetX, posY + offsetY, 0)

	local scale = ArcadeSurvivorConfig.instance:getShowScale(self._showId)

	if scale and scale ~= 1 then
		transformhelper.setLocalScale(effectGO.transform, scale, scale, 1)
	end

	ArcadeSurvivorGameHelper.setShowRotationByType(self._showId, transform, direction)
end

function ArcadeSurvivorGridShowItem:_recycleTempEffect(item)
	if item.originalRotation then
		item.effectGO.transform.localRotation = item.originalRotation
		item.effectGO.transform.localScale = item.originalScale
	end

	self._effectMgr:recycleVfxGO(self._resName, item.effectGO)
end

function ArcadeSurvivorGridShowItem:clear()
	for _, effectGO in pairs(self._activeEffectDict) do
		self._effectMgr:recycleVfxGO(self._resName, effectGO)
	end

	self._activeEffectDict = {}

	for _, item in pairs(self._tempEffectDict) do
		self:_recycleTempEffect(item)
	end

	self._tempEffectDict = {}

	local retainedEffectGODict

	if self._activeHandler and self._activeHandler.getRetainedEffectGODict then
		retainedEffectGODict = self._activeHandler:getRetainedEffectGODict()
	end

	if retainedEffectGODict then
		for effectGO in pairs(retainedEffectGODict) do
			self._effectMgr:recycleVfxGO(self._resName, effectGO)
		end
	end

	if self._activeHandler then
		self._activeHandler:onClear()
	end
end

return ArcadeSurvivorGridShowItem
