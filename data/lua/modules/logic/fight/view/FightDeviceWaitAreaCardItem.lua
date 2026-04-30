-- chunkname: @modules/logic/fight/view/FightDeviceWaitAreaCardItem.lua

module("modules.logic.fight.view.FightDeviceWaitAreaCardItem", package.seeall)

local FightDeviceWaitAreaCardItem = class("FightDeviceWaitAreaCardItem", FightDeviceCardItem)

function FightDeviceWaitAreaCardItem.Create(goParent)
	local deviceItem = FightDeviceWaitAreaCardItem.New()

	deviceItem:init(goParent, FightDeviceCardItem.CardType.WaitArea)

	return deviceItem
end

function FightDeviceWaitAreaCardItem:initViews()
	FightDeviceWaitAreaCardItem.super.initViews(self)

	self.lockComp = FightDevicePlayCardLockItem.New()

	self.lockComp:init(self)
end

function FightDeviceWaitAreaCardItem:refreshUI(index, deviceInfo)
	if not deviceInfo then
		return
	end

	self.index = index
	self.uid = deviceInfo.uid

	local groupInfo = deviceInfo.skills[deviceInfo.clientIndex]

	FightDeviceWaitAreaCardItem.super.refreshUI(self, groupInfo.skills[1])
	self:refreshAnchor()

	if self.lockComp then
		self.lockComp:updateLock()
	end
end

function FightDeviceWaitAreaCardItem:afterLoadDone()
	local deviceInfo = FightDataHelper.getClientDeviceInfo(self.uid)

	if not deviceInfo then
		return
	end

	self:refreshUI(self.index, deviceInfo)
	self:playAnim("open1")
end

function FightDeviceWaitAreaCardItem:getUid()
	return self.uid
end

function FightDeviceWaitAreaCardItem:updateData()
	local deviceInfo = FightDataHelper.getClientDeviceInfo(self.uid)

	if not deviceInfo then
		return
	end

	self:refreshUI(self.index, deviceInfo)
end

function FightDeviceWaitAreaCardItem:refreshAnchor()
	if not self.loadedDone then
		return
	end

	local anchor = FightDeviceHelper.getDeviceItemAnchorX(self.index)

	recthelper.setAnchorX(self.rectTr, anchor)
end

function FightDeviceWaitAreaCardItem:playScanEffect(success)
	if not self.loadedDone then
		return
	end

	if success then
		self:playAnim("success")
		AudioMgr.instance:trigger(370807)
	else
		self:playAnim("fail")
		AudioMgr.instance:trigger(370808)
	end
end

function FightDeviceWaitAreaCardItem:dispose()
	if self.lockComp then
		self.lockComp:dispose()

		self.lockComp = nil
	end

	FightDeviceWaitAreaCardItem.super.dispose(self)
end

return FightDeviceWaitAreaCardItem
