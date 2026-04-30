-- chunkname: @modules/logic/fight/view/expoint/FightExPointDevicePowerView.lua

module("modules.logic.fight.view.expoint.FightExPointDevicePowerView", package.seeall)

local FightExPointDevicePowerView = class("FightExPointDevicePowerView", FightBaseView)

function FightExPointDevicePowerView:onConstructor(entityMo)
	self.entityMo = entityMo
	self.entityId = entityMo.id
	self.clientAddDevicePower = 0

	self:com_registMsg(FightMsgId.GetExPointView, self.onGetExPointView)
end

function FightExPointDevicePowerView:onInitView()
	recthelper.setAnchorX(self.viewGO.transform, 30)

	local rootTr = gohelper.findChildComponent(self.viewGO, "root", gohelper.Type_RectTransform)

	recthelper.setAnchorY(rootTr, 0)

	self.imageEnergy = gohelper.findChildImage(self.viewGO, "root/go_energy")
end

function FightExPointDevicePowerView:addEvents()
	return
end

function FightExPointDevicePowerView:removeEvents()
	return
end

function FightExPointDevicePowerView:onGetExPointView(entityId)
	if entityId == self.entityId then
		self:com_replyMsg(FightMsgId.GetExPointView, self)
	end
end

function FightExPointDevicePowerView:onOpen()
	self:addEventCb(FightController.instance, FightEvent.OnExpointMaxAdd, self.refreshDevicePower, self)
	self:addEventCb(FightController.instance, FightEvent.OnExPointChange, self.refreshDevicePower, self)
	self:addEventCb(FightController.instance, FightEvent.OnPlayHandCard, self.onPlayHandCard, self)
	self:addEventCb(FightController.instance, FightEvent.OnResetCard, self.onResetCard, self)
	self:addEventCb(FightController.instance, FightEvent.StageChanged, self.onStageChange, self)
	self:refreshDevicePower()
end

function FightExPointDevicePowerView:onExPointMaxAdd(entityId)
	if entityId ~= self.entityId then
		return
	end

	self:refreshDevicePower()
end

function FightExPointDevicePowerView:onStageChange()
	self.clientAddDevicePower = 0

	self:refreshDevicePower()
end

function FightExPointDevicePowerView:onResetCard()
	self.clientAddDevicePower = 0

	self:refreshDevicePower()
end

function FightExPointDevicePowerView:onPlayHandCard(cardMo)
	local curStage = FightDataHelper.stageMgr:getCurStage()

	if curStage ~= FightStageMgr.StageType.Operate then
		return
	end

	if cardMo.uid ~= self.entityId then
		return
	end

	self.clientAddDevicePower = FightDeviceHelper.getSkillIdAddDeviceExPoint(cardMo.skillId)

	self:refreshDevicePower()
end

function FightExPointDevicePowerView:getCurDevicePower()
	return self.entityMo:getExPoint()
end

function FightExPointDevicePowerView:refreshDevicePower()
	local max = self.entityMo:getMaxExPoint()
	local curPower = self:getCurDevicePower()

	curPower = curPower + self.clientAddDevicePower

	local rate = curPower / max

	rate = Mathf.Clamp01(rate)

	self:clearTween()

	self.tweenId = ZProj.TweenHelper.DOFillAmount(self.imageEnergy, rate, 0.3)
end

function FightExPointDevicePowerView:clearTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end
end

function FightExPointDevicePowerView:onClose()
	self:clearTween()
end

function FightExPointDevicePowerView:onDestroyView()
	return
end

return FightExPointDevicePowerView
