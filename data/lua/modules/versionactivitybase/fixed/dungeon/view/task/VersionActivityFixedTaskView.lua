module("modules.versionactivitybase.fixed.dungeon.view.task.VersionActivityFixedTaskView", package.seeall)

slot0 = class("VersionActivityFixedTaskView", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._txtremaintime = gohelper.findChildText(slot0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0.refreshRight, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0.refreshRight, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, slot0.refreshRight, slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	TaskDispatcher.runRepeat(slot0.refreshRemainTime, slot0, TimeUtil.OneMinuteSecond)
	VersionActivityFixedTaskListModel.instance:initTask()
	slot0:refreshLeft()
	slot0:refreshRight()
end

function slot0.refreshLeft(slot0)
	slot0:refreshRemainTime()
end

function slot0.refreshRemainTime(slot0)
	slot0._txtremaintime.text = TimeUtil.SecondToActivityTimeFormat(ActivityModel.instance:getActivityInfo()[VersionActivityFixedHelper.getVersionActivityEnum().ActivityId.Dungeon]:getRealEndTimeStamp() - ServerTime.now())
end

function slot0.refreshRight(slot0)
	VersionActivityFixedTaskListModel.instance:sortTaskMoList()
	VersionActivityFixedTaskListModel.instance:refreshList()
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
