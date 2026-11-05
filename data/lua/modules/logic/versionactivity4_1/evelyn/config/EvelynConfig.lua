-- chunkname: @modules/logic/versionactivity4_1/evelyn/config/EvelynConfig.lua

module("modules.logic.versionactivity4_1.evelyn.config.EvelynConfig", package.seeall)

local EvelynConfig = class("EvelynConfig", BaseConfig)

function EvelynConfig:ctor()
	self._evelynMap = nil
	self._evelynNode = nil
	self._toolPanelParamCache = nil
end

function EvelynConfig:reqConfigNames()
	return {
		"activity220_evelyn_map",
		"activity220_evelyn_node"
	}
end

function EvelynConfig:onConfigLoaded(configName, configTable)
	if configName == "activity220_evelyn_map" then
		self._evelynMap = configTable
	elseif configName == "activity220_evelyn_node" then
		self._evelynNode = configTable
	end
end

function EvelynConfig:getMapCo(activityId, id)
	if self._evelynMap and self._evelynMap.configDict[activityId] then
		return self._evelynMap.configDict[activityId][id]
	end

	return nil
end

function EvelynConfig:getMapCos(activityId)
	if self._evelynMap then
		return self._evelynMap.configDict[activityId]
	end

	return nil
end

function EvelynConfig:getNodeCo(stageId, id)
	if self._evelynNode and self._evelynNode.configDict[stageId] then
		return self._evelynNode.configDict[stageId][id]
	end

	return nil
end

function EvelynConfig:getNodeCos(stageId)
	if self._evelynNode then
		return self._evelynNode.configDict[stageId]
	end

	return nil
end

function EvelynConfig:getEpisodeConfig(episodeId)
	local actId = VersionActivity4_1Enum.ActivityId.Evelyn

	return Activity220Config.instance:getEpisodeConfig(actId, episodeId)
end

function EvelynConfig:getEpisodeConfigList()
	local actId = VersionActivity4_1Enum.ActivityId.Evelyn

	return Activity220Config.instance:getEpisodeConfigList(actId)
end

function EvelynConfig:getEpisodeIndex(episodeId)
	local actId = VersionActivity4_1Enum.ActivityId.Evelyn

	return Activity220Config.instance:getEpisodeIndex(actId, episodeId)
end

function EvelynConfig:getNodeRelatePanelParam(stageId, toolId, nodeId, isInput)
	if not self._toolPanelParamCache then
		self._toolPanelParamCache = {}
	end

	if not self._toolPanelParamCache[stageId] then
		self._toolPanelParamCache[stageId] = {}
	end

	local stageCache = self._toolPanelParamCache[stageId]

	if not stageCache[toolId] then
		local toolCache = {}
		local co = self:getNodeCo(stageId, toolId)

		if co and co.type == EvelynEnum.PointType.Tool then
			logWarn(string.format("[EvelynConfig][PanelParam] toolId:%s type:%s inputPanelParam:'%s' outPutpanelParam:'%s' inputs:'%s' outputs:'%s'", tostring(co.id), tostring(co.type), tostring(co.inputPanelParam), tostring(co.outPutpanelParam), tostring(co.inputs), tostring(co.outputs)))

			local inputIds = {}

			if not string.nilorempty(co.inputs) then
				for i, s in ipairs(string.split(co.inputs, "#")) do
					local id = tonumber(s)

					if id then
						inputIds[i] = id
					end
				end
			end

			local outputIds = {}

			if not string.nilorempty(co.outputs) then
				for i, s in ipairs(string.split(co.outputs, "#")) do
					local id = tonumber(s)

					if id then
						outputIds[i] = id
					end
				end
			end

			if not string.nilorempty(co.inputPanelParam) then
				local groups = string.split(co.inputPanelParam, "|")

				for i, id in ipairs(inputIds) do
					local param = groups[i]

					if not string.nilorempty(param) then
						local parts = string.split(param, "#")

						toolCache[id] = {
							offsetX = tonumber(parts[1]) or EvelynEnum.PanelDefaultOffset.X,
							offsetY = tonumber(parts[2]) or EvelynEnum.PanelDefaultOffset.Y,
							scale = tonumber(parts[3]) or EvelynEnum.PanelDefaultScale
						}

						logWarn(string.format("[EvelynConfig][PanelParam]   input[%d] nodeId:%s -> offsetX:%.1f offsetY:%.1f scale:%.2f", i, tostring(id), toolCache[id].offsetX, toolCache[id].offsetY, toolCache[id].scale))
					end
				end
			end

			if not string.nilorempty(co.outPutpanelParam) then
				local groups = string.split(co.outPutpanelParam, "|")

				for i, id in ipairs(outputIds) do
					local param = groups[i]

					if not string.nilorempty(param) then
						local parts = string.split(param, "#")

						toolCache[id] = {
							offsetX = tonumber(parts[1]) or EvelynEnum.PanelDefaultOffset.X,
							offsetY = tonumber(parts[2]) or EvelynEnum.PanelDefaultOffset.Y,
							scale = tonumber(parts[3]) or EvelynEnum.PanelDefaultScale
						}

						logWarn(string.format("[EvelynConfig][PanelParam]   output[%d] nodeId:%s -> offsetX:%.1f offsetY:%.1f scale:%.2f", i, tostring(id), toolCache[id].offsetX, toolCache[id].offsetY, toolCache[id].scale))
					end
				end
			end
		end

		stageCache[toolId] = toolCache
	end

	local param = stageCache[toolId][nodeId]

	if param then
		return param.offsetX, param.offsetY, param.scale
	end

	return EvelynEnum.PanelDefaultOffset.X, EvelynEnum.PanelDefaultOffset.Y, EvelynEnum.PanelDefaultScale
end

EvelynConfig.instance = EvelynConfig.New()

return EvelynConfig
