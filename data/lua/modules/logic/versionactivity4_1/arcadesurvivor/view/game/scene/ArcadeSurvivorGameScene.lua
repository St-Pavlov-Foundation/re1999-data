-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/scene/ArcadeSurvivorGameScene.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.scene.ArcadeSurvivorGameScene", package.seeall)

local ArcadeSurvivorGameScene = class("ArcadeSurvivorGameScene")

function ArcadeSurvivorGameScene:onEnterGame(isRestart)
	self:clear()
	self:_initScene()

	self._isRestart = isRestart
end

function ArcadeSurvivorGameScene:_initScene()
	local mainTrans = CameraMgr.instance:getMainCameraTrs().parent
	local _, y, _ = transformhelper.getLocalPos(mainTrans)
	local root = CameraMgr.instance:getSceneRoot()

	self._goScene = gohelper.create3d(root, ArcadeSurvivorGameEnum.Const.GameSceneName)

	transformhelper.setLocalPos(self._goScene.transform, 0, y, 0)

	self._sceneOffsetY = y
	self._goRoot = gohelper.create3d(self._goScene, ArcadeSurvivorGameEnum.Const.GameSceneRoot)

	transformhelper.setLocalPos(self._goRoot.transform, 0, 0, 0)

	self._goSceneResNode = gohelper.create3d(self._goRoot, ArcadeSurvivorGameEnum.Const.GameSceneResNode)

	transformhelper.setLocalPos(self._goSceneResNode.transform, 0, 0, 0)

	self._goContent = gohelper.create3d(self._goRoot, ArcadeSurvivorGameEnum.Const.GameSceneContentNode)
	self._transContent = self._goContent.transform

	transformhelper.setLocalPos(self._transContent, 0, 0, 0)
	self:_addComp("loader", ArcadeSurvivorLoader)
	self:_addComp("tileMgr", ArcadeSurvivorTileMgr, true)
	self:_addComp("effectMgr", ArcadeSurvivorEffectMgr, true)
	self:_addComp("entityMgr", ArcadeSurvivorEntityMgr, true)

	local entityMgrStartWork = ArcadePreGameStartWork.New(self.entityMgr)
	local waitViewOpenWork
	local gameViewName = ViewName.ArcadeSurvivorGameView
	local isOpen = ViewMgr.instance:isOpen(gameViewName)

	if not isOpen then
		waitViewOpenWork = WaitEventWork.New("ViewMgr;ViewEvent;OnOpenView;" .. gameViewName)
	end

	self._preGameStartFlow = FlowSequence.New()

	self._preGameStartFlow:addWork(entityMgrStartWork)

	if waitViewOpenWork then
		self._preGameStartFlow:addWork(waitViewOpenWork)
	end

	self._preGameStartFlow:registerDoneListener(self._initSceneFinish, self)

	local animControllerPath = string.format("%s/vx/ani/%s", ArcadeSurvivorEnum.ResDir.SceneRes, ArcadeSurvivorEnum.Const.SceneAnimController)

	self.loader:loadRes(animControllerPath, self._onLoadShakeController, self)
end

function ArcadeSurvivorGameScene:_onLoadShakeController()
	local animControllerPath = string.format("%s/vx/ani/%s", ArcadeSurvivorEnum.ResDir.SceneRes, ArcadeSurvivorEnum.Const.SceneAnimController)
	local controllerRes = self.loader:getResource(animControllerPath)

	if controllerRes then
		self._sceneAnimator = gohelper.onceAddComponent(self._goRoot, typeof(UnityEngine.Animator))
		self._sceneAnimator.runtimeAnimatorController = controllerRes
		self._sceneAnimator.enabled = true
	end

	self._preGameStartFlow:start()
end

function ArcadeSurvivorGameScene:_addComp(compName, compClass, needContentGO)
	local go = self._goScene

	if needContentGO then
		go = gohelper.create3d(self._goContent, compName)
	end

	local compInst = MonoHelper.addNoUpdateLuaComOnceToGo(go, compClass, compName)

	self[compName] = compInst

	table.insert(self._compList, compInst)
end

function ArcadeSurvivorGameScene:_initSceneFinish()
	ArcadeSurvivorGameController.instance:startGame(self._isRestart)

	self._isRestart = nil
