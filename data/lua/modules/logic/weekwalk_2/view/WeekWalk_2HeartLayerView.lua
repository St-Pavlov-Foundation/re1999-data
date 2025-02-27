module("modules.logic.weekwalk_2.view.WeekWalk_2HeartLayerView", package.seeall)

slot0 = class("WeekWalk_2HeartLayerView", BaseView)

function slot0.onInitView(slot0)
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_content")
	slot0._goheart = gohelper.findChild(slot0.viewGO, "bottom_left/#go_heart")
	slot0._gocountdown = gohelper.findChild(slot0.viewGO, "bottom_left/#go_heart/#go_countdown")
	slot0._txtcountday = gohelper.findChildText(slot0.viewGO, "bottom_left/#go_heart/#go_countdown/bg/#txt_countday")
	slot0._goexcept = gohelper.findChild(slot0.viewGO, "bottom_left/#go_heart/#go_except")
	slot0._btnreward = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottom_left/#go_heart/#btn_reward")
	slot0._gobubble = gohelper.findChild(slot0.viewGO, "bottom_left/#go_heart/#btn_reward/#go_bubble")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "bottom_left/#go_heart/#btn_reward/#go_bubble/#simage_icon")
	slot0._goruleIcon = gohelper.findChild(slot0.viewGO, "#go_ruleIcon")
	slot0._btnruleIcon = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ruleIcon/#btn_ruleIcon")
	slot0._gorulenew = gohelper.findChild(slot0.viewGO, "#go_ruleIcon/#go_rulenew")
	slot0._gobuffIcon = gohelper.findChild(slot0.viewGO, "#go_buffIcon")
	slot0._btnbuffIcon = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_buffIcon/#btn_buffIcon")
	slot0._gobuffnew = gohelper.findChild(slot0.viewGO, "#go_buffIcon/#go_buffnew")
	slot0._goreviewIcon = gohelper.findChild(slot0.viewGO, "#go_reviewIcon")
	slot0._btnreviewIcon = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_reviewIcon/#btn_reviewIcon")
	slot0._txtdetaildesc = gohelper.findChildText(slot0.viewGO, "bottom_right/#txt_detaildesc")
	slot0._goitem = gohelper.findChild(slot0.viewGO, "bottom_right/badgelist/#go_item")
	slot0._simagebgimgnext = gohelper.findChildSingleImage(slot0.viewGO, "transition/ani/#simage_bgimg_next")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnreward:AddClickListener(slot0._btnrewardOnClick, slot0)
	slot0._btnruleIcon:AddClickListener(slot0._btnruleIconOnClick, slot0)
	slot0._btnbuffIcon:AddClickListener(slot0._btnbuffIconOnClick, slot0)
	slot0._btnreviewIcon:AddClickListener(slot0._btnreviewIconOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnreward:RemoveClickListener()
	slot0._btnruleIcon:RemoveClickListener()
	slot0._btnbuffIcon:RemoveClickListener()
	slot0._btnreviewIcon:RemoveClickListener()
end

function slot0._btnrewardOnClick(slot0)
	WeekWalk_2Controller.instance:openWeekWalk_2LayerRewardView({
		mapId = 0
	})
end

function slot0._btnreviewIconOnClick(slot0)
	Weekwalk_2Rpc.instance:sendWeekwalkVer2GetSettleInfoRequest()
end

function slot0._btnruleIconOnClick(slot0)
	WeekWalk_2Controller.instance:openWeekWalk_2RuleView()
end

function slot0._btnbuffIconOnClick(slot0)
	WeekWalk_2Controller.instance:openWeekWalk_2HeartBuffView()
end

function slot0._editableInitView(slot0)
	slot0._rewardAnimator = slot0._btnreward.gameObject:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(slot0._goitem, false)
	slot0:_initPage()
end

function slot0._initItemList(slot0)
	if slot0._itemList then
		return
	end

	slot0._itemList = slot0:getUserDataTb_()

	for slot4 = 1, WeekWalk_2Enum.MaxLayer do
		slot5 = gohelper.cloneInPlace(slot0._goitem)

		gohelper.setActive(slot5, true)

		slot6 = gohelper.findChildImage(slot5, "badgelayout/1/icon")
		slot7 = gohelper.findChildImage(slot5, "badgelayout/2/icon")
		slot8 = gohelper.findChildText(slot5, "chapternum")
		slot8.text = slot4
		slot6.enabled = false
		slot7.enabled = false
		slot0._itemList[slot4] = {
			icon1Effect = slot0:getResInst(slot0.viewContainer._viewSetting.otherRes.weekwalkheart_star, slot6.gameObject),
			icon2Effect = slot0:getResInst(slot0.viewContainer._viewSetting.otherRes.weekwalkheart_star, slot7.gameObject),
			txt = slot8
		}
	end

	slot0:_updateItemList()
end

function slot0._updateItemList(slot0)
	for slot4 = 1, WeekWalk_2Enum.MaxLayer do
		slot5 = slot0._itemList[slot4]
		slot7 = slot5.icon2Effect
		slot8 = slot0._info:getLayerInfoByLayerIndex(slot4)
		slot10 = slot8:getBattleInfo(WeekWalk_2Enum.BattleIndex.Second)

		if slot8:getBattleInfo(WeekWalk_2Enum.BattleIndex.First) then
			WeekWalk_2Helper.setCupEffectByResult(slot5.icon1Effect, slot9:getCupMaxResult() == WeekWalk_2Enum.CupType.Platinum and WeekWalk_2Enum.CupType.Platinum or WeekWalk_2Enum.CupType.None2)
		end

		if slot10 then
			WeekWalk_2Helper.setCupEffectByResult(slot7, slot10:getCupMaxResult() == WeekWalk_2Enum.CupType.Platinum and WeekWalk_2Enum.CupType.Platinum or WeekWalk_2Enum.CupType.None2)
		end
	end
end

function slot0._initPage(slot0)
	slot0._layerPage = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer._viewSetting.otherRes[1], slot0._gocontent), WeekWalk_2HeartLayerPage, slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnGetInfo, slot0._onGetInfo, slot0)
	slot0:addEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkInfoChange, slot0._onChangeInfo, slot0)
	slot0:addEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkTaskUpdate, slot0._onWeekwalk_2TaskUpdate, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:_showDeadline()
	slot0:_initItemList()
	slot0:_onWeekwalk_2TaskUpdate()
	slot0:_updateNewFlag()
