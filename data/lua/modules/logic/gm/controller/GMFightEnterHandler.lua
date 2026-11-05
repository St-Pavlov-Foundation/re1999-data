-- chunkname: @modules/logic/gm/controller/GMFightEnterHandler.lua

module("modules.logic.gm.controller.GMFightEnterHandler", package.seeall)

local GMFightEnterHandler = class("GMFightEnterHandler")

GMFightEnterHandler.EpisodeEnterDict = {
	[DungeonEnum.EpisodeType.Abyss] = 1
}

function GMFightEnterHandler.defaultEnterFight(episodeId, episodeConfig)
	return
end

function GMFightEnterHandler.abyssEnterFight(episodeId, episodeConfig)
	AbyssController.instance:enterFightByEpisodeIdGM(episodeId)
end

GMFightEnterHandler.getEnterHandleFunc = {
	[DungeonEnum.EpisodeType.Abyss] = GMFightEnterHandler.abyssEnterFight
}

function GMFightEnterHandler.enterFight(episodeId)
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeConfig then
		return
	end

	local episodeType = episodeConfig.type
	local func = GMFightEnterHandler.getEnterHandleFunc[episodeType]

	if func then
		func(episodeId, episodeConfig)
	else
		GMFightEnterHandler.defaultEnterFight(episodeId, episodeConfig)
	end
end

function GMFightEnterHandler.defaultGetEpisodeList(episodeType)
	local list = {}

	for _, episodeConfig in ipairs(lua_episode.configList) do
		if episodeConfig.type == episodeType then
			table.insert(list, episodeConfig)
		end
	end

	return list
end

function GMFightEnterHandler.abyssGetEpisodeList(episodeType)
	local list = {}

	for _, cfg in ipairs(lua_activity229_episode.configList) do
		local episodeConfig = lua_episode.configDict[cfg.episodeId]

		if episodeConfig then
			table.insert(list, episodeConfig)
		end
	end

	return list
end

GMFightEnterHandler.getEpisodeHandleFunc = {
	[DungeonEnum.EpisodeType.Abyss] = GMFightEnterHandler.abyssGetEpisodeList
}

function GMFightEnterHandler.getEpisodeList(episodeType)
	local func = GMFightEnterHandler.getEpisodeHandleFunc[episodeType]

	if func then
		return func(episodeType)
	end

	return GMFightEnterHandler.defaultGetEpisodeList(episodeType)
end

return GMFightEnterHandler