end

function ArcadeSurvivorGameScene:changeSceneRes(targetSceneResName, cb, cbObj, cbParam)
	if string.nilorempty(targetSceneResName) then
		return
	end

	if self._loadingSceneResName then
		if self._loadingSceneResName == targetSceneResName then
			self._changeSceneCb = cb
			self._changeSceneCbObj = cbObj
			self._changeSceneCbParam = cbParam

			return
		else
			self._loadingSceneResName = nil
			self._changeSceneCb = nil
			self._changeSceneCbObj = nil
			self._changeSceneCbParam = nil
		end
	end

	if self._curSceneResName == targetSceneResName and not gohelper.isNil(self._goSceneRes) then
		GameUtil.handleCallbackFunc(cb, cbObj, cbParam)

		return
	end

	UIBlockMgr.instance:startBlock(ArcadeSurvivorEnum.BlockKey.LoadGameScene)

	self._changeSceneCb = cb
	self._changeSceneCbObj = cbObj
	self._changeSceneCbParam = cbParam
	self._loadingSceneResName = targetSceneResName

	local sceneResUrl = ResUrl.getArcadeSurvivorScenePrefabRes(ArcadeSurvivorEnum.ResDir.ScenePrefab, self._loadingSceneResName)

	self.loader:loadRes(sceneResUrl, self._onLoadSceneResFinish, self, targetSceneResName)
end

function ArcadeSurvivorGameScene:_onLoadSceneResFinish(sceneResName)
	if self._loadingSceneResName ~= sceneResName then
		return
	end

	UIBlockMgr.instance:endBlock(ArcadeSurvivorEnum.BlockKey.LoadGameScene)

	local sceneResUrl = ResUrl.getArcadeSurvivorScenePrefabRes(ArcadeSurvivorEnum.ResDir.ScenePrefab, self._loadingSceneResName)
	local sceneResourceObj = self.loader:getResource(sceneResUrl)

	if not sceneResourceObj then
		return
	end

	local goNewScene = gohelper.clone(sceneResourceObj, self._goSceneResNode)

	if gohelper.isNil(goNewScene) then
		return
	end

	self:_clearSceneRes()

	self._goSceneRes = goNewScene

	self.effectMgr:registerGrayscaleGO(goNewScene)

	self._curSceneResName = self._loadingSceneResName
	self._loadingSceneResName = nil

	GameUtil.handleCallbackFunc(self._changeSceneCb, self._changeSceneCbObj, self._changeSceneCbParam)

	self._changeSceneCb = nil
	self._changeSceneCbObj = nil
	self._changeSceneCbParam = nil
end

function ArcadeSurvivorGameScene:adjustViewSize()
	local scale = 1
	local viewSizeX, viewSizeY = ArcadeSurvivorGameModel.instance:getViewSize()

	if viewSizeX > 0 and viewSizeY > 0 then
		local baseViewSizeX, baseViewSizeY = ArcadeSurvivorConfig.instance:getGameBaseViewSize()
		local scaleX = baseViewSizeX / viewSizeX
		local scaleY = baseViewSizeY / viewSizeY

		scale = math.min(scaleX, scaleY)
	end

	self._viewScale = scale

	transformhelper.setLocalScale(self._transContent, scale, scale, 1)
end

function ArcadeSurvivorGameScene:focusPlayer(isTween)
	if self._bossFocus then
		return
	end

	local posX = 0
	local posY = 0
	local baseGridSize = ArcadeSurvivorConfig.instance:getGameBaseGridSize()
	local halfBaseGridSize = baseGridSize * 0.5
	local mapSizeX, mapSizeY = ArcadeSurvivorGameModel.instance:getMapSize()
	local viewSizeX, viewSizeY = ArcadeSurvivorGameModel.instance:getViewSize()
	local maxOffsetX = (mapSizeX - viewSizeX) * halfBaseGridSize
	local maxOffsetY = (mapSizeY - viewSizeY) * halfBaseGridSize
	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()

	if maxOffsetX > 0 and maxOffsetY > 0 and characterMO then
		local playerGridX, playerGridY = characterMO:getGridPos()
		local playerPosX, playerPosY = ArcadeSurvivorGameHelper.grid2Position(playerGridX, playerGridY)

		posX = GameUtil.clamp(-playerPosX, -maxOffsetX, maxOffsetX)
		posY = GameUtil.clamp(-playerPosY, -maxOffsetY, maxOffsetY)
	end

	local viewScale = self._viewScale or 1
	local targetPosX = posX * viewScale
	local targetPosY = posY * viewScale

	if isTween then
		self:_doFocusTween(targetPosX, targetPosY)
	else
		self:_killFocusTween()
		transformhelper.setLocalPos(self._transContent, targetPosX, targetPosY, 0)
		ArcadeSurvivorGameController.instance:dispatchEvent(ArcadeSurvivorEvent.OnSceneFocusChange)
	end
