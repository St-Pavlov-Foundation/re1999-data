-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/scene/comp/ArcadeSurvivorEffectMgr.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.scene.comp.ArcadeSurvivorEffectMgr", package.seeall)

local ArcadeSurvivorEffectMgr = class("ArcadeSurvivorEffectMgr", ArcadeSurvivorBaseSceneComp)
local VFX_POOL_MAX_COUNT_PER_RES = 8
local VFX_POOL_WARM_COUNT_PER_RES = 1

function ArcadeSurvivorEffectMgr:onInit()
	self._vfxGOPool = self:getUserDataTb_()
	self._vfxGOLoadCBDict = {}
	self._showItemDict = {}
	self._bulletGODict = self:getUserDataTb_()
	self._bulletTweenDict = {}
	self._groupBulletItems = {}
	self._grayscaleShow = ArcadeSurvivorGrayscaleShow.New()
	self._afterimageShow = ArcadeSurvivorAfterimageShow.New(self.go)

	transformhelper.setLocalPos(self.trans, 0, 0, ArcadeSurvivorGameEnum.Const.EffectZLevel)
end

function ArcadeSurvivorEffectMgr:onUpdate()
	self._afterimageShow:update()

	for _, item in pairs(self._showItemDict) do
		item:onUpdate()
	end
end

function ArcadeSurvivorEffectMgr:onEntityDestroy(entity)
	self._grayscaleShow:checkOwnerClear(entity)
end

function ArcadeSurvivorEffectMgr:startMoveAfterimage(entity, moveEffectShowId)
	local isValidShowId = moveEffectShowId and moveEffectShowId ~= 0

	if not isValidShowId then
		return
	end

	local showMode = ArcadeSurvivorConfig.instance:getShowTriggerShowMode(moveEffectShowId)

	if showMode ~= ArcadeSurvivorEnum.GridShowMode.Afterimage then
		return
	end

	self._afterimageShow:start(entity, moveEffectShowId)
	self:_playShowAudioId(moveEffectShowId)
end

function ArcadeSurvivorEffectMgr:stopMoveAfterimage(entity)
	self._afterimageShow:stop(entity)
end

function ArcadeSurvivorEffectMgr:setShowActive(showId, active, ownerEntity)
	local result = false
	local showMode = ArcadeSurvivorConfig.instance:getShowTriggerShowMode(showId)

	if showMode == ArcadeSurvivorEnum.GridShowMode.Grayscale then
		self._grayscaleShow:setOwnerActive(active, ownerEntity, showId)

		result = true
	else
		logError("不支持的持续表现 ID: " .. tostring(showId))
	end

	return result
end

function ArcadeSurvivorEffectMgr:registerGrayscaleGO(go, excludeTrans)
	self._grayscaleShow:registerGO(go, excludeTrans)
end

function ArcadeSurvivorEffectMgr:unregisterGrayscaleGO(go)
	if go then
		self._grayscaleShow:unregisterGO(go)
	end
end

function ArcadeSurvivorEffectMgr:getOriginalMaterials(renderer)
	return self._grayscaleShow:getOriginalMaterials(renderer)
end

function ArcadeSurvivorEffectMgr:playTriggerShow(showId, gridIdDict, startX, startY, direction)
	local isValidShowId = showId and showId ~= 0

	if not gridIdDict or not isValidShowId then
		return
	end

	local scene = ArcadeSurvivorGameController.instance:getGameScene()

	if not scene then
		return
	end

	local showMode = ArcadeSurvivorConfig.instance:getShowTriggerShowMode(showId)

	if showMode == ArcadeSurvivorEnum.GridShowMode.Normal then
		local needShake = ArcadeSurvivorConfig.instance:getShowNeedShake(showId)

		if needShake then
			scene:playShakeEff()
		end

		for gridId, _ in pairs(gridIdDict) do
			local gridX, gridY = ArcadeSurvivorGameHelper.getGridXYById(gridId)

			self:playGridShow(showId, gridX, gridY, direction)
		end
	elseif showMode == ArcadeSurvivorEnum.GridShowMode.Area then
		self:playAreaShow(showId, gridIdDict)
	elseif showMode == ArcadeSurvivorEnum.GridShowMode.GroupBullet then
		local param = ArcadeSurvivorConfig.instance:getShowTriggerShowModeParam(showId)

		if string.nilorempty(param) or not startX or not startY then
			self:playGroupBulletShow(showId, gridIdDict)
		elseif param == ArcadeSurvivorEnum.BulletShowParam.BulletShow then
			self:playBulletShow(showId, startX, startY, direction)
		elseif param == ArcadeSurvivorEnum.BulletShowParam.GroupBulletWithStartPos then
			self:playGroupBulletShow(showId, gridIdDict, startX, startY)
		end
	elseif showMode == ArcadeSurvivorEnum.GridShowMode.Afterimage then
		return
	else
		logError(string.format("ArcadeSurvivorEffectMgr:playTriggerShow showMode %s not support", showMode))
	end
