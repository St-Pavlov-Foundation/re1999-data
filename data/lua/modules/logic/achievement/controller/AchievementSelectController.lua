module("modules.logic.achievement.controller.AchievementSelectController", package.seeall)

slot0 = class("AchievementSelectController", BaseController)

function slot0.onOpenView(slot0, slot1)
	AchievementSelectListModel.instance:initDatas(slot1)
	PlayerController.instance:registerCallback(PlayerEvent.ChangePlayerinfo, slot0.handlePlayerInfoChanged, slot0)
	AchievementController.instance:registerCallback(AchievementEvent.UpdateAchievements, slot0.handleAchievementUpdated, slot0)
end

function slot0.onCloseView(slot0)
	PlayerController.instance:unregisterCallback(PlayerEvent.ChangePlayerinfo, slot0.handlePlayerInfoChanged, slot0)
	AchievementController.instance:unregisterCallback(AchievementEvent.UpdateAchievements, slot0.handleAchievementUpdated, slot0)
	AchievementSelectListModel.instance:release()
end

function slot0.setCategory(slot0, slot1)
	AchievementSelectListModel.instance:setTab(slot1)
	slot0:notifyUpdateView()
end

function slot0.switchGroup(slot0)
	if AchievementSelectListModel.instance:checkDirty(AchievementSelectListModel.instance.isGroup) then
		GameFacade.showMessageBox(MessageBoxIdDefine.AchievementSaveCheck, MsgBoxEnum.BoxType.Yes_No, slot0.switchGroupWithoutCheck, nil, , slot0, nil)
	else
		slot0:switchGroupWithoutCheck()
	end
end

function slot0.switchGroupAfterSave(slot0)
	slot0:sendSave(slot0.switchGroupWithoutCheck, slot0)
end

function slot0.switchGroupWithoutCheck(slot0)
	AchievementSelectListModel.instance:resumeToOriginSelect()

	if not AchievementSelectListModel.instance.isGroup then
		AchievementSelectListModel.instance:setTab(AchievementEnum.Type.Activity)
	end

	AchievementSelectListModel.instance:setIsSelectGroup(not slot1)
	slot0:notifyUpdateView()
end

function slot0.resumeToOriginSelect(slot0)
	AchievementSelectListModel.instance:resumeToOriginSelect()
	slot0:notifyUpdateView()
end

function slot0.clearAllSelect(slot0)
	AchievementSelectListModel.instance:clearAllSelect()
	slot0:notifyUpdateView()
end

function slot0.changeGroupSelect(slot0, slot1)
	slot2 = AchievementSelectListModel.instance:isGroupSelected(slot1)
	slot3 = AchievementSelectListModel.instance:getGroupSelectedCount()

	if AchievementEnum.ShowMaxGroupCount <= 1 then
		AchievementSelectListModel.instance:clearAllSelect()
	elseif not slot2 and AchievementEnum.ShowMaxGroupCount <= slot3 then
		GameFacade.showToast(ToastEnum.AchievementShowMaxGroupCount, AchievementEnum.ShowMaxGroupCount)

		return
	end

	AchievementSelectListModel.instance:setGroupSelect(slot1, not slot2)
	slot0:notifyUpdateView()
end

function slot0.changeSingleSelect(slot0, slot1)
	if not AchievementSelectListModel.instance:isSingleSelected(slot1) and AchievementEnum.ShowMaxSingleCount <= AchievementSelectListModel.instance:getSingleSelectedCount() then
		GameFacade.showToast(ToastEnum.AchievementShowMaxSingleCount, AchievementEnum.ShowMaxSingleCount)

		return
	end

	AchievementSelectListModel.instance:setSingleSelect(slot1, not slot2)
	slot0:notifyUpdateView()
end

function slot0.handlePlayerInfoChanged(slot0)
	AchievementSelectListModel.instance:decodeShowAchievement()
	slot0:notifyUpdateView()
end

function slot0.handleAchievementUpdated(slot0)
	AchievementSelectListModel.instance:refreshTabData()
	slot0:notifyUpdateView()
end

function slot0.checkSave(slot0, slot1, slot2, slot3)
	GameFacade.showMessageBox(MessageBoxIdDefine.AchievementSaveCheck, MsgBoxEnum.BoxType.Yes_No, slot0.switchGroupAfterSave, slot2, nil, slot0, slot3)
end

function slot0.sendSave(slot0, slot1, slot2)
	slot3, slot4 = AchievementSelectListModel.instance:getSaveRequestParam()

	AchievementRpc.instance:sendShowAchievementRequest(slot3, slot4, slot1, slot2)
end

function slot0.notifyUpdateView(slot0)
	slot0:dispatchEvent(AchievementEvent.SelectViewUpdated)
	AchievementSelectListModel.instance:onModelUpdate()
end

function slot0.popUpMessageBoxIfNeedSave(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if AchievementSelectListModel.instance:checkDirty(AchievementSelectListModel.instance.isGroup) then
		GameFacade.showMessageBox(MessageBoxIdDefine.AchievementSaveCheck, MsgBoxEnum.BoxType.Yes_No, slot1, slot2, nil, slot4, slot5)
	elseif slot3 then
		slot3(slot6)
	end
end

function slot0.isCurrentShowGroupInPlayerView(slot0)
	slot2, slot3 = AchievementUtils.decodeShowStr(PlayerModel.instance:getShowAchievement())

	if slot3 and tabletool.len(slot3) > 0 then
		return true
	end
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
