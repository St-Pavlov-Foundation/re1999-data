-- chunkname: @modules/logic/gm/view/GMActivityStatusItem.lua

module("modules.logic.gm.view.GMActivityStatusItem", package.seeall)

local GMActivityStatusItem = class("GMActivityStatusItem", ListScrollCell)
local StatusNames = {
	[ActivityEnum.ActivityStatus.None] = "未找到活动",
	[ActivityEnum.ActivityStatus.Normal] = "正常",
	[ActivityEnum.ActivityStatus.NotOpen] = "未到开启时间",
	[ActivityEnum.ActivityStatus.Expired] = "活动已结束",
	[ActivityEnum.ActivityStatus.NotUnlock] = "未解锁",
	[ActivityEnum.ActivityStatus.NotOnLine] = "已下线"
}

local function _formatActivityTime(timestamp)
	local timeText = TimeUtil.langTimestampToString(timestamp)

	return string.sub(timeText, 1, 16)
end

function GMActivityStatusItem:init(go)
	self._txtId = gohelper.findChildText(go, "txtGuideId")
	self._txtName = gohelper.findChildText(go, "txtClientStep")
	self._txtStatus = gohelper.findChildText(go, "txtStatus")
	self._btnRestart = gohelper.findChildButtonWithAudio(go, "btnRestart")
	self._btnFinish = gohelper.findChildButtonWithAudio(go, "btnFinish")
	self._btnDel = gohelper.findChildButtonWithAudio(go, "btnDel")

	self._btnRestart:AddClickListener(self._onClickRefresh, self)
	self._btnFinish:AddClickListener(self._onClickCopyId, self)
	self._btnDel:AddClickListener(self._onClickCopyName, self)

	gohelper.findChildText(self._btnRestart.gameObject, "Text").text = "刷新"
end

function GMActivityStatusItem:onUpdateMO(mo)
	self._activityId = mo.id
	self._activityConfig = mo.config or ActivityConfig.instance:getActivityCo(mo.id)

	local actCo = self._activityConfig
	local name = actCo and (actCo.name or actCo.nameEn) or "未知活动"
	local actInfo = ActivityModel.instance:getActMO(mo.id)
	local startTime = actInfo and _formatActivityTime(actInfo:getRealStartTimeStamp()) or "--"
	local endTime = actInfo and _formatActivityTime(actInfo:getRealEndTimeStamp()) or "--"
	local status = ActivityHelper.getActivityStatus(mo.id, true)

	self._txtId.text = tostring(mo.id)
	self._txtName.text = string.format("%s\n开始：%s\n结束：%s", name, startTime, endTime)
	self._txtStatus.text = StatusNames[status] or tostring(status)

	gohelper.setActive(self._btnRestart.gameObject, GMActivityStatusModel.instance.showOpBtn)
	gohelper.setActive(self._btnFinish.gameObject, GMActivityStatusModel.instance.showOpBtn)
	gohelper.setActive(self._btnDel.gameObject, GMActivityStatusModel.instance.showOpBtn)
end

function GMActivityStatusItem:_onClickRefresh()
	GMActivityStatusModel.instance:reInit()
	GMActivityStatusModel.instance:updateModel()
end

function GMActivityStatusItem:_onClickCopyId()
	if not self._activityId then
		return
	end

	ZProj.UGUIHelper.CopyText(tostring(self._activityId))
	GameFacade.showToast(ToastEnum.IconId, "已复制活动ID")
end

function GMActivityStatusItem:_onClickCopyName()
	local actCo = self._activityConfig or self._activityId and ActivityConfig.instance:getActivityCo(self._activityId)

	if not actCo then
		return
	end

	ZProj.UGUIHelper.CopyText(actCo.name or actCo.nameEn or "")
	GameFacade.showToast(ToastEnum.IconId, "已复制活动名称")
end

function GMActivityStatusItem:onDestroy()
	self._btnRestart:RemoveClickListener()
	self._btnFinish:RemoveClickListener()
	self._btnDel:RemoveClickListener()
end

return GMActivityStatusItem