end

function slot0.onOpenFinish(slot0)
	if not not WeekWalk_2Controller.hasOnceActionKey(WeekWalk_2Enum.OnceAnimType.ResultReview, slot0._info.timeId) then
		return
	end

	WeekWalk_2Controller.setOnceActionKey(WeekWalk_2Enum.OnceAnimType.ResultReview, slot1)

	if slot0._goreviewIcon:GetComponent(typeof(UnityEngine.Animator)) then
		slot3:Play("open", 0, 0)
	end
end

function slot0._updateNewFlag(slot0)
	slot1 = slot0._info.timeId

	gohelper.setActive(slot0._gorulenew, not WeekWalk_2Controller.hasOnceActionKey(WeekWalk_2Enum.OnceAnimType.RuleNew, slot1))
	gohelper.setActive(slot0._gobuffnew, not WeekWalk_2Controller.hasOnceActionKey(WeekWalk_2Enum.OnceAnimType.BuffNew, slot1))
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == ViewName.WeekWalk_2HeartBuffView then
		WeekWalk_2Controller.setOnceActionKey(WeekWalk_2Enum.OnceAnimType.BuffNew, slot0._info.timeId)
		slot0:_updateNewFlag()
	elseif slot1 == ViewName.WeekWalk_2RuleView then
		WeekWalk_2Controller.setOnceActionKey(WeekWalk_2Enum.OnceAnimType.RuleNew, slot0._info.timeId)
		slot0:_updateNewFlag()
	end
end

function slot0._onWeekwalk_2TaskUpdate(slot0)
	slot2, slot3 = WeekWalk_2TaskListModel.instance:canGetRewardNum(WeekWalk_2Enum.TaskType.Once)

	gohelper.setActive(slot0._gobubble, true)

	slot0._gobubbleReddot = slot0._gobubbleReddot or gohelper.findChild(slot0.viewGO, "bottom_left/#go_heart/#btn_reward/reddot")

	gohelper.setActive(slot0._gobubbleReddot, slot2 > 0)

	if slot0._rewardAnimator then
		slot0._rewardAnimator:Play(slot4 and "reward" or "idle")
	end

	if slot2 == 0 and slot3 == 0 then
		gohelper.setActive(slot0._btnreward, false)
	end
end

function slot0._onChangeInfo(slot0)
	slot0:_updateItemList()
	slot0:_showReviewIcon()
end

function slot0._onGetInfo(slot0)
	slot0:_showDeadline()
end

function slot0._showDeadline(slot0)
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)

	slot0._info = WeekWalk_2Model.instance:getInfo()
	slot0._endTime = slot0._info.endTime

	TaskDispatcher.runRepeat(slot0._onRefreshDeadline, slot0, 1)
	slot0:_onRefreshDeadline()
	slot0:_showReviewIcon()
end

function slot0._showReviewIcon(slot0)
	gohelper.setActive(slot0._goreviewIcon, slot0._info:allLayerPass())
end

function slot0._onRefreshDeadline(slot0)
	if slot0._endTime - ServerTime.now() <= 0 then
		TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
	end

	slot3, slot4 = TimeUtil.secondToRoughTime2(math.floor(slot1))
	slot0._txtcountday.text = luaLang("p_dungeonweekwalkview_device") .. slot3 .. slot4
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
end

return slot0
