﻿-- chunkname: @modules/logic/versionactivity1_5/dungeon/view/map/VersionActivity1_5DungeonMapElement.lua

module("modules.logic.versionactivity1_5.dungeon.view.map.VersionActivity1_5DungeonMapElement", package.seeall)

local VersionActivity1_5DungeonMapElement = class("VersionActivity1_5DungeonMapElement", LuaCompBase)

function VersionActivity1_5DungeonMapElement:ctor(param)
	self._config = param[1]
	self._extendConfig = lua_activity11502_episode_element.configDict[self._config.id]
	self._sceneElements = param[2]
end

function VersionActivity1_5DungeonMapElement:getElementId()
	return self._config.id
end

function VersionActivity1_5DungeonMapElement:hide()
	gohelper.setActive(self._go, false)
end

function VersionActivity1_5DungeonMapElement:show()
	gohelper.setActive(self._go, true)
end

function VersionActivity1_5DungeonMapElement:init(go)
	self._go = go
	self._transform = go.transform

	self:updatePos()

	if self._resLoader then
		return
	end

	self._resLoader = MultiAbLoader.New()
	self._resPath = self._config.res
	self._effectPath = self._config.effect

	if not string.nilorempty(self._resPath) then
		self._resLoader:addPath(self._resPath)
	end

	if not string.nilorempty(self._effectPath) then
		self._resLoader:addPath(self._effectPath)
	end

	if self._extendConfig and not string.nilorempty(self._extendConfig.finishEffect) then
		self._finishEffectPath = self._extendConfig.finishEffect

		self._resLoader:addPath(self._finishEffectPath)
	end

	self._resLoader:startLoad(self._onResLoaded, self)
end

function VersionActivity1_5DungeonMapElement:_onResLoaded()
	self:createMainPrefab()

	if self:isDispatch() then
		self:createDispatchPrefab()
	else
		self:createEffectPrefab()
	end

	self:refreshDispatchRemainTime()
	self:autoPopInteractView()
	self:tryHideSelf()
end

function VersionActivity1_5DungeonMapElement:createMainPrefab()
	if string.nilorempty(self._resPath) then
		return
	end

	local assetItem = self._resLoader:getAssetItem(self._resPath)
	local mainPrefab = assetItem:GetResource(self._resPath)

	self._itemGo = gohelper.clone(mainPrefab, self._go)
	self.posTransform = self._itemGo.transform

	local resScale = self._config.resScale

	if resScale and resScale ~= 0 then
		transformhelper.setLocalScale(self.posTransform, resScale, resScale, 1)
	end

	gohelper.setLayer(self._itemGo, UnityLayer.Scene, true)
	self.addBoxColliderListener(self._itemGo, self._onClickDown, self)
	transformhelper.setLocalPos(self.posTransform, 0, 0, -1)
end

function VersionActivity1_5DungeonMapElement:createEffectPrefab(effectPath, offset)
	if string.nilorempty(effectPath) then
		effectPath = self._effectPath
		offset = self._config.tipOffsetPos

		if string.nilorempty(effectPath) then
			return
		end
	end

	local offsetPos = string.splitToNumber(offset, "#")

	self._offsetX = offsetPos[1] or 0
	self._offsetY = offsetPos[2] or 0

	local assetItem = self._resLoader:getAssetItem(effectPath)
	local effectPrefab = assetItem:GetResource(effectPath)

	self._effectGo = gohelper.clone(effectPrefab, self._go)
	self.posTransform = self._effectGo.transform

	transformhelper.setLocalPos(self._effectGo.transform, self._offsetX, self._offsetY, -3)
	self.addBoxColliderListener(self._effectGo, self._onClickDown, self)

	if VersionActivity1_5DungeonModel.instance:checkIsShowInteractView() then
		self:hideElement()
	end
end

function VersionActivity1_5DungeonMapElement:createDispatchPrefab()
	local dispatchId = tonumber(self._config.param)
	local dispatchMo = VersionActivity1_5DungeonModel.instance:getDispatchMo(dispatchId)
	local isFinish = dispatchMo and dispatchMo:isFinish()

	if isFinish and self._extendConfig then
		self:createEffectPrefab(self._extendConfig.finishEffect, self._extendConfig.finishEffectOffsetPos)
	else
		self:createEffectPrefab()
	end
end

function VersionActivity1_5DungeonMapElement:isDispatch()
	return self._config.type == DungeonEnum.ElementType.EnterDispatch
end

