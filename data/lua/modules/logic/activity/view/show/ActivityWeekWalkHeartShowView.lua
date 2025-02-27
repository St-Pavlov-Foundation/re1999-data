module("modules.logic.activity.view.show.ActivityWeekWalkHeartShowView", package.seeall)

slot0 = class("ActivityWeekWalkHeartShowView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "#txt_desc")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "reset/#txt_time")
	slot0._goprogress = gohelper.findChild(slot0.viewGO, "#go_progress")
	slot0._txtprogress = gohelper.findChildText(slot0.viewGO, "#go_progress/#txt_progress")
	slot0._scrollreward = gohelper.findChildScrollRect(slot0.viewGO, "reward/rewardPreview/#scroll_reward")
	slot0._gorewardContent = gohelper.findChild(slot0.viewGO, "reward/rewardPreview/#scroll_reward/Viewport/#go_rewardContent")
	slot0._gorewarditem = gohelper.findChild(slot0.viewGO, "reward/rewardPreview/#scroll_reward/Viewport/#go_rewardContent/#go_rewarditem")
	slot0._btnjump = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_jump")
	slot0._btndetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_detail")
	slot0._gonewrule = gohelper.findChild(slot0.viewGO, "#btn_detail/#go_newrule")
	slot0._btnbuff = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_buff")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnjump:AddClickListener(slot0._btnjumpOnClick, slot0)
	slot0._btndetail:AddClickListener(slot0._btndetailOnClick, slot0)
	slot0._btnbuff:AddClickListener(slot0._btnbuffOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnjump:RemoveClickListener()
	slot0._btndetail:RemoveClickListener()
	slot0._btnbuff:RemoveClickListener()
end

function slot0._btnbuffOnClick(slot0)
	WeekWalk_2Controller.instance:openWeekWalk_2HeartBuffView()
end

function slot0._btnjumpOnClick(slot0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk) then
		GameFacade.showToast(ToastEnum.ActivityWeekWalkDeepShowView)

		return
	end

	WeekWalk_2Controller.instance:jumpWeekWalkHeartLayerView(slot0._jumpCallback, slot0)
end

function slot0._jumpCallback(slot0)
	TaskDispatcher.cancelTask(slot0._closeBeginnerView, slot0)
	TaskDispatcher.runDelay(slot0._closeBeginnerView, slot0, 1)
end

function slot0._closeBeginnerView(slot0)
	ViewMgr.instance:closeView(ViewName.ActivityBeginnerView)
end

function slot0._btndetailOnClick(slot0)
	if not slot0:_isWeekWalkDeepOpen() then
		GameFacade.showToast(ToastEnum.WeekWalkDetail)

		return
	end

	WeekWalk_2Controller.instance:openWeekWalk_2RuleView()
	gohelper.setActive(slot0._gonewrule, false)
	slot0:_setIsClickRuleBtnData(uv0.HasClickRuleBtn)
end

function slot0._editableInitView(slot0)
	slot0._animView = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._rewardItems = slot0:getUserDataTb_()

	gohelper.setActive(slot0._gorewarditem, false)
	slot0:_refreshNewRuleIcon()
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		ActivityEnum.Activity.WeekWalkHeartShow
	})
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._animView:Play(UIAnimationName.Open, 0, 0)

	slot0._actId = slot0.viewContainer.activityId

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0._config = ActivityConfig.instance:getActivityShowTaskList(slot0._actId, 1)
	slot0._txtdesc.text = slot0._config.actDesc

	slot0:_refreshRewards()

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk) then
		slot0:_showDeadline()
		slot0:_refreshProgress()
	else
		slot0._txttime.text = luaLang("activityweekwalkdeepview_lcok")
		slot0._txtprogress.text = luaLang("activityweekwalkdeepview_empty")
	end
end

function slot0._isWeekWalkDeepOpen(slot0)
	return OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk) and WeekWalk_2Model.instance:getInfo():isOpen()
end

slot0.ShowCount = 1

