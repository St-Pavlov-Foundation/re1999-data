module("modules.logic.weekwalk_2.view.WeekWalk_2Ending", package.seeall)

slot0 = class("WeekWalk_2Ending", BaseView)

function slot0.onInitView(slot0)
	slot0._gofinish = gohelper.findChild(slot0.viewGO, "#go_finish")
	slot0._scrollnull = gohelper.findChildScrollRect(slot0.viewGO, "#go_finish/weekwalkending/#scroll_null")
	slot0._gostartemplate = gohelper.findChild(slot0.viewGO, "#go_finish/weekwalkending/#scroll_null/starlist/#go_star_template")
	slot0._gostartemplate2 = gohelper.findChild(slot0.viewGO, "#go_finish/weekwalkending/#scroll_null/starlist2/#go_star_template2")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._viewAnim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._animator = slot0._gofinish:GetComponent(typeof(UnityEngine.Animator))
	slot0._mapId = WeekWalk_2Model.instance:getCurMapId()
	slot0._animEventWrap = slot0._gofinish:GetComponent(typeof(ZProj.AnimationEventWrap))

	slot0._animEventWrap:AddEventListener("star", slot0._startShowStars, slot0)

	slot0._time2 = 0.2
end

function slot0._startShowStars(slot0)
	if not slot0._starList then
		return
	end

	slot0:_starsAppear()
end

function slot0._starsAppear(slot0)
	slot0._curAppearIndex = 1

	TaskDispatcher.cancelTask(slot0._oneStarAppear, slot0)
	TaskDispatcher.runRepeat(slot0._oneStarAppear, slot0, 0.12)
end

function slot0._oneStarAppear(slot0)
	gohelper.setActive(slot0._starList[slot0._curAppearIndex], true)
	gohelper.setActive(slot0._starList[slot0._curAppearIndex + slot0._maxGroupNnum], true)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_LuckDraw_Hero_Stars)

	slot0._curAppearIndex = slot0._curAppearIndex + 1

	if slot0._maxGroupNnum < slot0._curAppearIndex then
		TaskDispatcher.cancelTask(slot0._oneStarAppear, slot0)
	end
end

function slot0._addStarList(slot0)
	slot0._starList = slot0:getUserDataTb_()
	slot2 = WeekWalk_2Model.instance:getBattleInfoByIdAndIndex(slot0._mapId, WeekWalk_2Enum.BattleIndex.Second)

	for slot7 = 1, slot0._maxNum do
		slot8 = slot7 <= WeekWalk_2Enum.MaxStar
		slot9 = slot8 and gohelper.cloneInPlace(slot0._gostartemplate) or gohelper.cloneInPlace(slot0._gostartemplate2)

		gohelper.setActive(slot9, true)
		gohelper.setActive(gohelper.findChild(slot9, "star"), false)

		slot11 = gohelper.findChildImage(slot9, "star/xingxing")
		slot11.enabled = false

		if slot8 then
			WeekWalk_2Helper.setCupEffect(slot0.viewContainer:getResInst(slot0.viewContainer._viewSetting.otherRes.weekwalkheart_star, slot11.gameObject), WeekWalk_2Model.instance:getBattleInfoByIdAndIndex(slot0._mapId, WeekWalk_2Enum.BattleIndex.First):getCupInfo(slot7))
		else
			WeekWalk_2Helper.setCupEffect(slot12, slot2:getCupInfo(slot7 - WeekWalk_2Enum.MaxStar))
		end

		table.insert(slot0._starList, slot10)
	end
end

function slot0.onOpen(slot0)
	slot0:addEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkResetLayer, slot0._onWeekwalkResetLayer, slot0)
	slot0:_showFinishAnim()
end

function slot0._onWeekwalkResetLayer(slot0)
	gohelper.setActive(slot0._gofinish, false)
end

function slot0._onWeekwalkInfoUpdate(slot0)
	slot0:_showFinishAnim()
end

function slot0._showFinishAnim(slot0)
	slot0._mapInfo = WeekWalk_2Model.instance:getCurMapInfo()

	if not slot0._mapInfo then
		return
	end

	slot0._maxGroupNnum = WeekWalk_2Enum.MaxStar
	slot0._maxNum = 6
	slot0._curNum = 6

	if not slot0._mapInfo.allPass or not not slot0._mapInfo.showFinished then
		slot0:_onShowFinishAnimDone()

		return
	end

	TaskDispatcher.runDelay(slot0._playPadAudio, slot0, slot0._time2)
	slot0:_addStarList()

	if not slot0._mapInfo.showFinished then
		WeekWalk_2Model.instance:setFinishMapId(slot0._mapId)
	end

	Weekwalk_2Rpc.instance:sendWeekwalkVer2MarkShowFinishedRequest(slot0._mapId)

	slot0._mapInfo.showFinished = true

	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("showFinishAnim")
	gohelper.setActive(slot0._gofinish, true)

	slot0._viewAnim.enabled = true
	slot1 = 3.7

	if slot0._curNum == slot0._maxNum then
		slot0._animator:Play("ending2")
		slot0._viewAnim:Play("finish_map2")
	else
		slot0._animator:Play("ending1")
		slot0._viewAnim:Play("finish_map1")
	end

	TaskDispatcher.runDelay(slot0._closeFinishAnim, slot0, slot1)

	slot0._isPlayMapFinishClip = nil

	TaskDispatcher.runRepeat(slot0._checkAnimClip, slot0, 0)
end

function slot0._playPadAudio(slot0)
	AudioMgr.instance:trigger(AudioEnum2_6.WeekWalk_2.play_ui_fight_artificial_stars_pad)
end

function slot0._checkAnimClip(slot0)
	if slot0._isPlayMapFinishClip then
		TaskDispatcher.cancelTask(slot0._checkAnimClip, slot0)

		return
	end

	if slot0._animator:GetCurrentAnimatorStateInfo(0):IsName("open") then
		slot0._isPlayMapFinishClip = true

		AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_mapfinish)
	end
end

function slot0._closeFinishAnim(slot0)
	TaskDispatcher.cancelTask(slot0._checkAnimClip, slot0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("showFinishAnim")
	gohelper.setActive(slot0._gofinish, slot0._curNum == slot0._maxNum)
	WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnShowFinishAnimDone)
	slot0:_onShowFinishAnimDone()
end

function slot0._onShowFinishAnimDone(slot0)
	TaskDispatcher.runDelay(slot0._showIdle, slot0, 0)
end

function slot0._showIdle(slot0)
	if slot0._mapInfo.allPass and slot0._curNum == slot0._maxNum then
		gohelper.setActive(slot0._gofinish, true)
		slot0._animator:Play(UIAnimationName.Idle)
	end
end

function slot0.onClose(slot0)
	gohelper.setActive(slot0._gofinish, false)
	TaskDispatcher.cancelTask(slot0._playPadAudio, slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._checkAnimClip, slot0)
	TaskDispatcher.cancelTask(slot0._oneStarAppear, slot0)
	TaskDispatcher.cancelTask(slot0._closeFinishAnim, slot0)
	TaskDispatcher.cancelTask(slot0._showIdle, slot0)
	slot0._animEventWrap:RemoveAllEventListener()
end

return slot0
