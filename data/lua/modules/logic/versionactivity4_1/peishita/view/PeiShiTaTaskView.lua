-- chunkname: @modules/logic/versionactivity4_1/peishita/view/PeiShiTaTaskView.lua

module("modules.logic.versionactivity4_1.peishita.view.PeiShiTaTaskView", package.seeall)

local PeiShiTaTaskView = class("PeiShiTaTaskView", BaseView)

function PeiShiTaTaskView:onInitView()
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PeiShiTaTaskView:addEvents()
	self:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
end

function PeiShiTaTaskView:removeEvents()
	self:removeEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self:removeEventCb(TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
end

function PeiShiTaTaskView:_oneClaimReward()
	Activity220TaskListModel.instance:init(self._actId)
end

function PeiShiTaTaskView:_onFinishTask(taskId)
	if Activity220TaskListModel.instance:getById(taskId) then
		Activity220TaskListModel.instance:init(self._actId)
	end
end

function PeiShiTaTaskView:_editableInitView()
	return
end

function PeiShiTaTaskView:onUpdateParam()
	return
end

function PeiShiTaTaskView:onOpen()
	self._actId = PeiShiTaController.instance:getActId()

	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	Activity220TaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity220
	}, self._oneClaimReward, self)
	self:showLeftTime()
	TaskDispatcher.cancelTask(self.showLeftTime, self)
	TaskDispatcher.runRepeat(self.showLeftTime, self, TimeUtil.OneMinuteSecond)
end

function PeiShiTaTaskView:showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)
end

function PeiShiTaTaskView:onClose()
	TaskDispatcher.cancelTask(self.showLeftTime, self)
end

return PeiShiTaTaskView
