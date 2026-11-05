-- chunkname: @modules/logic/versionactivity4_1/evelyn/model/EvelynGameModel.lua

module("modules.logic.versionactivity4_1.evelyn.model.EvelynGameModel", package.seeall)

local EvelynGameModel = class("EvelynGameModel")

EvelynGameModel.DefaultMapWidth = 5184
EvelynGameModel.DefaultMapHeight = 2160
EvelynGameModel.PropagateGuard = 64

function EvelynGameModel:ctor()
	self._stageId = nil
	self._mapCo = nil
	self._mapWidth = EvelynGameModel.DefaultMapWidth
	self._mapHeight = EvelynGameModel.DefaultMapHeight
	self._nodeDict = nil
	self._nodeList = nil
	self._toolStateDict = nil
	self._toolInputsDict = nil
	self._toolOutputsDict = nil
	self._toolAutoInputsDict = nil
	self._lineDict = nil
	self._linkedLineDict = nil
	self._shownNodeDict = nil
	self._nodeBounds = nil
	self._toolUseDic = nil
	self._toolSubTypeDict = nil
	self._subTypeList = nil
	self._subTypeUnlockedDict = nil
	self._subTypeUnlockAnimPlayedDict = nil
	self._appearQueue = nil
	self._appearQueueIndex = nil
	self._toolShownDict = nil
end

function EvelynGameModel:initMap(stageId)
	local actId = EvelynModel.instance:getActId()

	self._stageId = stageId
	self._mapCo = EvelynConfig.instance:getMapCo(actId, stageId)

	if not self._mapCo then
		logError(string.format("EvelynGameModel:initMap error, no map config, stageId:%s", tostring(stageId)))

		return
	end

	self:_parseMapSize()

	self._nodeDict = {}
	self._nodeList = {}
	self._toolStateDict = {}
	self._toolInputsDict = {}
	self._toolOutputsDict = {}
	self._toolAutoInputsDict = {}
	self._lineDict = {}
	self._linkedLineDict = {}
	self._shownNodeDict = {}
	self._toolUseDic = {}
	self._toolSubTypeDict = {}
	self._subTypeList = {}
	self._subTypeUnlockedDict = {}
	self._subTypeUnlockedDict[EvelynEnum.FirstSubType] = true
	self._subTypeUnlockAnimPlayedDict = {}

	local nodeCos = EvelynConfig.instance:getNodeCos(stageId)

	for _, nodeCo in ipairs(nodeCos or {}) do
		self._nodeDict[nodeCo.id] = nodeCo

		table.insert(self._nodeList, nodeCo)

		if nodeCo.type == EvelynEnum.PointType.Tool then
			local inputIds = self:_parseIdList(nodeCo.inputs)
			local outputIds = self:_parseIdList(nodeCo.outputs)

			self._toolStateDict[nodeCo.id] = {
				placed = false,
				expanded = false
			}
			self._toolInputsDict[nodeCo.id] = inputIds
			self._toolOutputsDict[nodeCo.id] = outputIds
			self._toolAutoInputsDict[nodeCo.id] = self:_parseIdList(nodeCo.autoInputs)

			if not self._toolSubTypeDict[nodeCo.subType] then
				self._toolSubTypeDict[nodeCo.subType] = {}

				table.insert(self._subTypeList, nodeCo.subType)
			end

			table.insert(self._toolSubTypeDict[nodeCo.subType], nodeCo.id)

			for _, fromId in ipairs(inputIds) do
				self:_addLine(fromId, nodeCo.id)
			end

			for _, toId in ipairs(outputIds) do
				self:_addLine(nodeCo.id, toId)
			end
		elseif nodeCo.type == EvelynEnum.PointType.Origin then
			self._shownNodeDict[nodeCo.id] = true
		end
	end

	table.sort(self._subTypeList)

	for _, nodeCo in ipairs(nodeCos or {}) do
		if nodeCo.type == EvelynEnum.PointType.Tool and nodeCo.isToolUse == 1 then
			self:placeTool(nodeCo.id)
		end
	end

	self:_refreshSubTypeUnlock()
	self:_buildAppearQueue()
end

function EvelynGameModel:_parseMapSize()
	self._mapWidth = EvelynGameModel.DefaultMapWidth
	self._mapHeight = EvelynGameModel.DefaultMapHeight

	if self._mapCo and not string.nilorempty(self._mapCo.size) then
		local sizeArr = string.split(self._mapCo.size, "#")

		self._mapWidth = tonumber(sizeArr[1]) or EvelynGameModel.DefaultMapWidth
		self._mapHeight = tonumber(sizeArr[2]) or EvelynGameModel.DefaultMapHeight
	end
