module("modules.logic.versionactivity2_6.xugouji.view.XugoujiLevelView", package.seeall)

slot0 = class("XugoujiLevelView", BaseView)
slot1 = VersionActivity2_6Enum.ActivityId.Xugouji

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._btntask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Task", AudioEnum.UI.play_ui_mission_open)
	slot0._btnChallenge = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_ChallengeBtn")
	slot0._gostages = gohelper.findChild(slot0.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages")
	slot0._goscrollcontent = gohelper.findChild(slot0.viewGO, "#go_storyPath/#go_storyScroll")
	slot0._gostoryPath = gohelper.findChild(slot0.viewGO, "#go_storyPath")
	slot0._gostoryScroll = gohelper.findChild(slot0.viewGO, "#go_storyPath/#go_storyScroll")
	slot0._scrollStory = gohelper.findChildScrollRect(slot0._gostoryPath, "")
	slot0._animPath = gohelper.findChild(slot0._goscrollcontent, "path/path_2"):GetComponent(gohelper.Type_Animator)
	slot0._txtlimittime = gohelper.findChildText(slot0.viewGO, "#go_Title/#go_time/#txt_limittime")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btntask:AddClickListener(slot0._btntaskOnClick, slot0)
	slot0._btnChallenge:AddClickListener(slot0._btnChallengeOnClick, slot0)
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.EpisodeUpdate, slot0._onEpisodeUpdate, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btntask:RemoveClickListener()
	slot0._btnChallenge:RemoveClickListener()
end

function slot0._btntaskOnClick(slot0)
	XugoujiController.instance:openTaskView()
end

function slot0._btnChallengeOnClick(slot0)
	XugoujiController.instance:enterEpisode(XugoujiEnum.ChallengeEpisodeId)
end

function slot0._editableInitView(slot0)
	slot1 = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	slot0._offsetX = (slot1 - -300) / 2
	slot0.minContentAnchorX = -6960 + slot1
	slot0._bgWidth = recthelper.getWidth(slot0._simageFullBG.transform)
	slot0._minBgPositionX = BootNativeUtil.getDisplayResolution() - slot0._bgWidth
	slot0._maxBgPositionX = 0
	slot0._bgPositonMaxOffsetX = math.abs(slot0._maxBgPositionX - slot0._minBgPositionX)
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._gostoryPath)
	slot0._touch = SLFramework.UGUI.UIClickListener.Get(slot0._gostoryPath)
end

function slot0.onOpen(slot0)
	slot0:refreshTime()
	slot0:_initStages()
	slot0:refreshChallengeBtn()
	TaskDispatcher.runRepeat(slot0.refreshTime, slot0, TimeUtil.OneMinuteSecond)
	slot0:focusEpisodeItem(slot0:getCurEpisodeIndex(), Activity188Model.instance:getCurEpisodeId(), false, false)
end

function slot0._initStages(slot0)
	if slot0._stageItemList then
		return
	end

	slot0._stageItemList = {}
	slot0._curOpenEpisodeCount = Activity188Model.instance:getFinishedCount() + 1
	slot2 = Activity188Config.instance:getEpisodeCfgList(uv0)

	Activity188Model.instance:setCurEpisodeId((slot2[Mathf.Clamp(tonumber(GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.Version2_6XugoujiSelect .. uv0, "1")) or 1, 1, #slot2)] and slot2[slot3] or slot2[1]).episodeId)

	for slot9 = 1, #slot2 do
		slot12 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], gohelper.findChild(slot0._gostages, "stage" .. slot9)), XugoujiLevelViewStageItem, slot0)

		slot12:refreshItem(slot2[slot9], slot9)
		table.insert(slot0._stageItemList, slot12)
	end

	if slot0._curOpenEpisodeCount == 1 then
		slot0._animPath.speed = 0

		slot0._animPath:Play("go1", 0, 0)
	else
		slot0._animPath.speed = 1

		slot0._animPath:Play("go" .. slot0._curOpenEpisodeCount, 0, 1)
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

	TaskDispatcher.cancelTask(slot0.refreshTime, slot0)
end

function slot0.refreshChallengeBtn(slot0)
	gohelper.setActive(slot0._btnChallenge, Activity188Model.instance:isEpisodeUnlock(XugoujiEnum.ChallengeEpisodeId))
end

function slot0.focusEpisodeItem(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot0._offsetX - recthelper.getAnchorX(slot0._stageItemList[slot1].viewGO.transform.parent) > 0 then
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

function slot0._onEpisodeFinish(slot0, slot1)
	if Activity188Model.instance:getFinishedCount() < slot0._curOpenEpisodeCount then
		return
	end

	slot0._curOpenEpisodeCount = slot2 + 1
	slot0._animPath.speed = 1

	slot0._animPath:Play("go" .. slot2, 0, 0)
	slot0._stageItemList[slot2]:onPlayFinish()

	if slot0._stageItemList[slot2 + 1] then
		slot0._stageItemList[slot2 + 1]:onPlayUnlock()
	end
end

function slot0._onEpisodeUpdate(slot0)
	if Activity188Model.instance:getFinishedCount() < slot0._curOpenEpisodeCount then
		return
	end

	slot0._curOpenEpisodeCount = slot1 + 1
	slot0._animPath.speed = 1

	slot0._animPath:Play("go" .. slot1, 0, 0)
	slot0._stageItemList[slot1]:playFinishAni()

	if slot0._stageItemList[slot1 + 1] then
		slot0._stageItemList[slot1 + 1]:playUnlockAni()
	end

	slot0:refreshChallengeBtn()
end

function slot0.onDestroyView(slot0)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.refreshTime, slot0)
end

return slot0