end

function ArcadeSurvivorEffectMgr:playGridShow(showId, gridX, gridY, direction, handlerCls, extraData)
	if not gridX or not gridY or ArcadeSurvivorGameHelper.isOutsideMap(gridX, gridY) then
		return
	end

	local scene = ArcadeSurvivorGameController.instance:getGameScene()
	local resName = ArcadeSurvivorConfig.instance:getShowResName(showId)

	if not scene or string.nilorempty(resName) or not gridX or not gridY then
		return
	end

	local item = self:_getOrCreateGridShowItem(showId, resName, handlerCls)

	item:playShow(gridX, gridY, direction, extraData)
end

function ArcadeSurvivorEffectMgr:_getOrCreateGridShowItem(showId, resName, handlerCls)
	local item = self._showItemDict[showId]

	if not item then
		item = ArcadeSurvivorGridShowItem.New(self, showId, resName, handlerCls)
		self._showItemDict[showId] = item
	end

	return item
end

function ArcadeSurvivorEffectMgr:playAreaShow(showId, gridIdDict)
	local posX, posY, direction = ArcadeSurvivorGameHelper.getAreaShowPosition(gridIdDict)

	if not posX then
		return
	end

	local scene = ArcadeSurvivorGameController.instance:getGameScene()
	local resName = ArcadeSurvivorConfig.instance:getShowResName(showId)

	if not scene or string.nilorempty(resName) then
		return
	end

	if ArcadeSurvivorConfig.instance:getShowNeedShake(showId) then
		scene:playShakeEff()
	end

	local item = self:_getOrCreateGridShowItem(showId, resName)

	item:playPositionShow(posX, posY, direction)
end

function ArcadeSurvivorEffectMgr:getShowActiveEffectDict(showId)
	local item = self._showItemDict[showId]

	if item then
		return item:getActiveEffectDict()
	end
end

function ArcadeSurvivorEffectMgr:removeGridShow(showId, gridX, gridY)
	local gridId = ArcadeSurvivorGameHelper.getGridId(gridX, gridY)
	local item = self._showItemDict[showId]

	if not item then
		return
	end

	item:removeActiveEffect(gridId)
end

function ArcadeSurvivorEffectMgr:playBulletShow(showId, startX, startY, direction)
	local scene = ArcadeSurvivorGameController.instance:getGameScene()
	local resName = ArcadeSurvivorConfig.instance:getShowResName(showId)
	local hasResName = not string.nilorempty(resName)

	if not scene or not hasResName or not startX or not startY then
		return
	end

	local effectGO = self._bulletGODict[resName]
	local hasEffectGO = not gohelper.isNil(effectGO)

	if hasEffectGO then
		self:_beginTweenBullet(showId, effectGO, startX, startY, direction)

		return
	end

	local resPath = ResUrl.getArcadeSurvivorEffectRes(resName)

	scene.loader:loadRes(resPath, self._onLoadBulletEffectFinished, self, {
		showId = showId,
		resName = resName,
		resPath = resPath,
		startX = startX,
		startY = startY,
		direction = direction
	})
end

function ArcadeSurvivorEffectMgr:_removeBulletShow(showId)
	local resName = self:_getBulletResName(showId)
	local effectGO = self._bulletGODict[resName]

	if not gohelper.isNil(effectGO) then
		gohelper.setActive(effectGO, false)
	end
end

function ArcadeSurvivorEffectMgr:_onLoadBulletEffectFinished(param)
	if not self._initialized then
		return
	end

	local scene = ArcadeSurvivorGameController.instance:getGameScene()
	local assetRes = scene and scene.loader:getResource(param.resPath)

	if not assetRes then
		return
	end

	local effectGO = gohelper.clone(assetRes, self.go)

	self:registerGrayscaleGO(effectGO)

	self._bulletGODict[param.resName] = effectGO

	self:_beginTweenBullet(param.showId, effectGO, param.startX, param.startY, param.direction)
end

function ArcadeSurvivorEffectMgr:_getBulletResName(showId)
	return ArcadeSurvivorConfig.instance:getShowResName(showId)
