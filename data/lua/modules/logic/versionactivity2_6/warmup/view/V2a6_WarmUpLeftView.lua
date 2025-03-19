slot0 = string.format

module("modules.logic.versionactivity2_6.warmup.view.V2a6_WarmUpLeftView", package.seeall)

slot1 = class("V2a6_WarmUpLeftView", BaseView)

function slot1.onInitView(slot0)
	slot0._simagepic = gohelper.findChildSingleImage(slot0.viewGO, "Middle/open/#simage_pic")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot1.addEvents(slot0)
end

function slot1.removeEvents(slot0)
end

slot2 = -1
slot3 = 0
slot4 = 1
slot5 = SLFramework.AnimatorPlayer
slot6 = {
	SwipeDone = 1
}
slot7 = 5

function slot1.ctor(slot0, ...)
	uv0.super.ctor(slot0, ...)

	slot0._lastEpisodeId = nil
	slot0._needWaitCount = 0
	slot0._draggedState = uv1
	slot0._dayItemList = {}
	slot0._drag = UIDragListenerHelper.New()
end

function slot1._editableInitView(slot0)
	slot0._middleGo = gohelper.findChild(slot0.viewGO, "Middle")
	slot0._openGo = gohelper.findChild(slot0._middleGo, "open")
	slot0._unopenGo = gohelper.findChild(slot0._middleGo, "unopen")
	slot0._godrag = gohelper.findChild(slot0._unopenGo, "drag")
	slot0._guideGo = gohelper.findChild(slot0._unopenGo, "guide")
	slot0._animatorPlayer = uv0.Get(slot0._middleGo)
	slot0._animtor = slot0._animatorPlayer.animator

	slot0._drag:create(slot0._godrag)
	slot0._drag:registerCallback(slot0._drag.EventBegin, slot0._onDragBegin, slot0)
	slot0._drag:registerCallback(slot0._drag.EventEnd, slot0._onDragEnd, slot0)
	slot0:_setActive_drag(true)
end

function slot1.onOpen(slot0)
end

function slot1.onClose(slot0)
	GameUtil.onDestroyViewMember(slot0, "_drag")
end

function slot1.onDestroyView(slot0)
	GameUtil.onDestroyViewMember(slot0, "_drag")
end

function slot1.onDataUpdateFirst(slot0)
	if isDebugBuild then
		assert(slot0.viewContainer:getEpisodeCount() <= uv0, "invalid config json_activity125 actId: " .. slot0.viewContainer:actId())
	end

	slot0._draggedState = slot0:_checkIsDone() and uv1 or uv2
end

function slot1.onDataUpdate(slot0)
	slot0:_refresh()
end

function slot1.onSwitchEpisode(slot0)
	if slot0._draggedState == uv0 and not slot0:_checkIsDone() then
		slot0._draggedState = uv1 - 1
	elseif slot0._draggedState < uv1 and slot1 then
		slot0._draggedState = uv0
	end

	slot0:_refresh()
end

function slot1._episodeId(slot0)
	return slot0.viewContainer:getCurSelectedEpisode()
end

function slot1._episode2Index(slot0, slot1)
	return slot0.viewContainer:episode2Index(slot1 or slot0:_episodeId())
end

function slot1._checkIsDone(slot0, slot1)
	return slot0.viewContainer:checkIsDone(slot1 or slot0:_episodeId())
end

function slot1._saveStateDone(slot0, slot1, slot2)
	slot0.viewContainer:saveStateDone(slot2 or slot0:_episodeId(), slot1)
end

function slot1._saveState(slot0, slot1, slot2)
	assert(slot1 ~= 1999, "please call _saveStateDone instead")
	slot0.viewContainer:saveState(slot2 or slot0:_episodeId(), slot1)
end

function slot1._getState(slot0, slot1, slot2)
	return slot0.viewContainer:getState(slot2 or slot0:_episodeId(), slot1)
end

function slot1._setActive_drag(slot0, slot1)
	gohelper.setActive(slot0._godrag, slot1)
end

function slot1._setActive_guide(slot0, slot1)
	gohelper.setActive(slot0._guideGo, slot1)
end

function slot1._refresh(slot0)
	slot0:_refreshImg()

	if slot0:_checkIsDone() then
		slot0:_playAnimOpend()
		slot0:_setActive_drag(false)
		slot0:_setActive_guide(false)
	elseif slot0:_getState() == 0 then
		slot0:_setActive_guide(not slot1 and slot0._draggedState <= uv0)
		slot0:_setActive_drag(true)
		slot0:_playAnimIdle()
	elseif uv1.SwipeDone == slot2 then
		slot0:_setActive_guide(false)
		slot0:_setActive_drag(false)
		slot0:_playAnimAfterSwipe()
	else
		logError("[V2a6_WarmUpLeftView] invalid state:" .. slot2)
	end
end

function slot1._refreshImg(slot0)
	GameUtil.loadSImage(slot0._simagepic, uv0("singlebg/v2a6_warmup_singlebg/v2a6_warmup_pic_%s.png", slot0:_episodeId()))
end

function slot1._onDragBegin(slot0)
	slot0:_setActive_guide(false)
end

function slot1._onDragEnd(slot0)
	if slot0:_checkIsDone() then
		return
	end

	if slot0._drag:isSwipeLT() or slot0._drag:isSwipeRB() or slot0._drag:isSwipeLeft() then
		slot0:_saveState(uv0.SwipeDone)
		slot0:_playAnimAfterSwipe()
	end
end

function slot1._playAnimAfterSwipe(slot0)
	slot0:_playAnimOpen(function ()
		uv0:_saveStateDone(true)
		uv0.viewContainer:openDesc()
	end)
end

function slot1._playAnimIdle(slot0)
	slot0:_playAnim(UIAnimationName.Close)
end

function slot1._playAnimOpen(slot0, slot1, slot2)
	AudioMgr.instance:trigger(AudioEnum2_6.WarmUp.play_ui_wenming_page_20260904)
	slot0:_playAnim(UIAnimationName.Open, slot1, slot2)
end

function slot1._playAnimOpend(slot0)
	slot0:_playAnim(UIAnimationName.Finish)
end

function slot1._playAnim(slot0, slot1, slot2, slot3)
	slot0._animatorPlayer:Play(slot1, slot2 or function ()
	end, slot3)
end

return slot1
