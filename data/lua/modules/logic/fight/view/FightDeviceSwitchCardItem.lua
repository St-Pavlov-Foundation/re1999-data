-- chunkname: @modules/logic/fight/view/FightDeviceSwitchCardItem.lua

module("modules.logic.fight.view.FightDeviceSwitchCardItem", package.seeall)

local FightDeviceSwitchCardItem = class("FightDeviceSwitchCardItem", FightDeviceCardItem)

function FightDeviceSwitchCardItem.Create(goParent)
	local deviceItem = FightDeviceSwitchCardItem.New()

	deviceItem:init(goParent, FightDeviceCardItem.CardType.SwitchCard)

	return deviceItem
end

function FightDeviceSwitchCardItem:initViews()
	FightDeviceSwitchCardItem.super.initViews(self)

	self.longPress = SLFramework.UGUI.UILongPressListener.Get(self.go)

	self.longPress:SetLongPressTime({
		0.5,
		99999
	})
	self.longPress:AddLongPressListener(self.onLongPress, self)

	self.click = gohelper.getClick(self.go)

	self.click:AddClickListener(self.onClickDeviceCard, self)
end

function FightDeviceSwitchCardItem:onLongPress()
	self.longPressed = true

	FightController.instance:dispatchEvent(FightEvent.OnDevice_LongPressSwitchCardItem, self)
end

function FightDeviceSwitchCardItem:onClickDeviceCard()
	if self.longPressed then
		self.longPressed = nil

		return
	end

	if not self:checkCanSwitch() then
		GameFacade.showToast(374002)

		return
	end

	local deviceArea = FightDataHelper.getDeviceArea()

	if not deviceArea then
		return
	end

	AudioMgr.instance:trigger(20001001)
	deviceArea:changeClientIndex(self.uid, self.index)
end

function FightDeviceSwitchCardItem:checkCanSwitch()
	local entityMo = FightDataHelper.entityMgr:getById(self.uid)

	if not entityMo then
		return
	end

	if self.isBigSkill then
		local needPoint = entityMo:getUniqueSkillPoint()
		local curExPoint = entityMo.exPoint

		if curExPoint < needPoint then
			return
		end
	end

	return true
end

function FightDeviceSwitchCardItem:refreshUI(uid, index, deviceSkillInfo)
	self.uid = uid
	self.index = index
	self.deviceSkillInfo = deviceSkillInfo

	FightDeviceSwitchCardItem.super.refreshUI(self, deviceSkillInfo)
	self:setSelectFrameActive(self.selectFrameActive)
	self:setGrayMaskActive(not self:checkCanSwitch())
end

function FightDeviceSwitchCardItem:afterLoadDone()
	self:refreshUI(self.uid, self.index, self.deviceSkillInfo)

	self.parentTr = self.rectTr.parent

	self:playAnim("open2")
end

function FightDeviceSwitchCardItem:refreshSelectFrameActive(curSelectIndex)
	self.selectFrameActive = curSelectIndex == self.index

	if not self.loadedDone then
		return
	end

	self:setSelectFrameActive(self.selectFrameActive)
end

function FightDeviceSwitchCardItem:getUid()
	return self.uid
end

function FightDeviceSwitchCardItem:dispose()
	if self.click then
		self.click:RemoveClickListener()

		self.click = nil
	end

	if self.longPress then
		self.longPress:RemoveLongPressListener()

		self.longPress = nil
	end

	FightDeviceSwitchCardItem.super.dispose(self)
end

return FightDeviceSwitchCardItem
