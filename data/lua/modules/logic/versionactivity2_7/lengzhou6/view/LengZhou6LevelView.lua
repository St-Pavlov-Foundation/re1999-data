module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6LevelView", package.seeall)

slot0 = class("LengZhou6LevelView", BaseView)
slot1 = -300
slot2 = 0.15

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._gostoryPath = gohelper.findChild(slot0.viewGO, "#go_storyPath")
	slot0._gostoryScroll = gohelper.findChild(slot0.viewGO, "#go_storyPath/#go_storyScroll")
	slot0._gostoryStages = gohelper.findChild(slot0.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages")
	slot0._gostage1 = gohelper.findChild(slot0.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages/#go_stage1")
	slot0._gostage2 = gohelper.findChild(slot0.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages/#go_stage2")
	slot0._gostage3 = gohelper.findChild(slot0.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages/#go_stage3")
	slot0._gostage4 = gohelper.findChild(slot0.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages/#go_stage4")
	slot0._gostage5 = gohelper.findChild(slot0.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages/#go_stage5")
	slot0._gostage6 = gohelper.findChild(slot0.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages/#go_stage6")
	slot0._gostage7 = gohelper.findChild(slot0.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages/#go_stage7")
	slot0._gostage8 = gohelper.findChild(slot0.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages/#go_stage8")
	slot0._gostage9 = gohelper.findChild(slot0.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages/#go_stage9")
	slot0._goTitle = gohelper.findChild(slot0.viewGO, "#go_Title")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "#go_Title/#simage_title")
	slot0._gotime = gohelper.findChild(slot0.viewGO, "#go_Title/#go_time")
	slot0._txtlimittime = gohelper.findChildText(slot0.viewGO, "#go_Title/#go_time/#txt_limittime")
	slot0._btnTask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Task")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "#btn_Task/#go_reddot")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnTask:AddClickListener(slot0._btnTaskOnClick, slot0)
	slot0._drag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEnd, slot0)
	slot0._touch:AddClickDownListener(slot0._onClickDown, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnTask:RemoveClickListener()
	slot0._drag:RemoveDragBeginListener()
	slot0._drag:RemoveDragEndListener()
	slot0._touch:RemoveClickDownListener()
end

function slot0._btnTaskOnClick(slot0)
	LengZhou6Controller.instance:openTaskView()
end

function slot0._editableInitView(slot0)
	slot0._taskAnimator = gohelper.findChild(slot0.viewGO, "#btn_Task/ani"):GetComponent(typeof(UnityEngine.Animator))

	RedDotController.instance:addRedDot(slot0._goreddot, RedDotEnum.DotNode.V2a7LengZhou6Task, nil, slot0._refreshRedDot, slot0)

	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._gostoryPath)
	slot0._touch = SLFramework.UGUI.UIClickListener.Get(slot0._gostoryPath)
	slot0._scrollStory = slot0._gostoryPath:GetComponent(gohelper.Type_ScrollRect)
	slot0._audioScroll = MonoHelper.addLuaComOnceToGo(slot0._gostoryPath, DungeonMapEpisodeAudio, slot0._scrollStory)
	slot0._transstoryScroll = slot0._gostoryScroll.transform
	slot0._ani = slot0.viewGO:GetComponent(gohelper.Type_Animator)
	slot2 = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	slot0._offsetX = (slot2 - uv0) / 2
	slot0.minContentAnchorX = -recthelper.getWidth(slot0._transstoryScroll) + slot2
end

function slot0.onOpen(slot0)
	slot0.actId = LengZhou6Model.instance:getAct190Id()

	slot0:addEventCb(LengZhou6Controller.instance, LengZhou6Event.OnClickEpisode, slot0._onClickEpisode, slot0)
	slot0:addEventCb(LengZhou6Controller.instance, LengZhou6Event.OnReceiveEpisodeInfo, slot0._refreshEpisode, slot0)
	slot0:addEventCb(LengZhou6Controller.instance, LengZhou6Event.OnFinishEpisode, slot0._onFinishEpisode, slot0)
	slot0:addEventCb(LengZhou6Controller.instance, LengZhou6Event.OnClickCloseGameView, slot0._onClickCloseGameView, slot0)
	TaskDispatcher.runRepeat(slot0.showLeftTime, slot0, TimeUtil.OneMinuteSecond)
	slot0:showLeftTime()
	AudioMgr.instance:trigger(AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_open)
	TaskDispatcher.runDelay(slot0.updateStage, slot0, 0.5)
	slot0:initStage()
end

function slot0.initStage(slot0)
	slot0._allEpisodeItemList = slot0:getUserDataTb_()

	for slot6 = 1, #LengZhou6Model.instance:getAllEpisodeIds() do
		slot7 = slot1[slot6]
		slot9 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0["_gostage" .. slot6], slot7)
		slot10 = MonoHelper.addNoUpdateLuaComOnceToGo(slot9, LengZhou6LevelItem)

		slot10:initEpisodeId(slot6, slot7)
		table.insert(slot0._allEpisodeItemList, slot10)
		gohelper.setActive(slot9, false)
	end
end

function slot0._refreshEpisode(slot0)
end

function slot0.updateStage(slot0)
	slot0:focusNewestLevelItem()
	TaskDispatcher.cancelTask(slot0.updateStage, slot0)

	if slot0._allEpisodeItemList ~= nil then
		for slot4, slot5 in pairs(slot0._allEpisodeItemList) do
			slot5:updateInfo(false)
		end
	end
end

function slot0.showLeftTime(slot0)
	slot0._txtlimittime.text = ActivityHelper.getActivityRemainTimeStr(LengZhou6Model.instance:getCurActId())
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.showLeftTime, slot0)
end

function slot0._refreshRedDot(slot0, slot1)
	slot1:defaultRefreshDot()
	slot0._taskAnimator:Play(slot1.show and "loop" or "idle")
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

function slot0._onClickEpisode(slot0, slot1, slot2)
	if slot0.actId ~= slot1 then
		return
	end

	slot0:onFocusEnd(slot2)
end

function slot0._onClickCloseGameView(slot0)
	slot0:playOpen1Ani()
end

function slot0.playOpen1Ani(slot0)
	if slot0._ani then
		AudioMgr.instance:trigger(AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_open)
		slot0._ani:Play("open1", 0, 0)
	end
end

function slot0._onFinishEpisode(slot0, slot1)
	if slot1 == nil then
		return
	end

	slot0._waitFinishAnimEpisode = slot1

	slot0:playOpen1Ani()
	TaskDispatcher.runDelay(slot0._onFinishEpisode2, slot0, 1)
end

function slot0._onFinishEpisode2(slot0)
	slot0:focusNewestLevelItem()
	slot0:playEpisodeFinishAnim()
	UIBlockHelper.instance:endBlock(LengZhou6Enum.BlockKey.OneClickResetLevel)
end

function slot0.getNewestLevelItem(slot0)
	slot1 = slot0._allEpisodeItemList[1]

	for slot6, slot7 in ipairs(slot0._allEpisodeItemList) do
		if slot7._episodeId == LengZhou6Model.instance:getNewestEpisodeId(slot0.actId) then
			slot1 = slot7

			break
		end
	end

	return slot1
end

function slot0.focusNewestLevelItem(slot0, slot1)
	if not slot0:getNewestLevelItem() then
		return
	end

	if slot0._offsetX - recthelper.getAnchorX(slot2.viewGO.transform.parent) > 0 then
		slot4 = 0
	elseif slot4 < slot0.minContentAnchorX then
		slot4 = slot0.minContentAnchorX
	end

	ZProj.TweenHelper.DOAnchorPosX(slot0._transstoryScroll, slot4, slot1 or 0, slot0.onFocusEnd, slot0)
end

function slot0.playEpisodeFinishAnim(slot0)
	if not slot0._waitFinishAnimEpisode then
		return
	end

	for slot4, slot5 in ipairs(slot0._allEpisodeItemList) do
		if slot5._episodeId == slot0._waitFinishAnimEpisode then
			slot0._finishEpisodeIndex = slot4

			if not slot5:finishStateEnd() then
				slot5:updateInfo(true)
				TaskDispatcher.runDelay(slot0._playEpisodeUnlockAnim, slot0, uv0)
			else
				slot5:updateInfo(false)

				slot0._finishEpisodeIndex = nil
			end
		end
	end

	slot0._waitFinishAnimEpisode = nil
end

function slot0._playEpisodeUnlockAnim(slot0)
	if not slot0._finishEpisodeIndex then
		return
	end

	if slot0._allEpisodeItemList[slot0._finishEpisodeIndex + 1] then
		slot1:updateInfo(true)
	end

	slot0._finishEpisodeIndex = nil
end

function slot0.onFocusEnd(slot0, slot1)
	if not slot1 then
		return
	end

	LengZhou6Controller.instance:enterEpisode(slot1)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.updateStage, slot0)
end

return slot0
