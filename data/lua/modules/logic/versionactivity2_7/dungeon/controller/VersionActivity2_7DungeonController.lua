module("modules.logic.versionactivity2_7.dungeon.controller.VersionActivity2_7DungeonController", package.seeall)

slot0 = class("VersionActivity2_7DungeonController", VersionActivityFixedDungeonController)

function slot0.onInit(slot0)
	slot0._isShowLoading = false
end

function slot0.reInit(slot0)
	slot0._isShowLoading = false
end

function slot0.openVersionActivityDungeonMapView(slot0, slot1, slot2, slot3, slot4)
	uv0.super.openVersionActivityDungeonMapView(slot0, slot1, slot2, slot3, slot4)

	if slot0:_isSpaceScene(slot2) then
		slot0:showLoading()
	end
end

function slot0._isSpaceScene(slot0, slot1)
	for slot7, slot8 in ipairs(VersionActivity2_7DungeonEnum.SpaceSceneEpisodeIndexs) do
		if DungeonConfig.instance:getEpisodeLevelIndexByEpisodeId(slot1 or VersionActivityFixedDungeonModel.instance:getInitEpisodeId()) == slot8 then
			return true
		end
	end
end

function slot0.loadingFinish(slot0, slot1)
	if slot0:_isSpaceScene(slot1) or slot0._isShowLoading then
		slot0:hideLoading()
	end
end

function slot0.showLoading(slot0)
	slot0._isShowLoading = true
end

function slot0.hideLoading(slot0)
	slot0._isShowLoading = false
end

slot0.instance = slot0.New()

return slot0
