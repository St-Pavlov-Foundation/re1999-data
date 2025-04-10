module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonStartBtnComp", package.seeall)

slot0 = class("Act183DungeonStartBtnComp", Act183DungeonBaseComp)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._btnstart = gohelper.getClickWithDefaultAudio(slot0.go)
end

function slot0.addEventListeners(slot0)
	slot0._btnstart:AddClickListener(slot0._btnstartOnClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnstart:RemoveClickListener()
end

function slot0._btnstartOnClick(slot0)
	Act183HeroGroupController.instance:enterFight(slot0._episodeId, slot0.mgr:getFuncValue(Act183DungeonSelectBadgeComp, "getReadyUseBadgeNum"), slot0.mgr:getFuncValue(Act183DungeonRewardRuleComp, "getSelectConditionMap"))
end

function slot0.checkIsVisible(slot0)
	return slot0._status == Act183Enum.EpisodeStatus.Unlocked
end

function slot0.show(slot0)
	uv0.super.show(slot0)
end

function slot0.onDestroy(slot0)
	uv0.super.onDestroy(slot0)
end

return slot0
