module("modules.logic.versionactivity.view.VersionActivityDungeonMapLevelView", package.seeall)

local var_0_0 = class("VersionActivityDungeonMapLevelView", VersionActivityDungeonBaseMapLevelView)

function var_0_0.getEpisodeIndex(arg_1_0)
	if ActivityConfig.instance:getChapterIdMode(arg_1_0.originEpisodeConfig.chapterId) == VersionActivityDungeonBaseEnum.DungeonMode.Hard then
		return var_0_0.super.getEpisodeIndex(arg_1_0)
	end

	local var_1_0 = DungeonConfig.instance:getVersionActivityBrotherEpisodeByEpisodeCo(arg_1_0.originEpisodeConfig)

	return DungeonConfig.instance:getEpisodeLevelIndex(var_1_0[1])
end

return var_0_0