end

function ArcadeSurvivorGameScene:_doFocusTween(targetPosX, targetPosY)
	self:_killFocusTween()

	local curPosX, curPosY, _ = transformhelper.getLocalPos(self._transContent)
	local eps = ArcadeSurvivorEnum.Const.PositionEPS
	local isPosXEqual = GameUtil.approximately(curPosX, targetPosX, eps)
	local isPosYEqual = GameUtil.approximately(curPosY, targetPosY, eps)

	if isPosXEqual and isPosYEqual then
		self:_onFocusTweenFinish()

		return
	end

	self._focusTweenId = ZProj.TweenHelper.DOLocalMove(self._transContent, targetPosX, targetPosY, 0, ArcadeSurvivorEnum.Const.HeroMoveSpeed, self._onFocusTweenFinish, self, nil, EaseType.OutExpo)
end

function ArcadeSurvivorGameScene:_onFocusTweenFinish()
	self._focusTweenId = nil

	ArcadeSurvivorGameController.instance:dispatchEvent(ArcadeSurvivorEvent.OnSceneFocusChange)
end

function ArcadeSurvivorGameScene:_killFocusTween()
	if self._focusTweenId then
		ZProj.TweenHelper.KillById(self._focusTweenId)
	end

	self._focusTweenId = nil
end

function ArcadeSurvivorGameScene:focusBoss(entity, cb, cbObj)
	self:_killFocusTween()

	local posX, posY = transformhelper.getLocalPos(self._transContent)
	local bossPos = self._transContent:InverseTransformPoint(entity:getCenterPosition())
	local scale = self:getViewScale()
	local targetScale = scale * ArcadeSurvivorGameEnum.Const.BossDeathFocusScale
	local mapSizeX, mapSizeY = ArcadeSurvivorGameModel.instance:getMapSize()
	local baseViewSizeX, baseViewSizeY = ArcadeSurvivorConfig.instance:getGameBaseViewSize()
	local halfBaseGridSize = ArcadeSurvivorConfig.instance:getGameBaseGridSize() * 0.5
	local maxOffsetX = math.max(0, (mapSizeX * targetScale - baseViewSizeX) * halfBaseGridSize)
	local maxOffsetY = math.max(0, (mapSizeY * targetScale - baseViewSizeY) * halfBaseGridSize)

	self._bossFocus = {
		posX = posX,
		posY = posY,
		scale = scale,
		targetPosX = GameUtil.clamp(-bossPos.x * targetScale, -maxOffsetX, maxOffsetX),
		targetPosY = GameUtil.clamp(-bossPos.y * targetScale, -maxOffsetY, maxOffsetY),
		cb = cb,
		cbObj = cbObj
	}

	ArcadeSurvivorGameController.instance:dispatchEvent(ArcadeSurvivorEvent.OnBossFocusStart)

	self._bossFocusTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, ArcadeSurvivorGameEnum.Const.BossDeathFocusTime, self._updateBossFocus, self._onBossFocusFinished, self, nil, EaseType.OutExpo)
end

function ArcadeSurvivorGameScene:_updateBossFocus(value)
	local focus = self._bossFocus
	local targetScale = focus.scale * ArcadeSurvivorGameEnum.Const.BossDeathFocusScale

	self._viewScale = focus.scale + (targetScale - focus.scale) * value

	local posX = focus.posX + (focus.targetPosX - focus.posX) * value
	local posY = focus.posY + (focus.targetPosY - focus.posY) * value

	transformhelper.setLocalScale(self._transContent, self._viewScale, self._viewScale, 1)
	transformhelper.setLocalPosXY(self._transContent, posX, posY)
	ArcadeSurvivorGameController.instance:dispatchEvent(ArcadeSurvivorEvent.OnSceneFocusChange)
