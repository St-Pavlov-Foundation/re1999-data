-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/entity/ArcadeSurvivorGameBaseEntity.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.entity.ArcadeSurvivorGameBaseEntity", package.seeall)

local ArcadeSurvivorGameBaseEntity = class("ArcadeSurvivorGameBaseEntity", LuaCompBase)

function ArcadeSurvivorGameBaseEntity:ctor(param)
	self._entityType = param.entityType
	self._id = param.id
	self._uid = param.uid
	self._prefabItemDict = {}
	self._curPrefabName = nil

	self:onCtor(param)
end

function ArcadeSurvivorGameBaseEntity:init(go)
	self.go = go
	self.trans = self.go.transform
	self._goPrefabNode = gohelper.create3d(self.go, ArcadeSurvivorGameEnum.Const.EntityPrefabNode)

	self:_initComponents()
	self:refreshPosition()
	self:_initStateShow()
end

function ArcadeSurvivorGameBaseEntity:_initStateShow()
	local mo = self:getMO()
	local delayTime = mo and mo.delayTimeShow

	if delayTime and delayTime > 0 then
		gohelper.setActive(self.go, false)
		TaskDispatcher.runDelay(self._onDelayShow, self, delayTime)
	else
		self:playStateShow()
	end
end

function ArcadeSurvivorGameBaseEntity:_onDelayShow()
	gohelper.setActive(self.go, true)
	self:refreshBoardState()
	self:playStateShow()
end

function ArcadeSurvivorGameBaseEntity:change2Prefab(targetPrefabName)
	if string.nilorempty(targetPrefabName) or self._curPrefabName == targetPrefabName then
		return
	end

	self._curPrefabName = targetPrefabName

	local targetPrefabItem = self._prefabItemDict[targetPrefabName]

	if targetPrefabItem then
		self:_refreshPrefab()
	else
		local scene = ArcadeSurvivorGameController.instance:getGameScene()
		local resPath = ResUrl.getArcadeSurvivorScenePrefabRes(ArcadeSurvivorEnum.ResDir.EntityPrefab, targetPrefabName)

		scene.loader:loadRes(resPath, self._onLoadPrefabFinish, self, targetPrefabName)
	end
end

function ArcadeSurvivorGameBaseEntity:_onLoadPrefabFinish(targetPrefabName)
	if string.nilorempty(targetPrefabName) or self._prefabItemDict[targetPrefabName] then
		return
	end

	local scene = ArcadeSurvivorGameController.instance:getGameScene()
	local resPath = ResUrl.getArcadeSurvivorScenePrefabRes(ArcadeSurvivorEnum.ResDir.EntityPrefab, targetPrefabName)
	local resObj = scene.loader:getResource(resPath)

	self:change2PrefabWithResObj(targetPrefabName, resObj)
end

function ArcadeSurvivorGameBaseEntity:change2PrefabWithResObj(prefabName, resObj)
	local targetPrefabItem = self:_addPrefabItem(prefabName, resObj)

	if not targetPrefabItem then
		return
	end

	self._curPrefabName = prefabName

	self:_refreshPrefab()
end

function ArcadeSurvivorGameBaseEntity:_addPrefabItem(prefabName, resObj)
	if string.nilorempty(prefabName) or not resObj then
		return
	end

	local targetPrefabItem = self._prefabItemDict[prefabName]

	if targetPrefabItem then
		return targetPrefabItem
	end

	local goPrefabNode = self:getPrefabNode()

	if gohelper.isNil(goPrefabNode) then
		return
	end

	local goPrefab = gohelper.clone(resObj, goPrefabNode, prefabName)

	if gohelper.isNil(goPrefab) then
		return
	end

	local prefabItem = self:getUserDataTb_()

	prefabItem.go = goPrefab
	prefabItem.animator = goPrefab:GetComponent(gohelper.Type_Animator)
	prefabItem.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(goPrefab)

	local goScale = gohelper.findChild(goPrefab, "ani/scale")

	if goScale then
		prefabItem.goScale = goScale
		prefabItem.transScale = goScale.transform
	end

	self._prefabItemDict[prefabName] = prefabItem

	local scene = ArcadeSurvivorGameController.instance:getGameScene()
	local entityType = self:getEntityType()

	if scene and entityType ~= ArcadeSurvivorEnum.EntityType.Character and entityType ~= ArcadeSurvivorEnum.EntityType.Ally then
		scene.effectMgr:registerGrayscaleGO(goPrefab)
	end

	self:_setPrefabItemTrans(prefabItem)

	return prefabItem
