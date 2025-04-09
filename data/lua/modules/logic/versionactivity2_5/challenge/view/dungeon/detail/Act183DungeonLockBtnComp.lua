module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonLockBtnComp", package.seeall)

slot0 = class("Act183DungeonLockBtnComp", Act183DungeonBaseComp)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.checkIsVisible(slot0)
	return slot0._status == Act183Enum.EpisodeStatus.Locked
end

function slot0.show(slot0)
	uv0.super.show(slot0)
end

function slot0.onDestroy(slot0)
	uv0.super.onDestroy(slot0)
end

return slot0