end

function ArcadeSurvivorGameScene:_onBossFocusFinished()
	self._bossFocusTweenId = nil

	local focus = self._bossFocus
	local cb, cbObj = focus.cb, focus.cbObj

	focus.cb, focus.cbObj = nil

	GameUtil.handleCallbackFunc(cb, cbObj)
end

function ArcadeSurvivorGameScene:restoreBossFocus(cb, cbObj)
	self._bossFocus.cb, self._bossFocus.cbObj = cb, cbObj
	self._bossFocusTweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, ArcadeSurvivorGameEnum.Const.BossDeathFocusTime, self._updateBossFocus, self._onBossFocusRestored, self, nil, EaseType.OutExpo)
end

function ArcadeSurvivorGameScene:_onBossFocusRestored()
	self._bossFocusTweenId = nil

	local focus = self._bossFocus

	self:cancelBossFocus()
	GameUtil.handleCallbackFunc(focus.cb, focus.cbObj)
end

function ArcadeSurvivorGameScene:cancelBossFocus()
	if self._bossFocusTweenId then
		ZProj.TweenHelper.KillById(self._bossFocusTweenId)

		self._bossFocusTweenId = nil
	end

	if self._bossFocus then
		self:_updateBossFocus(0)

		self._bossFocus = nil
	end
end

function ArcadeSurvivorGameScene:playShakeEff()
	if self._sceneAnimator then
		self._sceneAnimator:Play("shake", 0, 0)
	end
end

function ArcadeSurvivorGameScene:onUpdate()
	if not self._compList then
		return
	end

	for _, comp in ipairs(self._compList) do
		local isInit = comp:isInitialized()

		if isInit and comp.onUpdate then
			comp:onUpdate()
		end
	end
end

function ArcadeSurvivorGameScene:getSceneGO()
	return self._goScene
end

function ArcadeSurvivorGameScene:onTransformPoint(x, y)
	local worldPos = self._transContent:TransformPoint(x, y, 0)

	return worldPos.x, worldPos.y, worldPos.z
end

function ArcadeSurvivorGameScene:getSceneOffsetY()
	return self._sceneOffsetY
end

function ArcadeSurvivorGameScene:getViewScale()
	return self._viewScale or 1
end

function ArcadeSurvivorGameScene:clear()
	self:cancelBossFocus()

	self._isRestart = nil

	self:_clearSceneLoadState()
	self:_disposePreGameStartFlow()
	self:_clearComps()
	self:_clearScene()
end

function ArcadeSurvivorGameScene:_clearSceneLoadState()
	self._loadingSceneResName = nil
	self._changeSceneCb = nil
	self._changeSceneCbObj = nil
	self._changeSceneCbParam = nil

	UIBlockMgr.instance:endBlock(ArcadeSurvivorEnum.BlockKey.LoadGameScene)
end

function ArcadeSurvivorGameScene:_disposePreGameStartFlow()
	if not self._preGameStartFlow then
		return
	end

	self._preGameStartFlow:unregisterDoneListener(self._initSceneFinish, self)
	self._preGameStartFlow:destroy()

	self._preGameStartFlow = nil
end

function ArcadeSurvivorGameScene:_clearComps()
	if self._compList then
		for _, comp in ipairs(self._compList) do
			comp:clear()
		end
	end

	self._compList = {}
end

function ArcadeSurvivorGameScene:_clearScene()
	self:_killFocusTween()
	self:_clearSceneRes()

	self._sceneAnimator = nil
	self._goRoot = nil

	if self._goScene then
		gohelper.destroy(self._goScene)
	end

	self._goScene = nil
end

function ArcadeSurvivorGameScene:_clearSceneRes()
	if self._goSceneRes then
		self.effectMgr:unregisterGrayscaleGO(self._goSceneRes)
		gohelper.destroy(self._goSceneRes)
	end

	self._goSceneRes = nil
	self._curSceneResName = nil
end

return ArcadeSurvivorGameScene