end

function ArcadeSurvivorGameBaseEntity:_setPrefabItemTrans(prefabItem)
	if not prefabItem then
		return
	end

	local mo = self:getMO()

	if not mo then
		return
	end

	local transScale = prefabItem.transScale
	local scaleX, scaleY = mo:getScale()

	if scaleX and scaleY then
		transformhelper.setLocalScale(transScale, scaleX, scaleY, 1)
	end

	local posX, posY = mo:getPosOffset()

	if posX and posY then
		transformhelper.setLocalPosXY(transScale, posX, posY)
	end
end

function ArcadeSurvivorGameBaseEntity:refreshDirection()
	local mo = self:getMO()

	if not mo then
		return
	end

	local prefabItem = self:getCurPrefabItem()

	if not prefabItem then
		return
	end

	local transScale = prefabItem.transScale
	local entityDirection = mo:getDirection(true)

	transformhelper.setLocalRotation(transScale, 0, entityDirection == ArcadeSurvivorEnum.Direction.Right and 180 or 0, 0)
end

function ArcadeSurvivorGameBaseEntity:_initComponents()
	self:_clearComps()
	self:_addComp("effectComp", ArcadeSurvivorEntityEffectComp, true)

	local mo = self:getMO()
	local haveHpBar = mo and mo:getIsHaveHPBar()

	if haveHpBar then
		self:_addComp("hpComp", ArcadeSurvivorGameHPComp, true)
	end

	local treeId = mo and mo:getTreeId()

	if treeId and treeId > 0 then
		self:_addComp("btComp", ArcadeSurvivorEntityBTComp)
	end
end

function ArcadeSurvivorGameBaseEntity:_clearComps()
	if self._compList then
		for _, comp in ipairs(self._compList) do
			comp:clear()
		end
	end

	self._compList = {}
end

function ArcadeSurvivorGameBaseEntity:_addComp(compName, compClass, needContentGO)
	local go = self.go

	if needContentGO then
		go = gohelper.create3d(self.go, compName)
	end

	local compInst = MonoHelper.addNoUpdateLuaComOnceToGo(go, compClass, {
		entity = self,
		compName = compName
	})

	self[compName] = compInst

	table.insert(self._compList, compInst)
end

function ArcadeSurvivorGameBaseEntity:btTick()
	if not self.btComp then
		return
	end

	return self.btComp:tick()
end

function ArcadeSurvivorGameBaseEntity:_refreshPrefab()
	if not self._prefabItemDict then
		return
	end

	for prefabName, prefabItem in pairs(self._prefabItemDict) do
		gohelper.setActive(prefabItem.go, prefabName == self._curPrefabName)
	end

	self:playStateShow()
	self:refreshBoardState()
end

function ArcadeSurvivorGameBaseEntity:refreshBoardState()
	local mo = self:getMO()

	if not mo then
		return
	end

	local onBoard = not mo:getIsOffBoard()

	if not onBoard then
		self:_killMoveTween()
	end

	gohelper.setActive(self._goPrefabNode, onBoard)

	if self.effectComp then
		gohelper.setActive(self.effectComp.go, onBoard)
	end

	if self.hpComp then
		gohelper.setActive(self.hpComp.go, onBoard)
	end
end

function ArcadeSurvivorGameBaseEntity:refreshPosition(isTween, cb, cbObj, cbParam, moveEffectShowId)
	local mo = self:getMO()

	if not mo then
		return
	end

	local gridX, gridY = mo:getGridPos()

	if not gridX or not gridY then
		return
	end

	self:_killMoveTween()

	if isTween then
		self:_doMoveTween(cb, cbObj, cbParam, moveEffectShowId)
	else
		local x, y = ArcadeSurvivorGameHelper.grid2Position(gridX, gridY)

		transformhelper.setLocalPos(self.trans, x, y, 0)
		self:refreshShowHpBar()
	end

	self:_onRefreshPosition(isTween)
end

function ArcadeSurvivorGameBaseEntity:refreshShowHpBar()
	if self.hpComp then
		self.hpComp:refreshShow()
	end
end

