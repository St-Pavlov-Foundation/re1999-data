-- chunkname: @modules/logic/assist/view/AssistRoleBadgeItem.lua

module("modules.logic.assist.view.AssistRoleBadgeItem", package.seeall)

local AssistRoleBadgeItem = class("AssistRoleBadgeItem", LuaCompBase)

function AssistRoleBadgeItem:init(go)
	self.go = go
	self.simageBadge = gohelper.findChildSingleImage(go, "simage_Badge")
	self.txtName = gohelper.findChildText(go, "txt_Name")
	self.txtTarget = gohelper.findChildText(go, "txt_Target")
	self.goWear = gohelper.findChild(go, "go_Wear")
	self.goLock = gohelper.findChild(go, "go_Lock")
	self.goNew = gohelper.findChild(go, "go_New")
	self.btnClick = gohelper.findChildButtonWithAudio(go, "btn_Click")
	self.isUnlock = false
end

function AssistRoleBadgeItem:addEventListeners()
	self:addClickCb(self.btnClick, self.onClick, self)
	self:addEventCb(AssistController.instance, AssistEvent.UpdateWearBadges, self.refreshWearStatus, self)
end

function AssistRoleBadgeItem:onClick()
	if self.wearIndex then
		RoleBadgeRpc.instance:sendRoleBadgeWearRequest(self.heroUid, self.wearIndex, 0)
	elseif self.wearCount < AssistEnum.MaxWearCount and self.isUnlock then
		local emptyPos = self.recordMo:getFirstEmptyWearPos()

		RoleBadgeRpc.instance:sendRoleBadgeWearRequest(self.heroUid, emptyPos, self.config.id)
	end
end

function AssistRoleBadgeItem:setData(heroUid, groupId)
	self.heroUid = heroUid

	local roleBadgeInfoMo = RoleBadgeModel.instance:getBadgeInfo()

	self.recordMo = roleBadgeInfoMo and roleBadgeInfoMo:getRecordMo(self.heroUid)
	self.config = self.recordMo and self.recordMo:getActiveBadgeCfg(groupId)
	self.isUnlock = self.config ~= nil

	if not self.config then
		self.config = RoleBadgeConfig.instance:getBadgeCoByLevel(groupId, 1)
	end

	gohelper.setActive(self.goLock, not self.isUnlock)

	self.txtName.text = self.config.badgeTitle
	self.txtTarget.text = self.config.desc

	self.simageBadge:LoadImage(ResUrl.getRoleBadgeSingleBg(self.config.icon))
	self:refreshWearStatus(heroUid)
end

function AssistRoleBadgeItem:refreshWearStatus(heroUid)
	if self.heroUid ~= heroUid then
		return
	end

	self.wearIndex = self.recordMo and self.recordMo:getWearPos(self.config.id)
	self.wearCount = self.recordMo and self.recordMo:getWearCnt() or 0

	gohelper.setActive(self.goWear, self.wearIndex)
end

return AssistRoleBadgeItem