end

function ArcadeSurvivorEffectMgr:_beginTweenBullet(showId, effectGO, startX, startY, direction)
	local speed = ArcadeSurvivorConfig.instance:getShowSpeed(showId)

	if not speed or speed <= 0 then
		self:_removeBulletShow(showId)

		return
	end

	local cfgDirection = ArcadeSurvivorConfig.instance:getShowDirection(showId)

	if cfgDirection and cfgDirection ~= 0 then
		direction = cfgDirection
	end

	local startGridX, startGridY, targetGridX, targetGridY = self:_getBulletGridRect(showId, startX, startY, direction)

	if not targetGridX or not targetGridY then
		self:_removeBulletShow(showId)

		return
	end

	local beginPosX, beginPosY = ArcadeSurvivorGameHelper.grid2Position(startGridX, startGridY)
	local targetPosX, targetPosY = ArcadeSurvivorGameHelper.grid2Position(targetGridX, targetGridY)
	local distance = math.abs(targetPosY - beginPosY)

	if direction == ArcadeSurvivorEnum.Direction.Left or direction == ArcadeSurvivorEnum.Direction.Right then
		distance = math.abs(targetPosX - beginPosX)
	end

	if distance <= 0 then
		self:_removeBulletShow(showId)

		return
	end

	self:_removeAllBulletShow()

	local effectTrans = effectGO.transform

	transformhelper.setLocalPosXY(effectTrans, beginPosX, beginPosY)
	ArcadeSurvivorGameHelper.setShowRotationByType(showId, effectTrans, direction)
	gohelper.setActive(effectGO, true)
	self:_playShowAudioId(showId)

	local resName = self:_getBulletResName(showId)

	self._bulletGODict[resName] = effectGO
	self._bulletTweenDict[resName] = ZProj.TweenHelper.DOLocalMove(effectTrans, targetPosX, targetPosY, ArcadeSurvivorGameEnum.Const.EffectZLevel, distance / speed, self._onBulletTweenEnd, self, showId, EaseType.Linear)
end

function ArcadeSurvivorEffectMgr:_getBulletGridRect(showId, sourceGridX, sourceGridY, direction)
	local mapSizeX, mapSizeY = ArcadeSurvivorGameModel.instance:getMapSize()
	local minimumCoordinate = ArcadeSurvivorGameEnum.Const.MinimumCoordinate
	local isFromBorder = ArcadeSurvivorConfig.instance:getShowIsFromBorder(showId)
	local startGridX, startGridY, targetGridX, targetGridY

	if direction == ArcadeSurvivorEnum.Direction.Up then
		startGridY = isFromBorder and minimumCoordinate - 1 or sourceGridY + 1
		startGridX = sourceGridX
		targetGridX = startGridX
		targetGridY = mapSizeY + 1
	elseif direction == ArcadeSurvivorEnum.Direction.Down then
		startGridY = isFromBorder and mapSizeY + 1 or sourceGridY - 1
		startGridX = sourceGridX
		targetGridX = startGridX
		targetGridY = minimumCoordinate - 1
	elseif direction == ArcadeSurvivorEnum.Direction.Left then
		startGridX = isFromBorder and mapSizeX + 1 or sourceGridX - 1
		startGridY = sourceGridY
		targetGridX = minimumCoordinate - 1
		targetGridY = startGridY
	elseif direction == ArcadeSurvivorEnum.Direction.Right then
		startGridX = isFromBorder and minimumCoordinate - 1 or sourceGridX + 1
		startGridY = sourceGridY
		targetGridX = mapSizeX + 1
		targetGridY = startGridY
	end

	return startGridX, startGridY, targetGridX, targetGridY
end

function ArcadeSurvivorEffectMgr:_onBulletTweenEnd(showId)
	self:_killBulletTween(showId)
end

function ArcadeSurvivorEffectMgr:_killBulletTween(showId)
	local resName = self:_getBulletResName(showId)
	local tweenId = self._bulletTweenDict[resName]

	if tweenId then
		ZProj.TweenHelper.KillById(tweenId)
	end

	self._bulletTweenDict[resName] = nil

	self:_removeBulletShow(showId)
end