function ArcadeSurvivorGameBaseEntity:_doMoveTween(finishCb, finishCbObj, finishCbParam, moveEffectShowId)
	local mo = self:getMO()

	if mo:getIsRespawning() then
		return
	end

	local gridX, gridY = mo:getGridPos()
	local targetPosX, targetPosY = ArcadeSurvivorGameHelper.grid2Position(gridX, gridY)
	local curPosX, curPosY, curPosZ = self:getPosition(true)
	local eps = ArcadeSurvivorEnum.Const.PositionEPS
	local isPosXEqual = GameUtil.approximately(curPosX, targetPosX, eps)
	local isPosYEqual = GameUtil.approximately(curPosY, targetPosY, eps)

	if isPosXEqual and isPosYEqual then
		GameUtil.handleCallbackFunc(finishCb, finishCbObj, finishCbParam)

		return
	end

	self:playActionShow(ArcadeSurvivorEnum.ActionShowId.Move)
	self:_killMoveTween()

	self._finishMoveCb = finishCb
	self._finishMoveCbObj = finishCbObj
	self._finishMoveCbParam = finishCbParam
	self._moveTweenId = ZProj.TweenHelper.DOLocalMove(self.trans, targetPosX, targetPosY, curPosZ, ArcadeSurvivorEnum.Const.HeroMoveSpeed, self._onMoveTweenFinish, self, nil, EaseType.OutExpo)

	if moveEffectShowId then
		local scene = ArcadeSurvivorGameController.instance:getGameScene()
		local effectMgr = scene and scene.effectMgr

		if effectMgr then
			effectMgr:startMoveAfterimage(self, moveEffectShowId)
		end
	end

	ArcadeSurvivorGameController.instance:dispatchEvent(ArcadeSurvivorEvent.OnEntityTweenMove, mo:getEntityType(), mo:getUid(), true)
end

function ArcadeSurvivorGameBaseEntity:_onMoveTweenFinish()
	self:refreshPosition()

	self._moveTweenId = nil

	GameUtil.handleCallbackFunc(self._finishMoveCb, self._finishMoveCbObj, self._finishMoveCbParam)

	self._finishMoveCb = nil
	self._finishMoveCbObj = nil
	self._finishMoveCbParam = nil

	ArcadeSurvivorGameController.instance:dispatchEvent(ArcadeSurvivorEvent.OnEntityTweenMove, self:getEntityType(), self:getUid(), false)
end

function ArcadeSurvivorGameBaseEntity:_killMoveTween()
	local scene = ArcadeSurvivorGameController.instance:getGameScene()
	local effectMgr = scene and scene.effectMgr

	if effectMgr then
		effectMgr:stopMoveAfterimage(self)
	end

	if self._moveTweenId then
		ZProj.TweenHelper.KillById(self._moveTweenId)
	end

	self._finishMoveCb = nil
	self._finishMoveCbObj = nil
	self._finishMoveCbParam = nil
	self._moveTweenId = nil
end

function ArcadeSurvivorGameBaseEntity:isTweenMoving()
	return self._moveTweenId
end

local DEFAULT_IDLE_ANIMA_NAME = "idle_loop"

function ArcadeSurvivorGameBaseEntity:playStateShow()
	if self._isPlayingBossDeath or self._isPlayingDeath then
		return
	end

	local mo = self:getMO()

	if not mo then
		return
	end

	if mo:getIsRespawning() then
		return
	end

	local stateAnimName
	local showIdList = mo:getStateShowIdList()

	for _, showId in ipairs(showIdList) do
		if showId and showId ~= 0 then
			if not self.effectComp:isStateShowPlaying(showId) then
				self.effectComp:playShow(showId, nil, true)
			end

			local anim = ArcadeSurvivorConfig.instance:getShowAnim(showId)
			local hasAnim = not string.nilorempty(anim)

			if hasAnim then
				stateAnimName = anim
			end
		end
	end

	local prefabItem = self:getCurPrefabItem()
	local animatorPlayer = prefabItem and prefabItem.animatorPlayer

	if animatorPlayer then
		if string.nilorempty(stateAnimName) then
			stateAnimName = DEFAULT_IDLE_ANIMA_NAME
		end

		if self._playingStateAnimName ~= stateAnimName then
			animatorPlayer:Play(stateAnimName)

			self._playingStateAnimName = stateAnimName
		end
	end

	self:refreshDirection()
end

function ArcadeSurvivorGameBaseEntity:stopStateLoopEffect(showId)
	if not showId or showId == 0 then
		return
	end

	if self.effectComp then
		self.effectComp:removeShow(showId, true)
	end

	self:playStateShow()
