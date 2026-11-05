-- chunkname: @modules/logic/fight/entity/comp/FightPSTMuOuNameUI.lua

module("modules.logic.fight.entity.comp.FightPSTMuOuNameUI", package.seeall)

local FightPSTMuOuNameUI = class("FightPSTMuOuNameUI", UserDataDispose)
local prefabPath = "ui/viewres/fight/fightpeishitacharge.prefab"

function FightPSTMuOuNameUI:init(entityMo)
	self:__onInit()

	self.entityMo = entityMo
	self.entityId = entityMo.uid
	self.entity = FightHelper.getEntity(self.entityId)
	self.buffActId = FightEnum.BuffActId.GuardianPuppet
	self.lockBuffTypeId = 31590008
	self.loader = MultiAbLoader.New()

	self.loader:addPath(prefabPath)
	self.loader:startLoad(self.onLoadDone, self)
end

function FightPSTMuOuNameUI:onLoadDone()
	local assetItem = self.loader:getFirstAssetItem()
	local prefab = assetItem and assetItem:GetResource()

	if not prefab then
		return
	end

	self.containerGo = gohelper.create2d(FightNameMgr.instance:getNameParent(), "muou")
	self.go = gohelper.clone(prefab, self.containerGo)
	self.goNormal = gohelper.findChild(self.go, "normal")
	self.normalProgress = gohelper.findChildImage(self.goNormal, "#image_progress")
	self.goLock = gohelper.findChild(self.go, "lock")
	self.lockProgress = gohelper.findChildImage(self.goLock, "#image_progress")
	self.rectLine = gohelper.findChildComponent(self.goLock, "#image_progress/line", gohelper.Type_RectTransform)

	gohelper.setActive(self.rectLine.gameObject, false)
	self:initUiFollower()

	self.initDone = true
	self.entityNameUiActive = self.entity and self.entity.nameUI and self.entity.nameUI:getActive()

	self:refreshUI()
	self:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, self.onBuffUpdate, self)
	self:addEventCb(FightController.instance, FightEvent.UpdateBuffActInfo, self.onUpdateBuffActInfo, self)
	self:addEventCb(FightController.instance, FightEvent.OnNameUIActiveChange, self.onNameUIActiveChange, self)
	self:addEventCb(FightController.instance, FightEvent.OnMuOuEntityVisibleChange, self.onMuOuEntityVisibleChange, self)
end

function FightPSTMuOuNameUI:onMuOuEntityVisibleChange()
	self:refreshUI()
end

function FightPSTMuOuNameUI:onNameUIActiveChange(entityId, active)
	if self.entityId ~= entityId then
		return
	end

	self.entityNameUiActive = active

	self:refreshUI()
end

function FightPSTMuOuNameUI:onBuffUpdate(entityId, effectType, buffId, buffUid, configEffect, buffMo)
	if self.entityId ~= entityId then
		return
	end

	local buffCo = lua_skill_buff.configDict[buffId]

	if not buffCo then
		return
	end

	if buffCo.typeId == self.lockBuffTypeId then
		self:refreshLock()
	end

	if buffMo and buffMo.actInfo then
		for _, buffActInfo in ipairs(buffMo.actInfo) do
			if buffActInfo.actId == self.buffActId then
				self:refreshHP()

				return
			end
		end
	end
end

function FightPSTMuOuNameUI:onUpdateBuffActInfo(entityId, buffUid, buffActInfo)
	if self.entityId ~= entityId then
		return
	end

	if buffActInfo.actId ~= self.buffActId then
		return
	end

	self:refreshHP()
end

function FightPSTMuOuNameUI:initUiFollower()
	self.uiFollower = gohelper.onceAddComponent(self.containerGo, typeof(ZProj.UIFollower))

	self.uiFollower:SetCameraShake(CameraMgr.instance:getCameraShake())
	CameraMgr.instance:getCameraTrace():AddChangeActor(self.uiFollower)
	self:setUiFollowerParam()
end

FightPSTMuOuNameUI.OffsetX = 0
FightPSTMuOuNameUI.OffsetY = 15

function FightPSTMuOuNameUI:setUiFollowerParam()
	if not self.specialEntity then
		return
	end

	if not self.uiFollower then
		return
	end

	local unitCamera = CameraMgr.instance:getUnitCamera()
	local uiCamera = CameraMgr.instance:getUICamera()
	local plane = ViewMgr.instance:getUIRoot().transform
	local hangPointGO = self.specialEntity:getHangPoint(ModuleEnum.SpineHangPoint.mounttop, true)

	self.uiFollower:Set(unitCamera, uiCamera, plane, hangPointGO.transform, 0, 0, 0, FightPSTMuOuNameUI.OffsetX, FightPSTMuOuNameUI.OffsetY)
end

function FightPSTMuOuNameUI:setSpecialEntity(specialEntity)
	self.specialEntity = specialEntity

	self:setUiFollowerParam()
end

function FightPSTMuOuNameUI:setActive(active)
	self.active = active

	self:refreshUI()
end

local LineMinAnchorX = -50
local LineMaxAnchorX = 50

function FightPSTMuOuNameUI:refreshUI()
	if not self.initDone then
		return
	end

	if not self.specialEntity then
		self:_hide()

		return
	end

	local active = self.active and self.entityNameUiActive and self.entity and self.entity:checkIsVisible() and self.specialEntity:checkIsVisible()

	if not active then
		self:_hide()

		return
	end

	self:_show()
	self:refreshHP()
	self:refreshLock()
end

function FightPSTMuOuNameUI:_hide()
	gohelper.setActive(self.containerGo, false)
	self.uiFollower:SetEnable(false)
end

function FightPSTMuOuNameUI:_show()
	gohelper.setActive(self.containerGo, true)
	self.uiFollower:SetEnable(true)
end

local Duration = 0.5

function FightPSTMuOuNameUI:refreshHP()
	local curHp, maxHp = self:getCurHpAndMaxHp()
	local rate = curHp / maxHp

	ZProj.TweenHelper.KillByObj(self.normalProgress)
	ZProj.TweenHelper.KillByObj(self.lockProgress)
	ZProj.TweenHelper.DOFillAmount(self.normalProgress, rate, Duration)
	ZProj.TweenHelper.DOFillAmount(self.lockProgress, rate, Duration)
end

function FightPSTMuOuNameUI:refreshLock()
	local hasLock = self:checkIsLock()

	gohelper.setActive(self.goLock, hasLock)
	gohelper.setActive(self.goNormal, not hasLock)
end

function FightPSTMuOuNameUI:getCurHpAndMaxHp()
	local buffDict = self.entityMo:getBuffDic()

	for _, buffMo in pairs(buffDict) do
		for _, buffActInfo in ipairs(buffMo.actInfo) do
			if buffActInfo.actId == self.buffActId then
				return buffActInfo.param[1], buffActInfo.param[2]
			end
		end
	end

	return 0, 1
end

function FightPSTMuOuNameUI:checkIsLock()
	local buffDict = self.entityMo:getBuffDic()

	for _, buffMo in pairs(buffDict) do
		local co = buffMo:getCO()

		if co and co.typeId == self.lockBuffTypeId then
			return true
		end
	end
end

function FightPSTMuOuNameUI:destroy()
	if self.initDone then
		ZProj.TweenHelper.KillByObj(self.normalProgress)
		ZProj.TweenHelper.KillByObj(self.lockProgress)
		gohelper.destroy(self.containerGo)
	end

	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end

	self:__onDispose()
end

return FightPSTMuOuNameUI
