module("modules.logic.versionactivity2_7.coopergarland.view.CooperGarlandTaskView", package.seeall)

slot0 = class("CooperGarlandTaskView", BaseView)

function slot0.onInitView(slot0)
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_time")
	slot0._scrollTaskList = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_TaskList")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0._oneClaimReward, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0._onFinishTask, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0._oneClaimReward, slot0)
	slot0:removeEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0._onFinishTask, slot0)
end

function slot0._oneClaimReward(slot0)
	CooperGarlandTaskListModel.instance:init()
end

function slot0._onFinishTask(slot0, slot1)
	if CooperGarlandTaskListModel.instance:getById(slot1) then
		CooperGarlandTaskListModel.instance:init()
	end
end

function slot0._editableInitView(slot0)
	slot0.actId = CooperGarlandModel.instance:getAct192Id()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:showLeftTime()
	TaskDispatcher.runRepeat(slot0.showLeftTime, slot0, TimeUtil.OneMinuteSecond)
end

function slot0.showLeftTime(slot0)
	slot0._txttime.text = ActivityHelper.getActivityRemainTimeStr(slot0.actId)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.showLeftTime, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