function ArcadeSurvivorEffectMgr:playGroupBulletShow(showId, gridIdDict, startX, startY)
	local direction = ArcadeSurvivorConfig.instance:getShowDirection(showId)
	local rectStartX, rectStartY, rectEndX, rectEndY = self:_getGroupBulletGridRect(gridIdDict, startX, startY, direction)

	if not rectStartX then
		return
	end

	local speed = ArcadeSurvivorConfig.instance:getShowSpeed(showId)
	local resName = ArcadeSurvivorConfig.instance:getShowResName(showId)

	if not speed or speed <= 0 or string.nilorempty(resName) then
		return
	end

	local fromX, fromY = ArcadeSurvivorGameHelper.grid2Position(rectStartX, rectStartY)
	local toX, toY = ArcadeSurvivorGameHelper.grid2Position(rectEndX, rectEndY)
	local offsetX, offsetY = ArcadeSurvivorConfig.instance:getShowOffset(showId)
	local item = {
		showId = showId,
		resName = resName,
		direction = direction,
		fromX = fromX + offsetX,
		fromY = fromY + offsetY,
		toX = toX + offsetX,
		toY = toY + offsetY,
		duration = (math.abs(toX - fromX) + math.abs(toY - fromY)) / speed
	}

	self:getVfxGO(resName, self._onGetGroupBulletFinished, self, item)
end

function ArcadeSurvivorEffectMgr:_getGroupBulletGridRect(gridIdDict, startX, startY, direction)
	local minX, maxX, minY, maxY

	for gridId in pairs(gridIdDict) do
		local x, y = ArcadeSurvivorGameHelper.getGridXYById(gridId)

		minX = minX and math.min(minX, x) or x
		maxX = maxX and math.max(maxX, x) or x
		minY = minY and math.min(minY, y) or y
		maxY = maxY and math.max(maxY, y) or y
	end

	if not minX then
		return
	end

	local centerX, centerY = (minX + maxX) * 0.5, (minY + maxY) * 0.5

	if startX and startY then
		centerX, centerY = startX, startY
	end

	local mapSizeX, mapSizeY = ArcadeSurvivorGameModel.instance:getMapSize()
	local minimum = ArcadeSurvivorGameEnum.Const.MinimumCoordinate
	local directions = ArcadeSurvivorEnum.Direction

	if direction == directions.Left then
		return maxX + 0.5, centerY, minimum - 1, centerY
	elseif direction == directions.Right then
		return minX - 0.5, centerY, mapSizeX + 1, centerY
	elseif direction == directions.Up then
		return centerX, minY - 0.5, centerX, mapSizeY + 1
	elseif direction == directions.Down then
		return centerX, maxY + 0.5, centerX, minimum - 1
	end
end

function ArcadeSurvivorEffectMgr:_onGetGroupBulletFinished(item)
	if not self._initialized then
		return
	end

	local effectGO = item.vfxGO
	local transform = effectGO.transform

	item.originalRotation = transform.localRotation
	item.originalScale = transform.localScale

	gohelper.setActive(effectGO, false)

	self._groupBulletItems[item] = true

	transformhelper.setLocalPos(transform, item.fromX, item.fromY, 0)

	local scale = ArcadeSurvivorConfig.instance:getShowScale(item.showId) or 1

	transformhelper.setLocalScale(transform, scale, scale, 1)
	ArcadeSurvivorGameHelper.setShowRotationByType(item.showId, transform, item.direction)
	gohelper.setActive(effectGO, true)
	self:_playShowAudioId(item.showId)

	if ArcadeSurvivorConfig.instance:getShowNeedShake(item.showId) then
		local scene = ArcadeSurvivorGameController.instance:getGameScene()

		scene:playShakeEff()
	end

	item.tweenId = ZProj.TweenHelper.DOLocalMove(transform, item.toX, item.toY, 0, item.duration, self._onGroupBulletEnd, self, item, EaseType.Linear)
end

function ArcadeSurvivorEffectMgr:_onGroupBulletEnd(item)
	self._groupBulletItems[item] = nil
	item.vfxGO.transform.localRotation = item.originalRotation
	item.vfxGO.transform.localScale = item.originalScale

	self:recycleVfxGO(item.resName, item.vfxGO)
end

function ArcadeSurvivorEffectMgr:_clearGroupBullets()
	for item in pairs(self._groupBulletItems) do
		ZProj.TweenHelper.KillById(item.tweenId)
		self:_onGroupBulletEnd(item)
	end
end

