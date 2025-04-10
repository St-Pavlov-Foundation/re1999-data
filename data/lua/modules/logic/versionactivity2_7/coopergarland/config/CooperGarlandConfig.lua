module("modules.logic.versionactivity2_7.coopergarland.config.CooperGarlandConfig", package.seeall)

slot0 = class("CooperGarlandConfig", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"activity192_const",
		"activity192_episode",
		"activity192_task",
		"activity192_game",
		"activity192_map",
		"activity192_component_type"
	}
end

function slot0.onInit(slot0)
	slot0._actTaskDict = {}
	slot0._actEpisodeDict = {}
	slot0._map2ComponentList = {}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot0[string.format("%sConfigLoaded", slot1)] then
		slot4(slot0, slot2)
	end
end

function slot0.activity192_mapConfigLoaded(slot0, slot1)
	slot0._map2ComponentList = {}

	for slot5, slot6 in ipairs(slot1.configList) do
		if not slot0._map2ComponentList[slot6.mapId] then
			slot0._map2ComponentList[slot7] = {}
		end

		slot8[#slot8 + 1] = slot6.componentId
	end
end

function slot0.getAct192ConstCfg(slot0, slot1, slot2)
	if not lua_activity192_const.configDict[slot1] and slot2 then
		logError(string.format("CooperGarlandConfig:getAct192ConstCfg error, cfg is nil, constId:%s", slot1))
	end

	return slot3
end

function slot0.getAct192Const(slot0, slot1, slot2)
	slot3 = nil

	if slot0:getAct192ConstCfg(slot1, true) then
		if slot2 then
			slot3 = tonumber(slot4.value)
		end
	end

	return slot3
end

function slot0.getAct192EpisodeCfg(slot0, slot1, slot2, slot3)
	if not (lua_activity192_episode.configDict[slot1] and lua_activity192_episode.configDict[slot1][slot2]) and slot3 then
		logError(string.format("CooperGarlandConfig:getAct192EpisodeCfg error, cfg is nil, actId:%s, episodeId:%s", slot1, slot2))
	end

	return slot4
end

function slot0.getEpisodeIdList(slot0, slot1, slot2)
	slot3 = {}

	if lua_activity192_episode.configDict[slot1] then
		if not slot0._actEpisodeDict[slot1] then
			slot0._actEpisodeDict = {}

			for slot8, slot9 in ipairs(lua_activity192_episode.configList) do
				if slot1 == slot9.activityId and not slot9.isExtra then
					slot3[#slot3 + 1] = slot9.episodeId
				end
			end
		end
	elseif slot2 then
		logError(string.format("CooperGarlandConfig:getEpisodeIdList error, cfg is nil, actId:%s", slot1))
	end

	return slot3
end

function slot0.getEpisodeName(slot0, slot1, slot2)
	return slot0:getAct192EpisodeCfg(slot1, slot2, true) and slot3.name or ""
end

function slot0.getGameId(slot0, slot1, slot2)
	return slot0:getAct192EpisodeCfg(slot1, slot2, true) and slot3.gameId
end

function slot0.isGameEpisode(slot0, slot1, slot2)
	return slot0:getGameId(slot1, slot2) and slot3 ~= 0
end

function slot0.getStoryBefore(slot0, slot1, slot2)
	return slot0:getAct192EpisodeCfg(slot1, slot2, true) and slot3.storyBefore
end

function slot0.getStoryClear(slot0, slot1, slot2)
	return slot0:getAct192EpisodeCfg(slot1, slot2, true) and slot3.storyClear
end

function slot0.getExtraEpisode(slot0, slot1, slot2)
	slot3 = nil

	if lua_activity192_episode.configDict[slot1] then
		for slot8, slot9 in pairs(slot4) do
			if slot9.isExtra then
				slot3 = slot8

				break
			end
		end
	elseif slot2 then
		logError(string.format("CooperGarlandConfig:getExtraEpisode error, cfg is nil, actId:%s", slot1))
	end

	return slot3
end

function slot0.isExtraEpisode(slot0, slot1, slot2)
	return slot0:getAct192EpisodeCfg(slot1, slot2, true) and slot3.isExtra
end

function slot0.getAct192TaskCfg(slot0, slot1, slot2, slot3)
	slot4 = lua_activity192_task.configDict[slot2]

	if slot3 then
		if slot4 then
			if slot4.activityId ~= slot1 then
				logError(string.format("CooperGarlandConfig:getAct192TaskCfg error, actId error, actId:%s, taskId:%s, cfg actId:%s", slot1, slot2, slot4.activityId))
			end
		else
			logError(string.format("CooperGarlandConfig:getAct192TaskCfg error, cfg is nil, actId:%s, taskId:%s", slot1, slot2))
		end
	end

	return slot4
end

function slot0.getTaskList(slot0, slot1)
	if not slot0._actTaskDict[slot1] then
		slot0._actTaskDict = {}

		for slot6, slot7 in pairs(lua_activity192_task.configDict) do
			if slot1 == slot7.activityId then
				slot2[#slot2 + 1] = slot7
			end
		end
	end

	return slot2
end

function slot0.getAct192GameCfg(slot0, slot1, slot2)
	if not lua_activity192_game.configDict[slot1] and slot2 then
		logError(string.format("CooperGarlandConfig:getAct192GameCfg error, cfg is nil, gameId:%s", slot1))
	end

	return slot3
end

function slot0.getMapId(slot0, slot1, slot2)
	return slot0:getAct192GameCfg(slot1, true) and slot3.maps[slot2]
end

function slot0.getMaxRound(slot0, slot1)
	slot2 = 0

	if slot0:getAct192GameCfg(slot1, true) then
		slot2 = #slot3.maps
	end

	return slot2
end

function slot0.getRemoveCount(slot0, slot1, slot2)
	return slot0:getAct192GameCfg(slot1, true) and slot3.removeCount[slot2]
end

function slot0.getPanelImage(slot0, slot1)
	return slot0:getAct192GameCfg(slot1, true) and slot2.panelImage
end

function slot0.getScenePath(slot0, slot1)
	return slot0:getAct192GameCfg(slot1, true) and slot2.scenePath
end

function slot0.getCubeOpenAnim(slot0, slot1)
	return slot0:getAct192GameCfg(slot1, true) and slot2.cubeOpenAnim
end

function slot0.getCubeSwitchAnim(slot0, slot1)
	return slot0:getAct192GameCfg(slot1, true) and slot2.cubeSwitchAnim
end

function slot0.getAct192MapComponentCfg(slot0, slot1, slot2, slot3)
	if not (lua_activity192_map.configDict[slot1] and lua_activity192_map.configDict[slot1][slot2]) and slot3 then
		logError(string.format("CooperGarlandConfig:getAct192MapComponentCfg error, cfg is nil, mapId:%s, componentId:%s", slot1, slot2))
	end

	return slot4
end

function slot0.getMapComponentList(slot0, slot1)
	return slot0._map2ComponentList and slot0._map2ComponentList[slot1] or {}
end

function slot0.getMapComponentType(slot0, slot1, slot2)
	return slot0:getAct192MapComponentCfg(slot1, slot2, true) and slot3.componentType
end

function slot0.getMapComponentSize(slot0, slot1, slot2)
	slot3 = 0
	slot4 = 0

	if slot0:getAct192MapComponentCfg(slot1, slot2, true) then
		slot3 = slot5.width
		slot4 = slot5.height
	end

	return slot3, slot4
end

function slot0.getMapComponentColliderSize(slot0, slot1, slot2)
	slot3 = 0
	slot4 = 0

	if slot0:getAct192MapComponentCfg(slot1, slot2, true) then
		slot3 = slot5.colliderWidth
		slot4 = slot5.colliderHeight
	end

	return slot3, slot4
end

function slot0.getMapComponentColliderOffset(slot0, slot1, slot2)
	slot3 = 0
	slot4 = 0

	if slot0:getAct192MapComponentCfg(slot1, slot2, true) then
		slot3 = slot5.colliderOffsetX
		slot4 = slot5.colliderOffsetY
	end

	return slot3, slot4
end

function slot0.getMapComponentScale(slot0, slot1, slot2)
	return slot0:getAct192MapComponentCfg(slot1, slot2, true) and slot3.scale
end

function slot0.getMapComponentPos(slot0, slot1, slot2)
	slot3, slot4 = nil

	if slot0:getAct192MapComponentCfg(slot1, slot2, true) then
		slot3 = slot5.posX
		slot4 = slot5.posY
	end

	return slot3, slot4
end

function slot0.getMapComponentRotation(slot0, slot1, slot2)
	return slot0:getAct192MapComponentCfg(slot1, slot2, true) and slot3.rotation
end

function slot0.getMapComponentExtraParams(slot0, slot1, slot2)
	return slot0:getAct192MapComponentCfg(slot1, slot2, true) and slot3.extraParams
end

function slot0.getStoryCompId(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(slot0:getMapComponentList(slot1)) do
		if slot0:getMapComponentType(slot1, slot8) == CooperGarlandEnum.ComponentType.Story and tonumber(slot0:getMapComponentExtraParams(slot1, slot8)) == slot2 then
			return slot8
		end
	end
end

function slot0.getAct192ComponentTypeCfg(slot0, slot1, slot2)
	if not lua_activity192_component_type.configDict[slot1] and slot2 then
		logError(string.format("CooperGarlandConfig:getAct192ComponentTypeCfg error, cfg is nil, componentType:%s", slot1))
	end

	return slot3
end

function slot0.getAllComponentResPath(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(lua_activity192_component_type.configList) do
		slot1[#slot1 + 1] = slot6.path
	end

	return slot1
end

function slot0.getComponentTypePath(slot0, slot1)
	return slot0:getAct192ComponentTypeCfg(slot1, true) and slot2.path
end

slot0.instance = slot0.New()

return slot0