function VersionActivity1_5DungeonMapElement:refreshDispatchRemainTime()
	if not self:isDispatch() then
		return
	end

	self._sceneElements:addTimeItem(self)
end

function VersionActivity1_5DungeonMapElement:onDispatchFinish()
	if self.destroyed then
		return
	end

	if self._extendConfig.finishEffect == self._config.effect then
		logWarn("finish effect equal effect, elementId : " .. tostring(self._config.id))
		VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnDispatchFinish)

		return
	end

	gohelper.destroy(self._effectGo)

	self.posTransform = self._itemGo and self._itemGo.transform or nil
	self._effectAnimator = nil

	self:createDispatchPrefab()
	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnDispatchFinish)
end

function VersionActivity1_5DungeonMapElement:updatePos()
	local pos = string.splitToNumber(self._config.pos, "#")

	transformhelper.setLocalPos(self._transform, pos[1] or 0, pos[2] or 0, pos[3] or 0)
end

function VersionActivity1_5DungeonMapElement:getTransform()
	return self._transform
end

function VersionActivity1_5DungeonMapElement:getElementPos()
	if not self.posTransform then
		logError("not pos transform")

		return
	end

	return transformhelper.getPos(self.posTransform)
end

function VersionActivity1_5DungeonMapElement:getConfig()
	return self._config
end

function VersionActivity1_5DungeonMapElement:_onClickDown()
	self._sceneElements:setMouseElementDown(self)
end

function VersionActivity1_5DungeonMapElement:onClick()
	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnClickElement, self)
end

function VersionActivity1_5DungeonMapElement:showElement()
	self:playEffectAnim("wenhao_a_001_in")
end

function VersionActivity1_5DungeonMapElement:hideElement()
	self:playEffectAnim("wenhao_a_001_out")
end

function VersionActivity1_5DungeonMapElement:playEffectAnim(name)
	self._wenhaoAnimName = name

	if gohelper.isNil(self._effectGo) then
		return
	end

	if not self._effectGo.activeInHierarchy then
		return
	end

	if gohelper.isNil(self._effectAnimator) then
		self._effectAnimator = SLFramework.AnimatorPlayer.Get(self._effectGo)
	end

	if not gohelper.isNil(self._effectAnimator) then
		self._effectAnimator:Play(name, self._effectAnimDone, self)
	end
end

function VersionActivity1_5DungeonMapElement:_effectAnimDone()
	logNormal("effect anim done")
end

function VersionActivity1_5DungeonMapElement.addBoxColliderListener(go, callback, callbackTarget)
	gohelper.addBoxCollider2D(go, Vector2(1.5, 1.5))

	local clickListener = ZProj.BoxColliderClickListener.Get(go)

	clickListener:SetIgnoreUI(true)
	clickListener:AddClickListener(callback, callbackTarget)
end

function VersionActivity1_5DungeonMapElement:isValid()
	return not gohelper.isNil(self._go)
end

function VersionActivity1_5DungeonMapElement:setFinish()
	if not self._effectGo then
		gohelper.destroy(self._itemGo)

		self._itemGo = nil

		return
	end

	self:playEffectAnim("finish")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_elementdisappear)
	TaskDispatcher.runDelay(self.onFinishAnimDone, self, 1.6)
end

function VersionActivity1_5DungeonMapElement:onFinishAnimDone()
	self:onDestroy()
end

function VersionActivity1_5DungeonMapElement:autoPopInteractView()
	if not DungeonMapModel.instance.lastElementBattleId then
		return
	end

	if tonumber(self._config.param) == DungeonMapModel.instance.lastElementBattleId then
		self:onClick()

		DungeonMapModel.instance.lastElementBattleId = nil
	end
end

function VersionActivity1_5DungeonMapElement:tryHideSelf()
	if VersionActivity1_5DungeonModel.instance:checkIsShowInteractView() then
		self:hideElement()
	end
end

function VersionActivity1_5DungeonMapElement:onDestroy()
	gohelper.setActive(self._go, true)

	if self._effectGo then
		gohelper.destroy(self._effectGo)

		self._effectGo = nil
	end

	if self._itemGo then
		gohelper.destroy(self._itemGo)

		self._itemGo = nil
	end

	if self._go then
		gohelper.destroy(self._go)

		self._go = nil
	end

	if self._resLoader then
		self._resLoader:dispose()

		self._resLoader = nil
	end

	self.destroyed = true
end

return VersionActivity1_5DungeonMapElement
