module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonBadgeBtnComp", package.seeall)

slot0 = class("Act183DungeonBadgeBtnComp", Act183DungeonBaseComp)
slot1 = {
	660,
	-416
}
slot2 = {
	445,
	-416
}
slot3 = {
	445,
	-416
}

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._btnbadge = gohelper.getClickWithDefaultAudio(slot0.go)
	slot0._imagebadgebtn = gohelper.onceAddComponent(slot0.go, gohelper.Type_Image)
	slot0._txtusebadgenum = gohelper.findChildText(slot0.go, "#txt_usebadgenum")
	slot0._readyUseBadgeNum = 0
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(Act183Controller.instance, Act183Event.OnUpdateSelectBadgeNum, slot0._onUpdateSelectBadgeNum, slot0)
	slot0._btnbadge:AddClickListener(slot0._btnbadgeOnClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnbadge:RemoveClickListener()
end

function slot0._btnbadgeOnClick(slot0)
	Act183Controller.instance:dispatchEvent(Act183Event.OnUpdateBadgeDetailVisible, true, slot0._readyUseBadgeNum)
end

function slot0.updateInfo(slot0, slot1)
	uv0.super.updateInfo(slot0, slot1)

	slot0._totalBadgeNum = Act183Model.instance:getActInfo() and slot2:getBadgeNum() or 0
	slot0._useBadgeNum = slot0._episodeMo:getUseBadgeNum()
	slot0._readyUseBadgeNum = slot0._useBadgeNum or 0
end

function slot0.checkIsVisible(slot0)
	return slot0._status ~= Act183Enum.EpisodeStatus.Locked and slot0._totalBadgeNum > 0 and slot0._groupType == Act183Enum.GroupType.NormalMain
end

function slot0.show(slot0)
	uv0.super.show(slot0)

	slot1 = uv1

	if slot0.mgr:isCompVisible(Act183DungeonRestartBtnComp) then
		slot1 = slot0.mgr:isCompVisible(Act183DungeonRepressBtnComp) and uv2 or uv3
	end

	recthelper.setAnchor(slot0.tran, slot1[1], slot1[2])
	slot0:_refreshBadgeNum()
end

function slot0._refreshBadgeNum(slot0)
	slot1 = slot0._readyUseBadgeNum and slot0._readyUseBadgeNum > 0

	gohelper.setActive(slot0._txtusebadgenum.gameObject, slot1)

	slot0._txtusebadgenum.text = slot0._readyUseBadgeNum

	UISpriteSetMgr.instance:setChallengeSprite(slot0._imagebadgebtn, slot1 and "v2a5_challenge_dungeon_iconbtn2" or "v2a5_challenge_dungeon_iconbtn1")
end

function slot0._onUpdateSelectBadgeNum(slot0, slot1, slot2)
	if slot0._episodeId ~= slot1 then
		return
	end

	slot0._readyUseBadgeNum = slot2 or 0

	slot0:refresh()
end

function slot0.onDestroy(slot0)
	uv0.super.onDestroy(slot0)
end

return slot0
