-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/entity/comp/ArcadeSurvivorEntityEffectComp.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.entity.comp.ArcadeSurvivorEntityEffectComp", package.seeall)

local ArcadeSurvivorEntityEffectComp = class("ArcadeSurvivorEntityEffectComp", LuaCompBase)

function ArcadeSurvivorEntityEffectComp:ctor(param)
	self._entity = param.entity
	self._compName = param.compName
end

function ArcadeSurvivorEntityEffectComp:init(go)
	self.go = go
	self.trans = go.transform
	self._effectGODict = {}
	self._playingShowDict = {}
	self._playingStateEffectDict = {}
	self._initialized = true
end

function ArcadeSurvivorEntityEffectComp:playBulletShow(showId)
	local scene = ArcadeSurvivorGameController.instance:getGameScene()
	local resName = ArcadeSurvivorConfig.instance:getShowResName(showId)
	local hasResName = not string.nilorempty(resName)

	if not scene or not hasResName then
		return
	end

	local mo = self._entity:getMO()

	if not mo then
		return
	end

	local startX, startY = mo:getGridPos()
	local direction = mo:getDirection()

	scene.effectMgr:playBulletShow(showId, startX, startY, direction)
end

function ArcadeSurvivorEntityEffectComp:playShow(showId, direction, isState)
	local scene = ArcadeSurvivorGameController.instance:getGameScene()
	local resName = ArcadeSurvivorConfig.instance:getShowResName(showId)
	local hasResName = not string.nilorempty(resName)
	local willPlaySceneEffect = scene and hasResName

	ArcadeSurvivorGameController.instance:dispatchEvent(ArcadeSurvivorEvent.PlayUIEffect, showId, not willPlaySceneEffect)

	if not willPlaySceneEffect then
		return
	end

	local isPlayOnGrid = ArcadeSurvivorConfig.instance:getShowIsPlayOnGrid(showId)

	if isPlayOnGrid then
		local mo = self._entity:getMO()

		if not mo then
			return
		end

		local gridX, gridY = mo:getGridPos()
		local gridDirection = direction or self:_getEntityDirection()
		local isNearestGrid = ArcadeSurvivorConfig.instance:getShowIsNearestGrid(showId)

		if isNearestGrid then
			gridX, gridY = ArcadeSurvivorGameHelper.getEntityNearCharacterGrid(mo)
		end

		scene.effectMgr:playGridShow(showId, gridX, gridY, gridDirection)

		return
	end

	local playingShowDict = isState and self._playingStateEffectDict or self._playingShowDict
	local effectGO = self._effectGODict[showId]

	playingShowDict[showId] = true

	if gohelper.isNil(effectGO) then
		self:_loadEffect(showId, resName, direction, isState)
	else
		gohelper.setActive(effectGO, false)
		self:_refreshEffectTransform(showId, effectGO, direction)
		gohelper.setActive(effectGO, true)
		self:_playShowAudioId(showId)
	end
end

function ArcadeSurvivorEntityEffectComp:_loadEffect(showId, resName, direction, isState)
	local scene = ArcadeSurvivorGameController.instance:getGameScene()

	if not scene then
		return
	end

	local resPath = ResUrl.getArcadeSurvivorEffectRes(resName)

	scene.loader:loadRes(resPath, self.onLoadEffectFinished, self, {
		showId = showId,
		direction = direction,
		isState = isState
	})
end

function ArcadeSurvivorEntityEffectComp:onLoadEffectFinished(param)
	if not self._initialized then
		return
	end

	local scene = ArcadeSurvivorGameController.instance:getGameScene()

	if not scene then
		return
	end

	local showId = param.showId
	local playingShowDict = param.isState and self._playingStateEffectDict or self._playingShowDict

	if not playingShowDict[showId] then
		return
	end

	local resName = ArcadeSurvivorConfig.instance:getShowResName(showId)
	local resPath = ResUrl.getArcadeSurvivorEffectRes(resName)
	local assetRes = scene.loader:getResource(resPath)

	if not assetRes then
		return
	end

	local effectGO = gohelper.clone(assetRes, self.go)

	scene.effectMgr:registerGrayscaleGO(effectGO)

	self._effectGODict[showId] = effectGO

	self:_refreshEffectTransform(showId, effectGO, param.direction)
	self:_playShowAudioId(showId)
