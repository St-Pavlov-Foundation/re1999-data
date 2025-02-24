module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroTaskView", package.seeall)

slot0 = class("DiceHeroTaskView", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	slot0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0._oneClaimReward, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0._onFinishTask, slot0)
	DiceHeroTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.DiceHero
	}, slot0._oneClaimReward, slot0)
end

function slot0._oneClaimReward(slot0)
	DiceHeroTaskListModel.instance:init()
end

function slot0._onFinishTask(slot0, slot1)
	if DiceHeroTaskListModel.instance:getById(slot1) then
		DiceHeroTaskListModel.instance:init()
	end
end

return slot0
