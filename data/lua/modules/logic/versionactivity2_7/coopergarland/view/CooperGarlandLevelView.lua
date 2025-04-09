module("modules.logic.versionactivity2_7.coopergarland.view.CooperGarlandLevelView", package.seeall)

slot0 = class("CooperGarlandLevelView", BaseView)
slot1 = -300
slot2 = 0.15

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._gostoryPath = gohelper.findChild(slot0.viewGO, "#go_storyPath")
	slot0._gostoryScroll = gohelper.findChild(slot0.viewGO, "#go_storyPath/#go_storyScroll")
	slot0._gostoryStages = gohelper.findChild(slot0.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages")
	slot0._goTitle = gohelper.findChild(slot0.viewGO, "#go_Title")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "#go_Title/#simage_title")
	slot0._gotime = gohelper.findChild(slot0.viewGO, "#go_Title/#go_time")
	slot0._txtlimittime = gohelper.findChildText(slot0.viewGO, "#go_Title/#go_time/#txt_limittime")
	slot0._btnTask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Task")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "#btn_Task/#go_reddot")
	slot0._btnExtraEpisode = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_ChallengeBtn")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnTask:AddClickListener(slot0._btnTaskOnClick, slot0)
	slot0._btnExtraEpisode:AddClickListener(slot0._btnExtraEpisodeOnClick, slot0)
	slot0._drag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEnd, slot0)
	slot0._touch:AddClickDownListener(slot0._onClickDown, slot0)
	slot0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnAct192InfoUpdate, slot0._onInfoUpdate, slot0)
	slot0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnClickEpisode, slot0._onClickEpisode, slot0)
	slot0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.FirstFinishEpisode, slot0._onFirstFinishEpisode, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnTask:RemoveClickListener()
	slot0._btnExtraEpisode:RemoveClickListener()
	slot0._drag:RemoveDragBeginListener()
	slot0._drag:RemoveDragEndListener()
	slot0._touch:RemoveClickDownListener()
	slot0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnAct192InfoUpdate, slot0._onInfoUpdate, slot0)
	slot0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnClickEpisode, slot0._onClickEpisode, slot0)
	slot0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.FirstFinishEpisode, slot0._onFirstFinishEpisode, slot0)
end

function slot0._btnTaskOnClick(slot0)
	CooperGarlandController.instance:openTaskView()
end

function slot0._btnExtraEpisodeOnClick(slot0)
	if CooperGarlandModel.instance:isUnlockEpisode(slot0.actId, CooperGarlandConfig.instance:getExtraEpisode(slot0.actId, true)) then
		CooperGarlandController.instance:clickEpisode(slot0.actId, slot1)
	end
end

function slot0._onDragBegin(slot0)
	slot0._audioScroll:onDragBegin()
end

function slot0._onDragEnd(slot0)
	slot0._audioScroll:onDragEnd()
end

function slot0._onClickDown(slot0)
	slot0._audioScroll:onClickDown()
end

function slot0._onInfoUpdate(slot0)
	slot0:refreshExtraEpisode()
end

function slot0._onClickEpisode(slot0, slot1, slot2)
	if slot0.actId ~= slot1 then
		return
	end

	slot0:onFocusEnd(slot2)
end

function slot0._onFirstFinishEpisode(slot0, slot1, slot2)
	if slot0.actId ~= slot1 then
		return
	end

	slot0:focusNewestLevelItem()

	slot0._waitFinishAnimEpisode = slot2

	slot0:playEpisodeFinishAnim()
end

function slot0._editableInitView(slot0)
	slot0.actId = CooperGarlandModel.instance:getAct192Id()
	slot0._taskAnimator = gohelper.findChild(slot0.viewGO, "#btn_Task/ani"):GetComponentInChildren(typeof(UnityEngine.Animator))
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._gostoryPath)
	slot0._touch = SLFramework.UGUI.UIClickListener.Get(slot0._gostoryPath)
	slot0._scrollStory = slot0._gostoryPath:GetComponent(gohelper.Type_ScrollRect)
	slot0._audioScroll = MonoHelper.addLuaComOnceToGo(slot0._gostoryPath, DungeonMapEpisodeAudio, slot0._scrollStory)
	slot0._transstoryScroll = slot0._gostoryScroll.transform
	slot0._pathAnimator = gohelper.findChildAnim(slot0.viewGO, "#go_storyPath/#go_storyScroll/path/path_2")
	slot0.openAnimComplete = nil
	slot0._waitFinishAnimEpisode = nil
	slot0._finishEpisodeIndex = nil
	slot2 = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	slot0._offsetX = (slot2 - uv0) / 2
	slot0.minContentAnchorX = -recthelper.getWidth(slot0._transstoryScroll) + slot2

	slot0:_initLevelItem()
	RedDotController.instance:addRedDot(slot0._goreddot, RedDotEnum.DotNode.V2a7CooperGarlandTask, nil, slot0._refreshRedDot, slot0)
end

