module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonSelectBadgeComp", package.seeall)

slot0 = class("Act183DungeonSelectBadgeComp", Act183DungeonBaseComp)
slot1 = {
	610,
	-416
}
slot2 = {
	395,
	-416
}
slot3 = {
	394.33,
	-416
}

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._gobadgeitem = gohelper.findChild(slot0.go, "#go_badges/#go_badgeitem")
	slot0._btnresetbadge = gohelper.findChildButtonWithAudio(slot0.go, "#go_badges/#btn_resetbadge")
	slot0._btnclosebadge = gohelper.findChildButtonWithAudio(slot0.go, "#btn_closebadge")
	slot0._badgeItemTab = slot0:getUserDataTb_()

	slot0:addEventCb(Act183Controller.instance, Act183Event.OnUpdateBadgeDetailVisible, slot0._onUpdateBadgeDetailVisible, slot0)
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(Act183Controller.instance, Act183Event.OnUpdateSelectBadgeNum, slot0._onUpdateSelectBadgeNum, slot0)
	slot0._btnresetbadge:AddClickListener(slot0._btnresetbadgeOnClick, slot0)
	slot0._btnclosebadge:AddClickListener(slot0._btnclosebadgeOnClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnresetbadge:RemoveClickListener()
	slot0._btnclosebadge:RemoveClickListener()
end

function slot0.updateInfo(slot0, slot1)
	uv0.super.updateInfo(slot0, slot1)

	slot0._baseRules = Act183Config.instance:getEpisodeAllRuleDesc(slot0._episodeId)
	slot0._useBadgeNum = slot0._episodeMo:getUseBadgeNum()
	slot0._readyUseBadgeNum = slot0._useBadgeNum or 0
	slot0._totalBadgeNum = Act183Model.instance:getActInfo() and slot2:getBadgeNum() or 0
	slot0._isVisibe = false
end

function slot0.checkIsVisible(slot0)
	return slot0._isVisibe
end

function slot0.show(slot0)
	uv0.super.show(slot0)
	slot0:createObjListNum(slot0._totalBadgeNum, slot0._badgeItemTab, slot0._gobadgeitem, slot0._initBadgeItemFunc, slot0._refreshBadgeItemFunc, slot0._defaultItemFreeFunc)
	slot0:_setPosition()
end

function slot0._setPosition(slot0)
	slot1 = uv0

	if slot0.mgr:isCompVisible(Act183DungeonRestartBtnComp) then
		slot1 = slot0.mgr:isCompVisible(Act183DungeonRepressBtnComp) and uv1 or uv2
	end

	recthelper.setAnchor(slot0.tran, slot1[1], slot1[2])
end

function slot0._initBadgeItemFunc(slot0, slot1, slot2)
	slot1.imageicon = gohelper.findChildImage(slot1.go, "image_icon")
	slot1.btnclick = gohelper.findChildButtonWithAudio(slot1.go, "btn_click")

	slot1.btnclick:AddClickListener(slot0._onClickBadgeItem, slot0, slot2)
end

function slot0._refreshBadgeItemFunc(slot0, slot1, slot2, slot3)
	UISpriteSetMgr.instance:setChallengeSprite(slot1.imageicon, slot3 <= slot0._readyUseBadgeNum and "v2a5_challenge_badge1" or "v2a5_challenge_badge2")
end

function slot0._releaseBadgeItems(slot0)
	for slot4, slot5 in pairs(slot0._badgeItemTab) do
		slot5.btnclick:RemoveClickListener()
	end
end

function slot0._onClickBadgeItem(slot0, slot1)
	if slot0._readyUseBadgeNum == slot1 then
		return
	end

	slot0._readyUseBadgeNum = slot1

	Act183Controller.instance:dispatchEvent(Act183Event.OnUpdateSelectBadgeNum, slot0._episodeId, slot0._readyUseBadgeNum)
end

function slot0._btnresetbadgeOnClick(slot0)
	if slot0._readyUseBadgeNum == 0 then
		return
	end

	slot0._readyUseBadgeNum = 0

	Act183Controller.instance:dispatchEvent(Act183Event.OnUpdateSelectBadgeNum, slot0._episodeId, slot0._readyUseBadgeNum)
end

function slot0._btnclosebadgeOnClick(slot0)
	Act183Controller.instance:dispatchEvent(Act183Event.OnUpdateBadgeDetailVisible, false, slot0._readyUseBadgeNum)
end

function slot0._onUpdateSelectBadgeNum(slot0, slot1, slot2)
	if slot0._episodeId ~= slot1 or not slot0._isVisibe then
		return
	end

	slot0._readyUseBadgeNum = slot2

	slot0:refresh()
end

function slot0.getReadyUseBadgeNum(slot0)
	return slot0._readyUseBadgeNum or 0
end

function slot0._onUpdateBadgeDetailVisible(slot0, slot1, slot2)
	slot0._isVisibe = slot1
	slot0._readyUseBadgeNum = slot2 or 0

	slot0:refresh()
end

function slot0.onDestroy(slot0)
	slot0:_releaseBadgeItems()
	uv0.super.onDestroy(slot0)
end

return slot0
