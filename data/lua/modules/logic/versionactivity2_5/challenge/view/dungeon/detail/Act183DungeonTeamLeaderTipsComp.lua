module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonTeamLeaderTipsComp", package.seeall)

slot0 = class("Act183DungeonTeamLeaderTipsComp", Act183DungeonBaseComp)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._txtleadertips = gohelper.findChildText(slot0.go, "txt_LeaderTips")

	SkillHelper.addHyperLinkClick(slot0._txtleadertips.gameObject)
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.checkIsVisible(slot0)
	return Act183Helper.isEpisodeHasTeamLeader(slot0._episodeId)
end

function slot0.show(slot0)
	uv0.super.show(slot0)
	slot0:refreshLeaderTips()
end

function slot0.refreshLeaderTips(slot0)
	slot0._txtleadertips.text = SkillHelper.buildDesc(Act183Config.instance:getLeaderSkillDesc(slot0._episodeId))
end

function slot0.onDestroy(slot0)
	uv0.super.onDestroy(slot0)
end

return slot0