function slot0._initLevelItem(slot0)
	if slot0._levelItemList then
		return
	end

	slot0._levelItemList = {}
	slot1 = slot0.viewContainer:getSetting().otherRes[1]

	if slot0._gostoryStages.transform.childCount < #CooperGarlandConfig.instance:getEpisodeIdList(slot0.actId, true) then
		logError(string.format("CooperGarlandLevelView:_initLevelItem error, level node not enough, has:%s, need:%s", slot5, slot3))
	end

	slot6 = 1

	for slot10 = 1, slot5 do
		if slot2[slot10] then
			if CooperGarlandConfig.instance:isGameEpisode(slot0.actId, slot11) then
				MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot1, slot4:GetChild(slot10 - 1).gameObject, string.format("levelItem_%s", slot10)), CooperGarlandLevelItem):setData(slot0.actId, slot11, slot10, slot6)

				slot6 = slot6 + 1
			else
				slot15:setData(slot0.actId, slot11, slot10)
			end

			table.insert(slot0._levelItemList, slot15)
		end
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:refreshUI()
	TaskDispatcher.runRepeat(slot0.refreshTime, slot0, TimeUtil.OneMinuteSecond)
	slot0:focusNewestLevelItem()

	slot1 = 0

	for slot5, slot6 in ipairs(slot0._levelItemList) do
		if CooperGarlandModel.instance:isFinishedEpisode(slot0.actId, slot6.episodeId) then
			slot1 = slot6.index
		end
	end

	slot0:_playPathAnim(slot1, false)
end

function slot0.getNewestLevelItem(slot0)
	slot1 = slot0._levelItemList[1]

	for slot6, slot7 in ipairs(slot0._levelItemList) do
		if slot7.episodeId == CooperGarlandModel.instance:getNewestEpisodeId(slot0.actId) then
			slot1 = slot7

			break
		end
	end

	return slot1
end

function slot0.refreshUI(slot0)
	slot0:refreshTime()
	slot0:refreshExtraEpisode()
end

function slot0.refreshTime(slot0)
	slot0._txtlimittime.text, slot2 = CooperGarlandModel.instance:getAct192RemainTimeStr(slot0.actId)

	if slot2 then
		TaskDispatcher.cancelTask(slot0.refreshTime, slot0)
	end
end

function slot0.refreshExtraEpisode(slot0)
	gohelper.setActive(slot0._btnExtraEpisode, CooperGarlandModel.instance:isUnlockEpisode(slot0.actId, CooperGarlandConfig.instance:getExtraEpisode(slot0.actId, true)))
end

function slot0._refreshRedDot(slot0, slot1)
	slot1:defaultRefreshDot()
	slot0._taskAnimator:Play(slot1.show and "loop" or "idle")
end

function slot0.focusNewestLevelItem(slot0, slot1)
	if not slot0:getNewestLevelItem() then
		return
	end

	if slot0._offsetX - recthelper.getAnchorX(slot2._go.transform.parent) > 0 then
		slot4 = 0
	elseif slot4 < slot0.minContentAnchorX then
		slot4 = slot0.minContentAnchorX
	end

	ZProj.TweenHelper.DOAnchorPosX(slot0._transstoryScroll, slot4, slot1 or 0, slot0.onFocusEnd, slot0)
end

function slot0.onFocusEnd(slot0, slot1)
	if not slot1 then
		return
	end

	CooperGarlandController.instance:afterClickEpisode(slot0.actId, slot1)
end

function slot0.playEpisodeFinishAnim(slot0)
	if not slot0.openAnimComplete or not slot0._waitFinishAnimEpisode then
		return
	end

	for slot4, slot5 in ipairs(slot0._levelItemList) do
		if slot5.episodeId == slot0._waitFinishAnimEpisode then
			slot0._finishEpisodeIndex = slot4

			slot5:refreshUI("finish")
			AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.play_ui_yuzhou_level_lit)
			slot0:_playPathAnim(slot0._finishEpisodeIndex, true)
			TaskDispatcher.runDelay(slot0._playEpisodeUnlockAnim, slot0, uv0)
		end
	end

	slot0.openAnimComplete = nil
	slot0._waitFinishAnimEpisode = nil
end

function slot0._playPathAnim(slot0, slot1, slot2)
	if slot1 > 0 then
		slot0._pathAnimator.speed = 1

		slot0._pathAnimator:Play(string.format("go%s", Mathf.Clamp(slot1, 1, #slot0._levelItemList)), 0, slot2 and 0 or 1)
	else
		slot0._pathAnimator.speed = 0

		slot0._pathAnimator:Play("go1", -1, 0)
	end
end

function slot0._playEpisodeUnlockAnim(slot0)
	if not slot0._finishEpisodeIndex then
		return
	end

	if slot0._levelItemList[slot0._finishEpisodeIndex + 1] then
		slot1:refreshUI("unlock")
		AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.play_ui_yuzhou_level_unlock)
	end

	slot0._finishEpisodeIndex = nil
end

function slot0.onClose(slot0)
	slot0.openAnimComplete = nil
	slot0._waitFinishAnimEpisode = nil
	slot0._finishEpisodeIndex = nil

	TaskDispatcher.cancelTask(slot0.refreshTime, slot0)
	TaskDispatcher.cancelTask(slot0._playEpisodeUnlockAnim, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
