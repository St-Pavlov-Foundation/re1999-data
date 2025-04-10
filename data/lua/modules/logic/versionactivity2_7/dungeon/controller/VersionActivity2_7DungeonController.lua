module("modules.logic.versionactivity2_7.dungeon.controller.VersionActivity2_7DungeonController", package.seeall)

slot0 = class("VersionActivity2_7DungeonController", VersionActivityFixedDungeonController)

function slot0.onInit(slot0)
	slot0._isShowLoading = false
	slot0._sceneGo = nil
end

function slot0.reInit(slot0)
	slot0._isShowLoading = false
	slot0._sceneGo = nil
end

function slot0.openVersionActivityDungeonMapView(slot0, slot1, slot2, slot3, slot4)
	uv0.super.openVersionActivityDungeonMapView(slot0, slot1, slot2, slot3, slot4)

	if slot0:_isSpaceScene(slot2) and not slot0._sceneGo then
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

function slot0.loadingFinish(slot0, slot1, slot2)
	if slot0:_isSpaceScene(slot1) or slot0._isShowLoading then
		slot0:hideLoading()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_loading_scene)

	slot0._sceneGo = slot2
end

function slot0.showLoading(slot0)
	ViewMgr.instance:openView(ViewName.V2a7LoadingSpaceView, nil, true)

	slot0._isShowLoading = true
end

function slot0.hideLoading(slot0)
	if ViewMgr.instance:isOpen(ViewName.V2a7LoadingSpaceView) then
		ViewMgr.instance:closeView(ViewName.V2a7LoadingSpaceView)
	end

	slot0._isShowLoading = false
end

function slot0.resetLoading(slot0)
	slot0._isShowLoading = false
	slot0._sceneGo = nil
end

slot0.instance = slot0.New()

return slot0