end

function EvelynGameModel:_parseIdList(idStr)
	local idList = {}

	if not string.nilorempty(idStr) then
		for _, str in ipairs(string.split(idStr, "#")) do
			local id = tonumber(str)

			if id then
				table.insert(idList, id)
			end
		end
	end

	return idList
end

function EvelynGameModel:_addLine(fromId, toId)
	local lineKey = self:getLineKey(fromId, toId)

	if not self._lineDict[lineKey] then
		self._lineDict[lineKey] = {
			from = fromId,
			to = toId
		}
	end
end

function EvelynGameModel:getLineKey(fromId, toId)
	return fromId .. "_" .. toId
end

function EvelynGameModel:getStageId()
	return self._stageId
end

function EvelynGameModel:getMapWidth()
	return self._mapWidth
end

function EvelynGameModel:getMapHeight()
	return self._mapHeight
end

function EvelynGameModel:getMapCo()
	return self._mapCo
end

function EvelynGameModel:getNodeList()
	return self._nodeList
end

function EvelynGameModel:getNodeCo(nodeId)
	return self._nodeDict and self._nodeDict[nodeId] or nil
end

function EvelynGameModel:getLineDict()
	return self._lineDict
end

function EvelynGameModel:getToolIds()
	local toolIds = {}

	for toolId in pairs(self._toolStateDict or {}) do
		table.insert(toolIds, toolId)
	end

	return toolIds
end

function EvelynGameModel:getToolInputIds(toolId)
	return self._toolInputsDict and self._toolInputsDict[toolId] or {}
end

function EvelynGameModel:getToolOutputIds(toolId)
	return self._toolOutputsDict and self._toolOutputsDict[toolId] or {}
end

function EvelynGameModel:getToolAutoInputIds(toolId)
	return self._toolAutoInputsDict and self._toolAutoInputsDict[toolId] or {}
end

function EvelynGameModel:getToolUseCount(toolId)
	return self._toolUseDic and self._toolUseDic[toolId] or 0
end

function EvelynGameModel:getToolUseDic()
	return self._toolUseDic
end

function EvelynGameModel:getToolUseTime(toolId)
	local nodeCo = self:getNodeCo(toolId)
	local useTime = tonumber(nodeCo and nodeCo.useTime)

	if not useTime or useTime <= 0 then
		return EvelynEnum.AnimTime.ToolToRes
	end

	return useTime
end

function EvelynGameModel:getSubTypeList()
	return self._subTypeList or {}
end

function EvelynGameModel:getSubTypeToolIds(subType)
	local toolIds = self._toolSubTypeDict and self._toolSubTypeDict[subType]

	if not toolIds then
		return {}
	end

	local copyIds = {}

	for i, toolId in ipairs(toolIds) do
		copyIds[i] = toolId
	end

	return copyIds
end

function EvelynGameModel:isSubTypeUnlocked(subType)
	return self._subTypeUnlockedDict and self._subTypeUnlockedDict[subType] == true or false
end

function EvelynGameModel:isSubTypeToolsAllPlaced(subType)
	local toolIds = self._toolSubTypeDict and self._toolSubTypeDict[subType]

	if not toolIds then
		return false
	end

	for _, toolId in ipairs(toolIds) do
		if not self:isToolPlaced(toolId) then
			return false
		end
	end

	return true
end

function EvelynGameModel:isResLinkableConsumersAllLinked(resId)
	for toolId, inputIds in pairs(self._toolInputsDict or {}) do
		if self:isToolPlaced(toolId) then
			local nodeCo = self._nodeDict and self._nodeDict[toolId]

			if not nodeCo or self:isSubTypeUnlocked(nodeCo.subType) then
				for _, inputId in ipairs(inputIds) do
					if inputId == resId and not self:isLineLinked(resId, toolId) then
						return false
					end
				end
			end
		end
	end

	return true
end

function EvelynGameModel:getMapOriginPos()
	if not self._mapCo or string.nilorempty(self._mapCo.originPos) then
		return nil
	end

	local parts = string.split(self._mapCo.originPos, "#")
	local x = tonumber(parts[1]) or 0
	local y = tonumber(parts[2]) or 0

	return x, y
end

function EvelynGameModel:getNodePos(nodeId)
	local nodeCo = self._nodeDict[nodeId]

	if not nodeCo or string.nilorempty(nodeCo.pos) then
		return 0, 0
	end

	local posArr = string.split(nodeCo.pos, "#")
	local x = tonumber(posArr[1]) or 0
	local y = tonumber(posArr[2]) or 0

	return EvelynHelper.ConvertOriginPos(x, y, self._mapWidth * 0.5, self._mapHeight * 0.5)