end

function ArcadeSurvivorGameBaseEntity:playActionShow(actionShowId, direction, showParam, cb, cbObj, cbParam)
	local mo = self:getMO()

	if not mo then
		return
	end

	local isRemoving = mo:getIsRemoving()
	local isRespawning = mo:getIsRespawning()
	local isRespawnAction = actionShowId == ArcadeSurvivorEnum.ActionShowId.Respawn

	if isRemoving or isRespawning and not isRespawnAction then
		return
	end

	self._actionIsRespawn = isRespawnAction

	if isRespawnAction then
		self:_killMoveTween()
	end

	local showIdList, bulletShowIdList = ArcadeSurvivorGameHelper.getActionShowIdList(actionShowId, showParam)

	self._actionShowIdList = showIdList and tabletool.copy(showIdList)

	if bulletShowIdList and #bulletShowIdList > 0 and self.effectComp then
		self.effectComp:playBulletShow(bulletShowIdList)
	end

	self._actionDirection = direction
	self._actionShowFinishCb = cb
	self._actionShowFinishCbObj = cbObj
	self._actionShowFinishCbParam = cbParam

	self:_playNextActionShow()
	self:refreshDirection()
end

function ArcadeSurvivorGameBaseEntity:_playNextActionShow()
	if not self._actionShowIdList or #self._actionShowIdList <= 0 then
		if self._actionIsRespawn then
			self:_removeRespawnShow()
		end

		GameUtil.handleCallbackFunc(self._actionShowFinishCb, self._actionShowFinishCbObj, self._actionShowFinishCbParam)
		self:_clearActionEffList()
		self:playStateShow()
	else
		local showId = table.remove(self._actionShowIdList, 1)

		self:playShow(showId, self._actionDirection, self._playNextActionShow, self, nil, self._actionIsRespawn)
	end
end

function ArcadeSurvivorGameBaseEntity:playShow(showId, animDir, animCb, animCbObj, animCbParam, isRespawnShow)
	if self._isPlayingDeath or self._isPlayingBossDeath then
		return
	end

	local mo = self:getMO()

	if mo and mo:getIsRespawning() and not isRespawnShow then
		return
	end

	local resName = ArcadeSurvivorConfig.instance:getShowResName(showId)
	local hasResName = not string.nilorempty(resName)

	if hasResName then
		if self.effectComp then
			self.effectComp:playShow(showId, animDir, false)
		end
	else
		local audioId = ArcadeSurvivorConfig.instance:getShowAudio(showId)

		if audioId and audioId > 0 then
			AudioMgr.instance:trigger(audioId)
		end
	end

	local prefabItem = self:getCurPrefabItem()
	local animatorPlayer = prefabItem and prefabItem.animatorPlayer
	local animName = ArcadeSurvivorConfig.instance:getShowAnim(showId, animDir)
	local hasAnim = animatorPlayer and not string.nilorempty(animName)
	local finishParam = {
		cb = animCb,
		cbObj = animCbObj,
		cbParam = animCbParam
	}

	if hasAnim then
		self._playingStateAnimName = nil

		animatorPlayer:Play(animName, self._playShowFinish, self, finishParam)
	else
		self:_playShowFinish(finishParam)
	end
end

function ArcadeSurvivorGameBaseEntity:_playShowFinish(param)
	self:playStateShow()

	if not param then
		return
	end

	GameUtil.handleCallbackFunc(param.cb, param.cbObj, param.cbParam)
end

function ArcadeSurvivorGameBaseEntity:_clearActionEffList()
	self._actionIsRespawn = nil
	self._actionDirection = nil
	self._actionShowFinishCb = nil
	self._actionShowFinishCbObj = nil
	self._actionShowFinishCbParam = nil
	self._actionShowIdList = nil
end

function ArcadeSurvivorGameBaseEntity:removeAllShow()
	if self.effectComp then
		self.effectComp:removeAllShow()
	end
end

function ArcadeSurvivorGameBaseEntity:removeActionShow()
	if self.effectComp then
		self.effectComp:removeActionShow()
	end
end

