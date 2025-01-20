module("modules.logic.versionactivity.view.VersionActivityDungeonMapLevelView", package.seeall)

slot0 = class("VersionActivityDungeonMapLevelView", VersionActivityDungeonBaseMapLevelView)

function slot0.getEpisodeIndex(slot0)
	if ActivityConfig.instance:getChapterIdMode(slot0.originEpisodeConfig.chapterId) == VersionActivityDungeonBaseEnum.DungeonMode.Hard then
		return uv0.super.getEpisodeIndex(slot0)
	end

	return DungeonConfig.instance:getEpisodeLevelIndex(DungeonConfig.instance:getVersionActivityBrotherEpisodeByEpisodeCo(slot0.originEpisodeConfig)[1])
end

return slot0
