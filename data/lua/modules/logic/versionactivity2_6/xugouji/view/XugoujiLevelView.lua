module("modules.logic.versionactivity2_6.xugouji.view.XugoujiLevelView", package.seeall)

slot0 = class("XugoujiLevelView", BaseView)
slot1 = VersionActivity2_6Enum.ActivityId.Xugouji

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._btntask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Task", AudioEnum.UI.play_ui_mission_open)
	slot0._goTaskAni = gohelper.findChild(slot0.viewGO, "#btn_Task/ani")
	slot0._btnChallenge = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_ChallengeBtn")
	slot0._gostages = gohelper.findChild(slot0.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages")
	slot0._goscrollcontent = gohelper.findChild(slot0.viewGO, "#go_storyPath/#go_storyScroll")
	slot0._gostoryPath = gohelper.findChild(slot0.viewGO, "#go_storyPath")
	slot0._gostoryScroll = gohelper.findChild(slot0.viewGO, "#go_storyPath/#go_storyScroll")
	slot0._scrollStory = gohelper.findChildScrollRect(slot0._gostoryPath, "")
	slot0._gored = gohelper.findChild(slot0.viewGO, "#btn_Task/#go_reddot")
	slot0._goPath = gohelper.findChild(slot0._goscrollcontent, "path/path_2")
	slot0._animPath = slot0._goPath:GetComponent(gohelper.Type_Animator)
	slot0._pathAnimator = ZProj.ProjAnimatorPlayer.Get(slot0._goPath)
	slot0._txtlimittime = gohelper.findChildText(slot0.viewGO, "#go_Title/#go_time/#txt_limittime")
	slot0._taskAnimator = slot0._goTaskAni:GetComponent(gohelper.Type_Animator)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btntask:AddClickListener(slot0._btntaskOnClick, slot0)
	slot0._btnChallenge:AddClickListener(slot0._btnChallengeOnClick, slot0)
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.EpisodeUpdate, slot0._onEpisodeUpdate, slot0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, slot0._refreshTask, slot0)
	RedDotController.instance:addRedDot(slot0._gored, RedDotEnum.DotNode.V2a6XugoujiTask)
end

function slot0.removeEvents(slot0)
	slot0._btntask:RemoveClickListener()
	slot0._btnChallenge:RemoveClickListener()
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, slot0._refreshTask, slot0)
end

function slot0._btntaskOnClick(slot0)
	XugoujiController.instance:openTaskView()
end

function slot0._btnChallengeOnClick(slot0)
	XugoujiController.instance:enterEpisode(XugoujiEnum.ChallengeEpisodeId)
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

function slot0._editableInitView(slot0)
	slot1 = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	slot0._offsetX = (slot1 - -300) / 2
	slot0.minContentAnchorX = -6560 + slot1
	slot0._bgWidth = recthelper.getWidth(slot0._simageFullBG.transform)
	slot0._minBgPositionX = BootNativeUtil.getDisplayResolution() - slot0._bgWidth
	slot0._maxBgPositionX = 0
	slot0._bgPositonMaxOffsetX = math.abs(slot0._maxBgPositionX - slot0._minBgPositionX)
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._gostoryPath)
	slot0._touch = SLFramework.UGUI.UIClickListener.Get(slot0._gostoryPath)

	slot0._drag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEnd, slot0)
	slot0._touch:AddClickDownListener(slot0._onClickDown, slot0)

	slot0._audioScroll = MonoHelper.addLuaComOnceToGo(slot0._gostoryPath, DungeonMapEpisodeAudio, slot0._scrollStory)
end

function slot0.onOpen(slot0)
	slot0:refreshTime()
	slot0:_initStages()
	slot0:refreshChallengeBtn()
	slot0:_refreshTask()
	TaskDispatcher.runRepeat(slot0.refreshTime, slot0, 60)
	slot0:focusEpisodeItem(slot0:getCurEpisodeIndex() + 1, Activity188Model.instance:getCurEpisodeId(), false, false)
end

function slot0._initStages(slot0)
	if slot0._stageItemList then
		return
	end

	slot0._stageItemList = {}
	slot0._curOpenEpisodeCount = Activity188Model.instance:getFinishedCount() + 1
	slot2 = Activity188Model.instance:getFinishedCount()
	slot3 = Activity188Config.instance:getEpisodeCfgList(uv0)

	Activity188Model.instance:setCurEpisodeId((slot3[Mathf.Clamp(tonumber(GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.Version2_6XugoujiSelect .. uv0, "1")) or 1, 1, #slot3)] and slot3[slot4] or slot3[1]).episodeId)

	for slot10 = 1, #slot3 do
		slot13 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], gohelper.findChild(slot0._gostages, "stage" .. slot10)), XugoujiLevelViewStageItem, slot0)

		slot13:refreshItem(slot3[slot10], slot10)
		table.insert(slot0._stageItemList, slot13)
	end

	if slot0._curOpenEpisodeCount == 1 then
		gohelper.setActive(slot0._goPath, false)
	elseif slot2 == #slot3 then
		gohelper.setActive(slot0._goPath, true)
		slot0._animPath:Play("go" .. slot2 - 2, 0, 1)
	else
		gohelper.setActive(slot0._goPath, true)
		slot0._animPath:Play("go" .. slot2, 0, 1)
	end