function ArcadeSurvivorEffectMgr:getVfxGO(resName, cb, cbObj, cbParam)
	local scene = ArcadeSurvivorGameController.instance:getGameScene()

	if not scene then
		return
	end

	local go = self:_getVfxGOFromPool(resName)

	if go then
		self:_dispatchVfxGO(go, cb, cbObj, cbParam)

		return
	end

	local cbData = {
		cb = cb,
		cbObj = cbObj,
		cbParam = cbParam
	}
	local callbackList = self._vfxGOLoadCBDict[resName]

	if callbackList then
		callbackList[#callbackList + 1] = cbData

		return
	end

	self._vfxGOLoadCBDict[resName] = {
		cbData
	}

	local resPath = ResUrl.getArcadeSurvivorEffectRes(resName)

	scene.loader:loadRes(resPath, self._onLoadVfxGOFinished, self, {
		resName = resName,
		resPath = resPath
	})
end

function ArcadeSurvivorEffectMgr:_getVfxGOFromPool(resName)
	local stack = self._vfxGOPool[resName]

	if not stack or #stack <= 0 then
		return
	end

	return table.remove(stack)
end

function ArcadeSurvivorEffectMgr:_onLoadVfxGOFinished(param)
	if not self._initialized or not param then
		return
	end

	local resName = param.resName
	local callbackList = self._vfxGOLoadCBDict[resName]

	if not callbackList then
		return
	end

	self._vfxGOLoadCBDict[resName] = nil

	local scene = ArcadeSurvivorGameController.instance:getGameScene()
	local assetRes = scene and scene.loader:getResource(param.resPath)

	if not assetRes then
		return
	end

	local callbackCount = #callbackList

	for index = 1, callbackCount do
		local cbData = callbackList[index]
		local go = gohelper.clone(assetRes, self.go)

		self:_dispatchVfxGO(go, cbData.cb, cbData.cbObj, cbData.cbParam)
	end
end

function ArcadeSurvivorEffectMgr:_dispatchVfxGO(go, cb, cbObj, cbParam)
	local needGrayscaleExclude = false

	if cbParam then
		needGrayscaleExclude = cbParam.needGrayscaleExclude
	end

	if not needGrayscaleExclude then
		self:registerGrayscaleGO(go)
	end

	local callbackParam = cbParam or {}

	callbackParam.vfxGO = go

	GameUtil.handleCallbackFunc(cb, cbObj, callbackParam)
end

function ArcadeSurvivorEffectMgr:recycleVfxGO(resName, go)
	self:unregisterGrayscaleGO(go)

	local stack = GameUtil.tabletool_checkDictTable(self._vfxGOPool, resName)

	if #stack >= VFX_POOL_MAX_COUNT_PER_RES then
		gohelper.destroy(go)

		return
	end

	gohelper.setActive(go, false)

	stack[#stack + 1] = go
end

function ArcadeSurvivorEffectMgr:_shrinkVfxPool()
	local pool = self._vfxGOPool

	for _, stack in pairs(pool) do
		while #stack > VFX_POOL_WARM_COUNT_PER_RES do
			local go = table.remove(stack)

			gohelper.destroy(go)
		end
	end
end

function ArcadeSurvivorEffectMgr:_playShowAudioId(showId)
	local audioId = ArcadeSurvivorConfig.instance:getShowAudio(showId)

	if audioId and audioId > 0 then
		AudioMgr.instance:trigger(audioId)
	end
end

function ArcadeSurvivorEffectMgr:_clearAllShowItems()
	for _, item in pairs(self._showItemDict) do
		item:clear()
	end

	self._showItemDict = {}
end

function ArcadeSurvivorEffectMgr:_removeAllBulletShow()
	for _, tweenId in pairs(self._bulletTweenDict) do
		if tweenId then
			ZProj.TweenHelper.KillById(tweenId)
		end
	end

	self._bulletTweenDict = {}

	for _, effectGO in pairs(self._bulletGODict) do
		gohelper.setActive(effectGO, false)
	end
end

function ArcadeSurvivorEffectMgr:clearAllShow()
	self._grayscaleShow:deactivateGrayscale()
	self._afterimageShow:clear()

	self._vfxGOLoadCBDict = {}

	self:_clearGroupBullets()
	self:_removeAllBulletShow()
	self:_clearAllShowItems()
	self:_shrinkVfxPool()
end

function ArcadeSurvivorEffectMgr:onClear()
	self._grayscaleShow:clear()
	self._afterimageShow:clear()
	self:_clearGroupBullets()
	self:_removeAllBulletShow()
	self:_clearAllShowItems()

	self._bulletGODict = self:getUserDataTb_()
	self._vfxGOPool = self:getUserDataTb_()
	self._vfxGOLoadCBDict = {}
end

return ArcadeSurvivorEffectMgr