function ArcadeSurvivorGameBaseEntity:playDeath(cb, cbObj, cbParam)
	self._isPlayingDeath = true
	self._deathCb, self._deathCbObj, self._deathCbParam = cb, cbObj, cbParam

	self:_killMoveTween()
	self:_clearActionEffList()
	self:removeAllShow()

	local showId = ArcadeSurvivorConfig.instance:getStateShowShowId(ArcadeSurvivorEnum.StateShowId.Dead)

	self.effectComp:playShow(showId, nil, true)

	local prefabItem = self:getCurPrefabItem()

	if prefabItem then
		local animName = ArcadeSurvivorConfig.instance:getShowAnim(showId)

		prefabItem.animatorPlayer:Play(animName, self._onDeathFinished, self)
	else
		self:_onDeathFinished()
	end
end

function ArcadeSurvivorGameBaseEntity:_onDeathFinished()
	local cb, cbObj, cbParam = self._deathCb, self._deathCbObj, self._deathCbParam

	self._deathCb, self._deathCbObj, self._deathCbParam = nil

	GameUtil.handleCallbackFunc(cb, cbObj, cbParam)
end

function ArcadeSurvivorGameBaseEntity:prepareBossDeath(cb, cbObj)
	self._isPlayingBossDeath = true
	self._bossDeathCb, self._bossDeathCbObj = cb, cbObj

	self:_killMoveTween()
	self:_clearActionEffList()
	self:removeAllShow()

	local prefabItem = self:getCurPrefabItem()

	if not prefabItem then
		return
	end

	prefabItem.animatorPlayer:Stop()

	prefabItem.animator.speed = 0

	local showId = ArcadeSurvivorGameEnum.Const.BossDeathShowId
	local resName = ArcadeSurvivorConfig.instance:getShowResName(showId)
	local resPath = ResUrl.getArcadeSurvivorEffectRes(resName)
	local scene = ArcadeSurvivorGameController.instance:getGameScene()

	if not scene then
		return
	end

	scene.loader:loadRes(resPath, self._onBossDeathLoaded, self, {
		resName = resName,
		resPath = resPath
	})
end

function ArcadeSurvivorGameBaseEntity:_onBossDeathLoaded(param)
	if not self._isPlayingBossDeath then
		return
	end

	local scene = ArcadeSurvivorGameController.instance:getGameScene()

	if not scene then
		return
	end

	local res = scene.loader:getResource(param.resPath)

	if not res then
		return
	end

	local prefabItem = self:getCurPrefabItem()

	if not prefabItem then
		return
	end

	self._bossDeathEffect = gohelper.clone(res, prefabItem.go, param.resName)

	gohelper.setActive(self._bossDeathEffect, false)
	prefabItem.animator:Rebind()

	prefabItem.animator.speed = 0

	self:_setPrefabItemTrans(prefabItem)
	self:refreshDirection()
	self.effectComp:refreshEffectPosition(ArcadeSurvivorGameEnum.Const.BossDeathShowId, self._bossDeathEffect)

	local cb, cbObj = self._bossDeathCb, self._bossDeathCbObj

	self._bossDeathCb, self._bossDeathCbObj = nil

	GameUtil.handleCallbackFunc(cb, cbObj)
end

function ArcadeSurvivorGameBaseEntity:playBossDeath(cb, cbObj)
	self._bossDeathCb, self._bossDeathCbObj = cb, cbObj

	local showId = ArcadeSurvivorGameEnum.Const.BossDeathShowId
	local audioId = ArcadeSurvivorConfig.instance:getShowAudio(showId)

	if audioId and audioId > 0 then
		AudioMgr.instance:trigger(audioId)
	end

	local prefabItem = self:getCurPrefabItem()
	local animName = ArcadeSurvivorConfig.instance:getShowAnim(showId)

	prefabItem.animator.speed = 1

	prefabItem.animatorPlayer:Play(animName, self._onBossDeathAnimationFinished, self)
end

function ArcadeSurvivorGameBaseEntity:_onBossDeathAnimationFinished()
	gohelper.setActive(self._bossDeathEffect, false)

	local cb, cbObj = self._bossDeathCb, self._bossDeathCbObj

	self._bossDeathCb, self._bossDeathCbObj = nil

	GameUtil.handleCallbackFunc(cb, cbObj)
end

function ArcadeSurvivorGameBaseEntity:cancelBossDeath()
	if not self._isPlayingBossDeath then
		return
	end

	self._isPlayingBossDeath = nil
	self._bossDeathCb, self._bossDeathCbObj = nil

	local prefabItem = self:getCurPrefabItem()

	if not gohelper.isNil(prefabItem.animator) then
		prefabItem.animatorPlayer:Stop()

		prefabItem.animator.speed = 1
	end

	gohelper.destroy(self._bossDeathEffect)

	self._bossDeathEffect = nil