end

function EvelynGameModel:getNodeBounds()
	if not self._nodeBounds then
		local minX, maxX, minY, maxY

		for _, nodeCo in ipairs(self._nodeList or {}) do
			local x, y = self:getNodePos(nodeCo.id)

			minX = math.min(minX or x, x)
			maxX = math.max(maxX or x, x)
			minY = math.min(minY or y, y)
			maxY = math.max(maxY or y, y)
		end

		if not minX then
			minX, maxX = -self._mapWidth * 0.5, self._mapWidth * 0.5
			minY, maxY = -self._mapHeight * 0.5, self._mapHeight * 0.5
		end

		self._nodeBounds = {
			minX = minX,
			maxX = maxX,
			minY = minY,
			maxY = maxY
		}
	end

	return self._nodeBounds.minX, self._nodeBounds.maxX, self._nodeBounds.minY, self._nodeBounds.maxY
end

function EvelynGameModel:isNodeShown(nodeId)
	local nodeCo = self._nodeDict and self._nodeDict[nodeId]

	if not nodeCo then
		return self._shownNodeDict and self._shownNodeDict[nodeId] == true or false
	end

	if nodeCo.type == EvelynEnum.PointType.Tool then
		return self:isToolShown(nodeId)
	end

	return self._shownNodeDict and self._shownNodeDict[nodeId] == true or false
end

function EvelynGameModel:getShownNodeIds()
	local nodeIds = {}

	for nodeId in pairs(self._shownNodeDict or {}) do
		table.insert(nodeIds, nodeId)
	end

	table.sort(nodeIds)

	return nodeIds
end

function EvelynGameModel:isGameClear()
	for _, nodeCo in ipairs(self._nodeList or {}) do
		if nodeCo.type == EvelynEnum.PointType.End then
			local isShown = self:isNodeShown(nodeCo.id)

			logWarn(string.format("[EvelynGameModel] isGameClear: End node id=%s, isShown=%s", tostring(nodeCo.id), tostring(isShown)))

			if isShown then
				return true
			end
		end
	end

	return false
end

function EvelynGameModel:isToolPlaced(toolId)
	local state = self._toolStateDict and self._toolStateDict[toolId]

	return state and state.placed or false
end

function EvelynGameModel:isToolExpanded(toolId)
	local state = self._toolStateDict and self._toolStateDict[toolId]

	return state and state.expanded or false
end

function EvelynGameModel:placeTool(toolId)
	local state = self._toolStateDict and self._toolStateDict[toolId]

	if not state or state.placed then
		return false
	end

	state.placed = true
	self._toolUseDic[toolId] = (self._toolUseDic[toolId] or 0) + 1

	self:_refreshSubTypeUnlock()
	self:autoLinkPendingInputs()

	return true
end

function EvelynGameModel:_refreshSubTypeUnlock()
	for i = 2, #self._subTypeList do
		local subType = self._subTypeList[i]

		if not self._subTypeUnlockedDict[subType] then
			local toolIds = self._toolSubTypeDict and self._toolSubTypeDict[subType]

			if toolIds then
				for _, toolId in ipairs(toolIds) do
					if self:isToolUnlocked(toolId) then
						self._subTypeUnlockedDict[subType] = true

						break
					end
				end
			end
		end
	end
end

function EvelynGameModel:isLineLinked(fromId, toId)
	return self._linkedLineDict and self._linkedLineDict[self:getLineKey(fromId, toId)] == true or false
end

function EvelynGameModel:isLineLinkedByKey(lineKey)
	return self._linkedLineDict and self._linkedLineDict[lineKey] == true or false
end

function EvelynGameModel:isNodeLinkable(nodeId)
	local nodeCo = self._nodeDict and self._nodeDict[nodeId]

	if not nodeCo then
		return false
	end

	if nodeCo.type == EvelynEnum.PointType.Tool then
		return self:isToolPlaced(nodeId)
	end

	return self:isNodeShown(nodeId)
end

function EvelynGameModel:isToolInputsReady(toolId)
	for _, inputId in ipairs(self:getToolInputIds(toolId)) do
		if not self:isNodeShown(inputId) then
			return false
		end
	end

	return true
end

function EvelynGameModel:isToolUnlocked(toolId)
	local nodeCo = self:getNodeCo(toolId)

	if not nodeCo then
		return false
	end

	return self:isToolInputsReady(toolId)
end