end

function ArcadeSurvivorEntityEffectComp:_playShowAudioId(showId)
	local audioId = ArcadeSurvivorConfig.instance:getShowAudio(showId)

	if audioId and audioId > 0 then
		AudioMgr.instance:trigger(audioId)
	end
end

function ArcadeSurvivorEntityEffectComp:_refreshEffectTransform(showId, effectGO, direction)
	self:refreshEffectPosition(showId, effectGO)

	local scale = ArcadeSurvivorConfig.instance:getShowScale(showId)

	if scale and scale ~= 1 then
		transformhelper.setLocalScale(effectGO.transform, scale, scale, 1)
	end

	direction = direction or self:_getEntityDirection()

	local transform = effectGO and effectGO.transform

	ArcadeSurvivorGameHelper.setShowRotationByType(showId, transform, direction)
end

function ArcadeSurvivorEntityEffectComp:refreshEffectPosition(showId, effectGO)
	local effectTrans = effectGO.transform
	local center = effectTrans.parent:InverseTransformPoint(self._entity:getCenterPosition())
	local offsetX, offsetY = ArcadeSurvivorConfig.instance:getShowOffset(showId)

	transformhelper.setLocalPos(effectTrans, center.x + offsetX, center.y + offsetY, center.z)
end

function ArcadeSurvivorEntityEffectComp:_getEntityDirection()
	local mo = self._entity and self._entity:getMO()

	if not mo then
		return ArcadeSurvivorGameEnum.Const.DefaultDirection
	end

	return mo:getDirection()
end

function ArcadeSurvivorEntityEffectComp:isStateShowPlaying(showId)
	return self._playingStateEffectDict[showId] == true
end

function ArcadeSurvivorEntityEffectComp:removeShow(showId, isState)
	if not showId then
		return
	end

	local playingShowDict = isState and self._playingStateEffectDict or self._playingShowDict

	playingShowDict[showId] = nil

	local resName = ArcadeSurvivorConfig.instance:getShowResName(showId)
	local hasResName = not string.nilorempty(resName)

	if not hasResName then
		return
	end

	local effectGO = self._effectGODict[showId]
	local hasEffectGO = not gohelper.isNil(effectGO)

	if hasEffectGO then
		gohelper.setActive(effectGO, false)
	end
end

function ArcadeSurvivorEntityEffectComp:removeAllShow()
	self._playingShowDict = {}
	self._playingStateEffectDict = {}

	for _, effectGO in pairs(self._effectGODict) do
		gohelper.setActive(effectGO, false)
	end
end

function ArcadeSurvivorEntityEffectComp:removeActionShow()
	for showId in pairs(self._playingShowDict) do
		local effectGO = self._effectGODict[showId]

		if not gohelper.isNil(effectGO) then
			gohelper.setActive(effectGO, false)
		end
	end

	self._playingShowDict = {}
end

function ArcadeSurvivorEntityEffectComp:clear()
	if not self._initialized then
		return
	end

	self._initialized = false

	local scene = ArcadeSurvivorGameController.instance:getGameScene()

	if scene then
		for _, effectGO in pairs(self._effectGODict) do
			scene.effectMgr:unregisterGrayscaleGO(effectGO)
		end
	end

	self._entity = nil
	self._compName = nil
	self._effectGODict = {}
end

function ArcadeSurvivorEntityEffectComp:onDestroy()
	self:clear()
end

return ArcadeSurvivorEntityEffectComp
