module("modules.logic.gm.view.GM_VersionActivity2_1DungeonMapView", package.seeall)

slot0 = class("GM_VersionActivity2_1DungeonMapView", GM_VersionActivity_DungeonMapView)

function slot0.register()
	GM_VersionActivity_DungeonMapView.VersionActivityX_XDungeonMapView_register(VersionActivity2_1DungeonMapView)
	GM_VersionActivity_DungeonMapView.VersionActivityX_XMapEpisodeItem_register(VersionActivity2_1DungeonMapEpisodeItem)
	GM_VersionActivity_DungeonMapView.VersionActivityX_XDungeonMapLevelView_register(VersionActivity2_1DungeonMapLevelView, 2, 1)
end

return slot0
