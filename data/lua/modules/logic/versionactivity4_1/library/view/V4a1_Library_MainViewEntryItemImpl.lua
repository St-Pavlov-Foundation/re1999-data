-- chunkname: @modules/logic/versionactivity4_1/library/view/V4a1_Library_MainViewEntryItemImpl.lua

module("modules.logic.versionactivity4_1.library.view.V4a1_Library_MainViewEntryItemImpl", package.seeall)

local V4a1_Library_MainViewEntryItemImpl = class("V4a1_Library_MainViewEntryItemImpl", V4a1_Library_MainViewEntryItemBase)

function V4a1_Library_MainViewEntryItemImpl:onInitView()
	self._btnimage = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_image")
	self._golock = gohelper.findChild(self.viewGO, "root/#go_lock")
	self._txttime = gohelper.findChildText(self.viewGO, "root/time/#txt_time")
	self._goreddot = gohelper.findChild(self.viewGO, "root/#go_reddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V4a1_Library_MainViewEntryItemImpl:addEvents()
	self._btnimage:AddClickListener(self._btnimageOnClick, self)
end

function V4a1_Library_MainViewEntryItemImpl:removeEvents()
	self._btnimage:RemoveClickListener()
end

function V4a1_Library_MainViewEntryItemImpl:ctor(...)
	V4a1_Library_MainViewEntryItemImpl.super.ctor(self, ...)
end

function V4a1_Library_MainViewEntryItemImpl:_btnimageOnClick()
	local p = self:parent()

	p:onClickItem(self)
end

function V4a1_Library_MainViewEntryItemImpl:_editableInitView()
	V4a1_Library_MainViewEntryItemImpl.super._editableInitView(self)

	self._txttime.text = ""
	self._timeGo = gohelper.findChild(self.viewGO, "root/time")
	self._timeIconGo = gohelper.findChild(self._txttime.gameObject, "icon")

	self:setActive_timeIcon(false)
end

function V4a1_Library_MainViewEntryItemImpl:setActive_timeIcon(bActive)
	gohelper.setActive(self._timeIconGo, bActive)
end

function V4a1_Library_MainViewEntryItemImpl:onDestroyView()
	V4a1_Library_MainViewEntryItemImpl.super.onDestroyView(self)
end

function V4a1_Library_MainViewEntryItemImpl:setData(mo)
	V4a1_Library_MainViewEntryItemImpl.super.setData(self, mo)

	local activityCo = self:getActivityCo()

	if activityCo then
		if activityCo.typeId == 101 then
			self:exec_addRedDotActId()
		else
			self:exec_addRedDot0()
		end
	end

	self:_refreshLockStatus()

	return self
end

function V4a1_Library_MainViewEntryItemImpl:_refreshLockStatus()
	local actStatus = self:getActivityStatus()
	local bShowLock = actStatus ~= ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(self._golock, bShowLock)
end

function V4a1_Library_MainViewEntryItemImpl:onTimerTick()
	self:_refreshTimer()
	self:setActive_timeIcon(self:getActivityStatus() < ActivityEnum.ActivityStatus.Expired)
end

function V4a1_Library_MainViewEntryItemImpl:_refreshTimer()
	self._txttime.text = self:getRemainTimeStr()
end

function V4a1_Library_MainViewEntryItemImpl:exec_addRedDot0(optUid)
	local activityCo = self:getActivityCo()

	if activityCo then
		local redDotUid = optUid or 0

		self._redDotIcon = RedDotController.instance:addRedDot(self._goreddot, activityCo.redDotId, redDotUid)
	end
end

function V4a1_Library_MainViewEntryItemImpl:exec_addRedDotActId()
	self:exec_addRedDot0(self:actId())
end

function V4a1_Library_MainViewEntryItemImpl:exec_addRedDotMulti(uidList)
	if isDebugBuild then
		assert(type(uidList) == "table", "invalid uidList")
	end

	local activityCo = self:getActivityCo()

	if activityCo then
		local redDotId = activityCo.redDotId
		local infoList = {}

		for _, uid in ipairs(uidList) do
			table.insert(infoList({
				id = redDotId,
				uid = uid
			}))
		end

		self._redDotIcon = RedDotController.instance:addMultiRedDot(self._goreddot, infoList)
	end
end

function V4a1_Library_MainViewEntryItemImpl:isShowRedDot()
	return self._redDotIcon and self._redDotIcon.show and true or false
end

return V4a1_Library_MainViewEntryItemImpl
