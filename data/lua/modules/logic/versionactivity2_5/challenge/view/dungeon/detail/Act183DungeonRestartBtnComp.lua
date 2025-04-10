module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonRestartBtnComp", package.seeall)

slot0 = class("Act183DungeonRestartBtnComp", Act183DungeonBaseComp)
slot1 = {
	785,
	-425,
	340,
	104
}
slot2 = {
	697,
	-425,
	560,
	104
}

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._btnrestart = gohelper.getClickWithDefaultAudio(slot0.go)
end

function slot0.addEventListeners(slot0)
	slot0._btnrestart:AddClickListener(slot0._btnrestartOnClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnrestart:RemoveClickListener()
end

function slot0.updateInfo(slot0, slot1)
	uv0.super.updateInfo(slot0, slot1)

	slot0._isCanRestart = slot0._groupEpisodeMo:isEpisodeCanRestart(slot0._episodeId)
end

function slot0._btnrestartOnClick(slot0)
	Act183HeroGroupController.instance:enterFight(slot0._episodeId, slot0.mgr:getFuncValue(Act183DungeonSelectBadgeComp, "getReadyUseBadgeNum"), slot0.mgr:getFuncValue(Act183DungeonRewardRuleComp, "getSelectConditionMap"))
end

function slot0.checkIsVisible(slot0)
	return slot0._isCanRestart
end

function slot0.show(slot0)
	uv0.super.show(slot0)
	slot0:_setPosition()
end

function slot0._setPosition(slot0)
	slot2 = slot0.mgr:isCompVisible(Act183DungeonRepressBtnComp) and uv0 or uv1

	recthelper.setSize(slot0._btnrestart.transform, slot2[3], slot2[4])
	recthelper.setAnchor(slot0._btnrestart.transform, slot2[1], slot2[2])
end

function slot0.onDestroy(slot0)
	uv0.super.onDestroy(slot0)
end

return slot0
