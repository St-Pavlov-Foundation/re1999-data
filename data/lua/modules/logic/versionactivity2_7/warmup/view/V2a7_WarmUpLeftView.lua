module("modules.logic.versionactivity2_7.warmup.view.V2a7_WarmUpLeftView", package.seeall)

slot0 = class("V2a7_WarmUpLeftView", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._itemClick:AddClickListener(slot0._onItemClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._itemClick:RemoveClickListener()
end

slot1 = -1
slot2 = 0
slot3 = 1
slot4 = SLFramework.AnimatorPlayer
slot5 = {
	Clicked = 1
}
slot6 = 5

function slot0.ctor(slot0, ...)
	V2a6_WarmUpLeftView.super.ctor(slot0, ...)

	slot0._draggedState = uv0
end

function slot0._editableInitView(slot0)
	slot0._middleGo = gohelper.findChild(slot0.viewGO, "Middle")
	slot0._openGo = gohelper.findChild(slot0._middleGo, "open")
	slot0._unopenGo = gohelper.findChild(slot0._middleGo, "unopen")
	slot0._godrag = gohelper.findChild(slot0._unopenGo, "drag")
	slot0._guideGo = gohelper.findChild(slot0._unopenGo, "guide")
	slot0._simagepic = gohelper.findChildSingleImage(slot0._openGo, "#simage_pic")
	slot0._animatorPlayer = uv0.Get(slot0._middleGo)
	slot0._animtor = slot0._animatorPlayer.animator
	slot0._animEvent = gohelper.onceAddComponent(slot0._middleGo, gohelper.Type_AnimationEventWrap)
	slot0._itemClick = gohelper.getClickWithAudio(slot0._godrag)

	slot0:_setActive_drag(true)
end

function slot0.onOpen(slot0)
	slot0._animEvent:AddEventListener("play_ui_yuzhou_fax_earcap", slot0._play_ui_yuzhou_fax_earcap, slot0)
	slot0._animEvent:AddEventListener("play_ui_min_day_night", slot0._play_ui_min_day_night, slot0)
	slot0._animEvent:AddEventListener("play_ui_yuzhou_fax_beep", slot0._play_ui_yuzhou_fax_beep, slot0)
	slot0._animEvent:AddEventListener("play_ui_yuzhou_fax_print", slot0._play_ui_yuzhou_fax_print, slot0)
end

function slot0.onDataUpdateFirst(slot0)
	if isDebugBuild then
		assert(slot0.viewContainer:getEpisodeCount() <= uv0, "invalid config json_activity125 actId: " .. slot0.viewContainer:actId())
	end

	slot0._draggedState = slot0:_checkIsDone() and uv1 or uv2
end

function slot0.onDataUpdate(slot0)
	slot0:_refresh()
end

function slot0.onSwitchEpisode(slot0)
	if slot0._draggedState == uv0 and not slot0:_checkIsDone() then
		slot0._draggedState = uv1 - 1
	elseif slot0._draggedState < uv1 and slot1 then
		slot0._draggedState = uv0
	end

	slot0:_refresh()
end

function slot0._episodeId(slot0)
	return slot0.viewContainer:getCurSelectedEpisode()
end

function slot0._episode2Index(slot0, slot1)
	return slot0.viewContainer:episode2Index(slot1 or slot0:_episodeId())
end

function slot0._checkIsDone(slot0, slot1)
	return slot0.viewContainer:checkIsDone(slot1 or slot0:_episodeId())
end

function slot0._saveStateDone(slot0, slot1, slot2)
	slot0.viewContainer:saveStateDone(slot2 or slot0:_episodeId(), slot1)
end

function slot0._saveState(slot0, slot1, slot2)
	assert(slot1 ~= 1999, "please call _saveStateDone instead")
	slot0.viewContainer:saveState(slot2 or slot0:_episodeId(), slot1)
end

function slot0._getState(slot0, slot1, slot2)
	return slot0.viewContainer:getState(slot2 or slot0:_episodeId(), slot1)
end

function slot0._setActive_drag(slot0, slot1)
	gohelper.setActive(slot0._godrag, slot1)
end

function slot0._setActive_guide(slot0, slot1)
	gohelper.setActive(slot0._guideGo, slot1)
end

function slot0._refresh(slot0)
	slot0._simagepic:LoadImage(slot0.viewContainer:getImgResUrl(slot0:_episode2Index()))

	if slot0:_checkIsDone() then
		slot0:_setActive_guide(false)
		slot0:_setActive_drag(false)
		slot0:_playAnimOpend()
	elseif slot0:_getState() == 0 then
		slot0:_setActive_guide(slot0._draggedState <= uv0)
		slot0:_setActive_drag(true)
		slot0:_playAnimIdle()
	elseif uv1.Clicked == slot3 then
		slot0:_setActive_guide(false)
		slot0:_setActive_drag(false)
		slot0:_playAnimOpend()
		slot0:_playAnimAfterClicked()
	else
		logError("[V2a7_WarmUpLeftView] invalid state: " .. tostring(slot3))
	end
end

function slot0.onClose(slot0)
	slot0._animEvent:RemoveAllEventListener()
end

function slot0.onDestroyView(slot0)
end

function slot0._playAnimIdle(slot0, slot1, slot2)
	slot0:_playAnim(UIAnimationName.Unopen, slot1, slot2)
end

function slot0._playAnimOpend(slot0, slot1, slot2)
	slot0:_playAnim(UIAnimationName.Open, slot1, slot2)
end

function slot0._playAnimClick(slot0, slot1, slot2)
	slot0:_playAnim(UIAnimationName.Click, slot1, slot2)
end

function slot0._playAnim(slot0, slot1, slot2, slot3)
	slot0._animatorPlayer:Play(slot1, slot2 or function ()
	end, slot3)
end

function slot0._onItemClick(slot0)
	slot0:_setActive_drag(false)
	slot0:_play_ui_yuzhou_fax_earcap()
	slot0:_saveState(uv0.Clicked)
	slot0:_playAnimAfterClicked()
	slot0.viewContainer:setLocalIsPlayCurByUser()
end

slot7 = "V2a7_WarmUpLeftView:kBlock_Click"
slot8 = 9.99

function slot0._playAnimAfterClicked(slot0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockHelper.instance:startBlock(uv0, uv1, slot0.viewName)
	slot0.viewContainer:addNeedWaitCount()
	slot0:_playAnimClick(function ()
		UIBlockHelper.instance:endBlock(uv0)
		UIBlockMgrExtend.setNeedCircleMv(true)
		uv1:_saveStateDone(true)
	end)
	slot0.viewContainer:openDesc()
end

function slot0._play_ui_yuzhou_fax_earcap(slot0)
	AudioMgr.instance:trigger(AudioEnum2_7.WarmUp.play_ui_yuzhou_fax_earcap)
end

function slot0._play_ui_min_day_night(slot0)
	AudioMgr.instance:trigger(AudioEnum2_7.WarmUp.play_ui_min_day_night)
end

function slot0._play_ui_yuzhou_fax_beep(slot0)
	AudioMgr.instance:trigger(AudioEnum2_7.WarmUp.play_ui_yuzhou_fax_beep)
end

function slot0._play_ui_yuzhou_fax_print(slot0)
	AudioMgr.instance:trigger(AudioEnum2_7.WarmUp.play_ui_yuzhou_fax_print)
end

return slot0
