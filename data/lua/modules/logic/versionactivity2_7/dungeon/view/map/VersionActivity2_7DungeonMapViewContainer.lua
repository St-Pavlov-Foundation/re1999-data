module("modules.logic.versionactivity2_7.dungeon.view.map.VersionActivity2_7DungeonMapViewContainer", package.seeall)

slot0 = class("VersionActivity2_7DungeonMapViewContainer", VersionActivityFixedDungeonMapViewContainer)

function slot0.buildViews(slot0)
	slot0.mapScene = VersionActivity2_7DungeonMapScene.New()
	slot0.mapSceneElements = VersionActivityFixedHelper.getVersionActivityDungeonMapSceneElements().New()
	slot0.mapView = VersionActivityFixedHelper.getVersionActivityDungeonMapView().New()
	slot0.mapEpisodeView = VersionActivityFixedHelper.getVersionActivityDungeonMapEpisodeView().New()
	slot0.interactView = VersionActivityFixedHelper.getVersionActivityDungeonMapInteractView().New()
	slot0.mapElementReward = DungeonMapElementReward.New()

	return {
		VersionActivityFixedHelper.getVersionActivityDungeonMapHoleView().New(),
		slot0.mapScene,
		slot0.mapSceneElements,
		slot0.mapView,
		slot0.mapEpisodeView,
		slot0.interactView,
		slot0.mapElementReward,
		TabViewGroup.New(1, "#go_topleft")
	}
end

return slot0