function slot0._refreshRewards(slot0)
	slot2 = nil

	for slot6, slot7 in ipairs(WeekWalk_2DeepLayerNoticeView._getRewardList()) do
		slot9 = slot7[2]

		if slot7[1] == 2 and slot9 == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
			slot2 = string.format("%s#%s#%s#1", slot8, slot9, slot7[3])

			break
		end
	end

	if slot2 then
		slot3 = string.format("%s|%s", slot2, slot0._config.showBonus)
	end

	for slot8 = 1, #string.split(slot3, "|") do
		if not slot0._rewardItems[slot8] then
			slot9 = slot0:getUserDataTb_()
			slot9.go = gohelper.clone(slot0._gorewarditem, slot0._gorewardContent, "rewarditem" .. slot8)
			slot9.item = IconMgr.instance:getCommonPropItemIcon(slot9.go)

			table.insert(slot0._rewardItems, slot9)
		end

		gohelper.setActive(slot0._rewardItems[slot8].go, true)

		slot10 = string.splitToNumber(slot4[slot8], "#")

		slot0._rewardItems[slot8].item:setMOValue(slot10[1], slot10[2], slot10[3])
		slot0._rewardItems[slot8].item:isShowCount(slot10[4] == uv0.ShowCount)
		slot0._rewardItems[slot8].item:setCountFontSize(35)
		slot0._rewardItems[slot8].item:setHideLvAndBreakFlag(true)
		slot0._rewardItems[slot8].item:hideEquipLvAndBreak(true)
	end

	for slot8 = #slot4 + 1, #slot0._rewardItems do
		gohelper.setActive(slot0._rewardItems[slot8].go, false)
	end
end

function slot0._refreshProgress(slot0)
	slot4 = nil

	if WeekWalkModel.isShallowMap(WeekWalkModel.instance:getInfo():getNotFinishedMap().sceneId) or not WeekWalk_2Model.instance:getInfo():isOpen() then
		slot4 = luaLang("activityweekwalkdeepview_empty")
	else
		gohelper.setActive(slot0._goprogress, true)

		slot7 = WeekWalk_2Model.instance:getInfo():getNotFinishedMap().sceneConfig
		slot4 = string.format("%s%s", slot7.name, slot7.battleName)
	end

	slot0._txtprogress.text = slot4
end

function slot0._showDeadline(slot0)
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)

	if not WeekWalk_2Model.instance:getInfo():isOpen() then
		slot0._txttime.text = luaLang("activityweekwalkdeepview_lcok")

		return
	end

	slot0._endTime = WeekWalk_2Model.instance:getInfo().endTime

	TaskDispatcher.runRepeat(slot0._onRefreshDeadline, slot0, 1)
	slot0:_onRefreshDeadline()
end

function slot0._onRefreshDeadline(slot0)
	if slot0._endTime - ServerTime.now() <= 0 then
		TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
	end

	slot2, slot3 = TimeUtil.secondToRoughTime2(math.floor(slot1))
	slot0._txttime.text = formatLuaLang("activityweekwalkdeepview_resetremaintime", slot2 .. slot3)
end

function slot0._refreshNewRuleIcon(slot0)
	slot1 = ActivityModel.instance:getActMO(ActivityEnum.Activity.WeekWalkHeartShow).isNewStage
	slot3 = false

	if slot0:_isWeekWalkDeepOpen() then
		slot3 = slot1 or not slot0:_checkIsClickRuleBtn()
	end

	if slot1 then
		slot0:_setIsClickRuleBtnData(uv0.UnClickRuleBtn)
	end

	gohelper.setActive(slot0._gonewrule, slot3)
end

slot1 = PlayerPrefsKey.EnteredActKey .. "#" .. tostring(ActivityEnum.Activity.WeekWalkHeartShow) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)

function slot0._checkIsClickRuleBtn(slot0)
	return tonumber(PlayerPrefsHelper.getNumber(uv0, uv1.UnClickRuleBtn)) ~= uv1.UnClickRuleBtn
end

slot0.HasClickRuleBtn = 1
slot0.UnClickRuleBtn = 0

function slot0._setIsClickRuleBtnData(slot0, slot1)
	PlayerPrefsHelper.setNumber(uv0, tonumber(slot1) or uv1.UnClickRuleBtn)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
	TaskDispatcher.cancelTask(slot0._closeBeginnerView, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
end

return slot0