function EvelynGameModel:expandTool(toolId)
	if self:isToolExpanded(toolId) then
		return false
	end

	local state = self._toolStateDict[toolId]

	state.expanded = true

	if self._appearQueue then
		local outputIds = self:getToolOutputIds(toolId)

		logWarn(string.format("[EvelynGameModel] expandTool: toolId=%s, outputIds=%s", tostring(toolId), table.concat(outputIds or {}, ",")))

		local newOutputIds = {}

		for _, outputId in ipairs(outputIds) do
			if not self:isNodeInQueue(outputId) then
				table.insert(newOutputIds, outputId)
			end
		end

		if #newOutputIds > 0 then
			logWarn(string.format("[EvelynGameModel] expandTool: adding batch to queue: %s", table.concat(newOutputIds, ",")))
			table.insert(self._appearQueue, {
				nodeIds = newOutputIds
			})
		end
	else
		for _, outputId in ipairs(self:getToolOutputIds(toolId)) do
			self._shownNodeDict[outputId] = true

			local lineKey = self:getLineKey(toolId, outputId)

			if self._lineDict[lineKey] then
				self._linkedLineDict[lineKey] = true
			end
		end
	end

	self:_refreshSubTypeUnlock()
	self:_enqueueNewlyUnlockedNodes()

	return true
end

function EvelynGameModel:linkLine(fromId, toId)
	local lineKey = self:getLineKey(fromId, toId)
	local lineCo = self._lineDict and self._lineDict[lineKey]

	if not lineCo then
		return false
	end

	if self._linkedLineDict[lineKey] then
		return false
	end

	if not self:isNodeLinkable(fromId) or not self:isNodeLinkable(toId) then
		return false
	end

	self._linkedLineDict[lineKey] = true

	local toCo = self._nodeDict[toId]

	if toCo and toCo.type == EvelynEnum.PointType.Tool then
		self:_tryExpandToolByLink(toId)
	end

	return true
end

function EvelynGameModel:isToolInputsLinked(toolId)
	for _, inputId in ipairs(self:getToolInputIds(toolId)) do
		if not self:isLineLinked(inputId, toolId) then
			return false
		end
	end

	return true
end

function EvelynGameModel:_tryExpandToolByLink(toolId)
	local state = self._toolStateDict and self._toolStateDict[toolId]

	if not state or not state.placed or state.expanded then
		return
	end

	if self:isToolInputsLinked(toolId) then
		self:expandTool(toolId)
	end
end

function EvelynGameModel:propagate()
	local expandedToolIds = {}
	local changed = true
	local guard = 0

	while changed and guard < EvelynGameModel.PropagateGuard do
		guard = guard + 1
		changed = false

		for toolId, state in pairs(self._toolStateDict) do
			if state.placed and not state.expanded and self:isToolInputsLinked(toolId) then
				self:expandTool(toolId)
				table.insert(expandedToolIds, toolId)

				changed = true
			end
		end
	end

	return expandedToolIds
end

function EvelynGameModel:autoLinkPendingInputs()
	local guard = 0
	local changed = true

	while changed and guard < EvelynGameModel.PropagateGuard do
		guard = guard + 1
		changed = false

		for toolId, autoInputIds in pairs(self._toolAutoInputsDict or {}) do
			local state = self._toolStateDict and self._toolStateDict[toolId]

			if state and state.placed and self:isToolUnlocked(toolId) and self:isToolShown(toolId) then
				for _, inputId in ipairs(autoInputIds) do
					if self:linkLine(inputId, toolId) then
						changed = true
					end
				end
			end
		end
	end

	self:_enqueueNewlyUnlockedNodes()
end

function EvelynGameModel:linkAllLines()
	for lineKey, lineCo in pairs(self._lineDict or {}) do
		if not self._linkedLineDict[lineKey] then
			self._linkedLineDict[lineKey] = true
		end
	end
end

function EvelynGameModel:resetMap()
	for _, state in pairs(self._toolStateDict or {}) do
		state.placed = false
		state.expanded = false
	end

	self._linkedLineDict = {}
	self._shownNodeDict = {}
	self._subTypeUnlockedDict = {}
	self._subTypeUnlockAnimPlayedDict = {}
	self._subTypeUnlockedDict[EvelynEnum.FirstSubType] = true
	self._subTypeUnlockAnimPlayedDict[EvelynEnum.FirstSubType] = true

	for _, nodeCo in ipairs(self._nodeList or {}) do
		if nodeCo.type == EvelynEnum.PointType.Tool and nodeCo.isToolUse == 1 then
			local state = self._toolStateDict and self._toolStateDict[nodeCo.id]

			if state then
				state.placed = true
			end
		end
	end

	self:_refreshSubTypeUnlock()
	self:_buildAppearQueue()