end

function slot0.getCurEpisodeIndex(slot0)
	if not Activity188Config.instance:getEpisodeCfg(uv0, Activity188Model.instance:getCurEpisodeId()) then
		return 1
	end

	for slot7, slot8 in ipairs(slot0._stageItemList) do
		if slot8.episodeId == (slot2 and slot2.episodeId or 0) then
			return slot7
		end
	end
end

function slot0.refreshTime(slot0)
	if ActivityModel.instance:getActivityInfo()[uv0] and slot1:getRealEndTimeStamp() - ServerTime.now() > 0 then
		slot0._txtlimittime.text = TimeUtil.SecondToActivityTimeFormat(slot2)

		return
	end
end

function slot0.refreshChallengeBtn(slot0)
	gohelper.setActive(slot0._btnChallenge, Activity188Model.instance:isEpisodeUnlock(XugoujiEnum.ChallengeEpisodeId))
end

function slot0.focusEpisodeItem(slot0, slot1, slot2, slot3, slot4, slot5)
	if not slot0._stageItemList[slot1] then
		return
	end

	if slot0._offsetX - recthelper.getAnchorX(slot6.viewGO.transform.parent) > 0 then
		slot8 = 0
	elseif slot8 < slot0.minContentAnchorX then
		slot8 = slot0.minContentAnchorX
	end

	if slot4 then
		if slot5 then
			ZProj.TweenHelper.DOAnchorPosX(slot0._gostoryScroll.transform, slot8, 0.26)
		else
			ZProj.TweenHelper.DOAnchorPosX(slot0._gostoryScroll.transform, slot8, 0.26, slot0.onFocusEnd, slot0, {
				slot2,
				slot3
			})
		end
	else
		ZProj.TweenHelper.DOAnchorPosX(slot0._gostoryScroll.transform, slot8, 0)
	end
end

function slot0.onFocusEnd(slot0, slot1)
end

function slot0._onEpisodeFinish(slot0, slot1)
	XugoujiController.instance:getStatMo():sendDungeonFinishStatData()

	if Activity188Model.instance:getFinishedCount() < slot0._curOpenEpisodeCount then
		return
	end

	slot0._curOpenEpisodeCount = slot3 + 1

	gohelper.setActive(slot0._goPath, true)
	slot0._animPath:Play("go" .. slot3, 0, 0)
	slot0._stageItemList[slot3]:onPlayFinish()

	if slot0._stageItemList[slot3 + 1] then
		slot0._stageItemList[slot3 + 1]:onPlayUnlock()
	end

	slot0:_refreshTask()
end

function slot0._onEpisodeUpdate(slot0)
	if Activity188Model.instance:getFinishedCount() < slot0._curOpenEpisodeCount then
		return
	end

	slot0._curOpenEpisodeCount = slot1 + 1
	slot0._needFinishAni = true

	slot0:refreshChallengeBtn()
end

function slot0.doEpisodeFinishedDisplay(slot0)
	if not slot0._needFinishAni then
		return
	end

	slot0._needFinishAni = false
	slot1 = Activity188Model.instance:getFinishedCount()

	slot0._stageItemList[slot1]:playFinishAni()
	gohelper.setActive(slot0._goPath, true)
	slot0._animPath:Play("go" .. slot1, 0, 0)

	if slot0._stageItemList[slot1 + 1] then
		TaskDispatcher.runDelay(slot0.doNewEpisodeUnlockDisplay, slot0, 0.5)
	end
end

function slot0.doNewEpisodeUnlockDisplay(slot0)
	if slot0._stageItemList[Activity188Model.instance:getFinishedCount() + 1] then
		slot0._stageItemList[slot1 + 1]:playUnlockAni()
		slot0:focusEpisodeItem(slot1 + 1, Activity188Model.instance:getCurEpisodeId(), false, true)
	end
end

function slot0._refreshTask(slot0)
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V2a6XugoujiTask, 0) then
		slot0._taskAnimator:Play(UIAnimationName.Loop, 0, 0)
	else
		slot0._taskAnimator:Play(UIAnimationName.Idle, 0, 0)
	end
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.refreshTime, slot0)
	TaskDispatcher.cancelTask(slot0.doNewEpisodeUnlockDisplay, slot0)

	if slot0._drag then
		slot0._drag:RemoveDragBeginListener()
		slot0._drag:RemoveDragEndListener()

		slot0._drag = nil
	end

	if slot0._touch then
		slot0._touch:RemoveClickDownListener()

		slot0._touch = nil
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.refreshTime, slot0)
end

return slot0