end

function ArcadeSurvivorGameBaseEntity:getEntityType()
	return self._entityType
end

function ArcadeSurvivorGameBaseEntity:getUid()
	return self._uid
end

function ArcadeSurvivorGameBaseEntity:getId()
	return self._id
end

function ArcadeSurvivorGameBaseEntity:getMO(nilError)
	local entityType = self:getEntityType()
	local uid = self:getUid()
	local mo = ArcadeSurvivorGameModel.instance:getEntityMO(entityType, uid, nilError)

	return mo
end

function ArcadeSurvivorGameBaseEntity:getPrefabNode()
	return self._goPrefabNode
end

function ArcadeSurvivorGameBaseEntity:getIsHasPrefab(prefabName)
	return self._prefabItemDict[prefabName] ~= nil
end

function ArcadeSurvivorGameBaseEntity:getCurPrefabItem()
	if not self._curPrefabName then
		return
	end

	return self._prefabItemDict[self._curPrefabName]
end

function ArcadeSurvivorGameBaseEntity:getPosition(isLocal)
	local posX, posY, posZ = 0, 0, 0

	if isLocal then
		posX, posY, posZ = transformhelper.getLocalPos(self.trans)
	else
		posX, posY, posZ = transformhelper.getPos(self.trans)
	end

	return posX, posY, posZ
end

function ArcadeSurvivorGameBaseEntity:getCenterPosition()
	local mo = self:getMO()

	if mo then
		local sizeX, sizeY = mo:getSize()
		local halfGridSize = ArcadeSurvivorConfig.instance:getGameBaseGridSize() * 0.5

		return self.trans:TransformPoint((sizeX - 1) * halfGridSize, (sizeY - 1) * halfGridSize, 0)
	else
		return self:getPosition()
	end
end

function ArcadeSurvivorGameBaseEntity:onCtor(param)
	return
end

function ArcadeSurvivorGameBaseEntity:_onRefreshPosition(isTween)
	return
end

function ArcadeSurvivorGameBaseEntity:destroy()
	ArcadeSurvivorGameController.instance:onRespawnEntityDestroy(self)
	self:cancelRespawn()

	self._deathCb, self._deathCbObj, self._deathCbParam = nil

	if self._isPlayingDeath then
		local prefabItem = self:getCurPrefabItem()

		if prefabItem then
			prefabItem.animatorPlayer:Stop()
		end
	end

	self:_clearActionEffList()
	self:_clearComps()
	self:_killMoveTween()
	gohelper.destroy(self.go)
end

function ArcadeSurvivorGameBaseEntity:onDestroy()
	ArcadeSurvivorGameController.instance:onRespawnEntityDestroy(self)
	self:cancelRespawn()

	self._deathCb, self._deathCbObj, self._deathCbParam = nil

	self:cancelBossDeath()

	local scene = ArcadeSurvivorGameController.instance:getGameScene()

	if scene then
		scene.effectMgr:onEntityDestroy(self)

		for _, item in pairs(self._prefabItemDict) do
			scene.effectMgr:unregisterGrayscaleGO(item.go)
		end
	end

	self:_clearActionEffList()
	self:_clearComps()
	self:_killMoveTween()
	TaskDispatcher.cancelTask(self._onDelayShow, self)

	self._finishMoveCb = nil
	self._finishMoveCbObj = nil
	self._finishMoveCbParam = nil
end

function ArcadeSurvivorGameBaseEntity:cancelRespawn()
	if not self._actionIsRespawn then
		return
	end

	local prefabItem = self:getCurPrefabItem()

	if prefabItem then
		prefabItem.animatorPlayer:Stop()
	end

	self:_removeRespawnShow()
	self:_clearActionEffList()
end

function ArcadeSurvivorGameBaseEntity:_removeRespawnShow()
	local showIds = ArcadeSurvivorGameHelper.getActionShowIdList(ArcadeSurvivorEnum.ActionShowId.Respawn)

	if self.effectComp then
		for _, showId in ipairs(showIds) do
			self.effectComp:removeShow(showId, false)
		end
	end
end

return ArcadeSurvivorGameBaseEntity