end

function EvelynGameModel:isSubTypeUnlockAnimPlayed(subType)
	return self._subTypeUnlockAnimPlayedDict and self._subTypeUnlockAnimPlayedDict[subType] == true or false
end

function EvelynGameModel:markSubTypeUnlockAnimPlayed(subType)
	if not self._subTypeUnlockAnimPlayedDict then
		self._subTypeUnlockAnimPlayedDict = {}
	end

	self._subTypeUnlockAnimPlayedDict[subType] = true
end

function EvelynGameModel:_buildAppearQueue()
	self._appearQueue = {}
	self._appearQueueIndex = 1
	self._toolShownDict = {}

	for _, nodeCo in ipairs(self._nodeList or {}) do
		if nodeCo.type == EvelynEnum.PointType.Origin then
			table.insert(self._appearQueue, {
				nodeIds = {
					nodeCo.id
				}
			})
		end
	end

	for _, nodeCo in ipairs(self._nodeList or {}) do
		if nodeCo.type == EvelynEnum.PointType.Tool and nodeCo.isToolUse == 1 and self:isToolInputsReady(nodeCo.id) then
			table.insert(self._appearQueue, {
				nodeIds = {
					nodeCo.id
				}
			})
		end
	end
end

function EvelynGameModel:_enqueueNewlyUnlockedNodes()
	if not self._appearQueue then
		return
	end

	for _, nodeCo in ipairs(self._nodeList or {}) do
		if nodeCo.type == EvelynEnum.PointType.Tool and not self._toolShownDict[nodeCo.id] and self:isToolInputsReady(nodeCo.id) and not self:isNodeInQueue(nodeCo.id) then
			table.insert(self._appearQueue, {
				nodeIds = {
					nodeCo.id
				}
			})
		end
	end
end

function EvelynGameModel:_resetAppearQueue()
	self._appearQueueIndex = 1
	self._toolShownDict = {}
end

function EvelynGameModel:hasNodeReadyToAppear()
	if not self._appearQueue then
		return false
	end

	return self._appearQueueIndex <= #self._appearQueue
end

function EvelynGameModel:getNextNodeReadyToAppear()
	if not self:hasNodeReadyToAppear() then
		return nil
	end

	local batch = self._appearQueue[self._appearQueueIndex]

	if not batch or not batch.nodeIds or #batch.nodeIds == 0 then
		return nil
	end

	return batch.nodeIds[1]
end

function EvelynGameModel:tryShowNextNode()
	if not self:hasNodeReadyToAppear() then
		return nil
	end

	local batch = self._appearQueue[self._appearQueueIndex]

	self._appearQueueIndex = self._appearQueueIndex + 1

	local dequeuedIds = {}

	logWarn(string.format("[EvelynGameModel] tryShowNextNode: dequeuing batch: %s", table.concat(batch.nodeIds or {}, ",")))

	for _, nodeId in ipairs(batch.nodeIds or {}) do
		table.insert(dequeuedIds, nodeId)

		local nodeCo = self:getNodeCo(nodeId)

		if nodeCo then
			if nodeCo.type == EvelynEnum.PointType.Tool then
				self._toolShownDict[nodeId] = true

				if nodeCo.isToolUse == 1 and not self:isToolExpanded(nodeId) then
					self:expandTool(nodeId)
					self:autoLinkPendingInputs()
				end
			else
				self._shownNodeDict[nodeId] = true

				logWarn(string.format("[EvelynGameModel] tryShowNextNode: marking node as shown: %s (type=%s)", tostring(nodeId), tostring(nodeCo.type)))

				for _, lineCo in pairs(self._lineDict or {}) do
					if lineCo.to == nodeId and not self._linkedLineDict[self:getLineKey(lineCo.from, lineCo.to)] and self:isNodeShown(lineCo.from) then
						self._linkedLineDict[self:getLineKey(lineCo.from, lineCo.to)] = true
					end
				end

				self:autoLinkPendingInputs()
				self:_refreshSubTypeUnlock()
			end
		end
	end

	return dequeuedIds
end

function EvelynGameModel:isToolShown(toolId)
	return self._toolShownDict and self._toolShownDict[toolId] == true or false
end

function EvelynGameModel:isNodeInQueue(nodeId)
	if not self._appearQueue then
		return false
	end

	for _, batch in ipairs(self._appearQueue) do
		for _, id in ipairs(batch.nodeIds or {}) do
			if id == nodeId then
				return true
			end
		end
	end

	return false
end

return EvelynGameModel
