module("modules.logic.versionactivity2_6.xugouji.view.XugoujiTaskView", package.seeall)

slot0 = class("XugoujiTaskView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._simagelangtxt = gohelper.findChildSingleImage(slot0.viewGO, "Left/#simage_langtxt")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_time")
	slot0._scrollTaskList = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_TaskList")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0._oneClaimReward, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0._onFinishTask, slot0)
	Activity188TaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity188
	}, slot0._oneClaimReward, slot0)
	TaskDispatcher.runRepeat(slot0._showLeftTime, slot0, 60)
	slot0:_showLeftTime()
end

function slot0._oneClaimReward(slot0)
	Activity188TaskListModel.instance:init(VersionActivity2_6Enum.ActivityId.Xugouji)
end

function slot0._onFinishTask(slot0, slot1)
	if Activity188TaskListModel.instance:getById(slot1) then
		Activity188TaskListModel.instance:init(VersionActivity2_6Enum.ActivityId.Xugouji)
	end
end

function slot0._showLeftTime(slot0)
	slot0._txtLimitTime.text = slot0:getLimitTimeStr()
end

function slot0.getLimitTimeStr()
	if not ActivityModel.instance:getActMO(VersionActivity2_6Enum.ActivityId.Xugouji) then
		return ""
	end

	if slot0:getRealEndTimeStamp() - ServerTime.now() > 0 then
		return TimeUtil.SecondToActivityTimeFormat(slot1)
	end

	return ""
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._showLeftTime, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageFullBG:UnLoadImage()
end

return slot0
