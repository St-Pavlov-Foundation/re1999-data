module("modules.logic.versionactivity2_4.enter.view.VersionActivity2_4EnterView", package.seeall)

slot0 = class("VersionActivity2_4EnterView", VersionActivityEnterBaseViewWithListNew)
slot1 = 2.1

function slot0._editableInitView(slot0)
	slot0._scrolltab = gohelper.findChildScrollRect(slot0.viewGO, "#go_tabcontainer/#scroll_tab")
	slot0.goArrowRedDot = gohelper.findChild(slot0.viewGO, "#go_tabcontainer/#scroll_tab/arrow/#go_arrowreddot")
	slot0.viewPortHeight = recthelper.getHeight(gohelper.findChildComponent(slot0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport", gohelper.Type_RectTransform))
	slot0.rectTrContent = gohelper.findChildComponent(slot0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content", gohelper.Type_RectTransform)
	slot0._gotabitem1 = gohelper.findChild(slot0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem1")
	slot0._gotabitem2 = gohelper.findChild(slot0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem2")
	slot0._goline = gohelper.findChild(slot0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_line")

	slot0:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.First, slot0._gotabitem1, VersionActivity2_4EnterViewTabItem1)
	slot0:setTabLevelSetting(VersionActivityEnterViewEnum.ActLevel.Second, slot0._gotabitem2, VersionActivity2_4EnterViewTabItem2)
	slot0:setActivityLineGo(slot0._goline)

	slot0._btnreplay = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_replay")
	slot0._btnachievementnormal = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_achievement_normal")
	slot0._btnachievementpreview = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_achievementpreview")
	slot0.goReplayBtn = slot0._btnreplay.gameObject
	slot0.goAchievementBtn = slot0._btnachievementpreview.gameObject
	slot0.viewAnim = slot0.viewGO:GetComponent(gohelper.Type_Animator)
	slot0.gosubviewCanvasGroup = gohelper.findChildComponent(slot0.viewGO, "#go_subview", gohelper.Type_CanvasGroup)
end

function slot0.childAddEvents(slot0)
	slot0._btnreplay:AddClickListener(slot0._btnreplayOnClick, slot0)
	slot0._btnachievementnormal:AddClickListener(slot0._btnachievementpreviewOnClick, slot0)
	slot0._btnachievementpreview:AddClickListener(slot0._btnachievementpreviewOnClick, slot0)
	slot0._scrolltab:AddOnValueChanged(slot0._onTabScrollChange, slot0)
	slot0:addEventCb(RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, slot0.refreshRedDot, slot0, LuaEventSystem.Low)
end

function slot0.childRemoveEvents(slot0)
	slot0._btnreplay:RemoveClickListener()
	slot0._btnachievementnormal:RemoveClickListener()
	slot0._btnachievementpreview:RemoveClickListener()
	slot0._scrolltab:RemoveOnValueChanged()
	slot0:removeEventCb(RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, slot0.refreshRedDot, slot0)
end

function slot0._btnreplayOnClick(slot0)
	if not ActivityModel.instance:getActMO(slot0.curActId) or not slot1.config or not slot1.config.storyId or slot2 == 0 then
		logError(string.format("act id %s dot config story id", slot0.curActId))

		return
	end

	StoryController.instance:playStory(slot2, {
		isVersionActivityPV = true
	})
end

function slot0._btnachievementpreviewOnClick(slot0)
	JumpController.instance:jump(ActivityConfig.instance:getActivityCo(slot0.curActId) and slot1.achievementJumpId)
end

function slot0._onTabScrollChange(slot0)
	for slot5, slot6 in ipairs(slot0.activityTabItemList) do
		if slot6:isShowRedDot() and slot0.viewPortHeight < -slot6:getAnchorY() + VersionActivity2_4Enum.RedDotOffsetY - recthelper.getAnchorY(slot0.rectTrContent) then
			gohelper.setActive(slot0.goArrowRedDot, true)

			return
		end
	end

	gohelper.setActive(slot0.goArrowRedDot, false)
end

function slot0.refreshRedDot(slot0)
	slot0:_onTabScrollChange()
end

function slot0.refreshBtnVisible(slot0, slot1)
	slot3 = VersionActivity2_4EnterHelper.GetIsShowAchievementBtn(slot0.curActId)

	gohelper.setActive(slot0.goReplayBtn, VersionActivity2_4EnterHelper.GetIsShowReplayBtn(slot0.curActId))
	gohelper.setActive(slot0.goAchievementBtn, slot3)
	gohelper.setActive(slot0._btnachievementnormal, slot3)

	if slot1 then
		return
	end
end

function slot0.onOpen(slot0)
	uv0.super.onOpen(slot0)

	if slot0.curActId == VersionActivity2_4Enum.ActivityId.Dungeon then
		slot0.viewAnim:Play("open1", 0, 0)
	else
		slot0.viewAnim:Play(UIAnimationName.Open, 0, 0)
		slot0.viewContainer:markPlayedSubViewAnim()
	end
end

return slot0
