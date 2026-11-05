-- chunkname: @modules/logic/versionactivity4_1/act248/model/Act248ClueMO.lua

module("modules.logic.versionactivity4_1.act248.model.Act248ClueMO", package.seeall)

local Act248ClueMO = pureTable("Act248ClueMO")

function Act248ClueMO:initCo(co)
	self._co = co
	self.id = self._co.id

	if not string.nilorempty(co.caseId) then
		self._files = string.splitToNumber(co.caseId, "#")
	else
		self._files = {}
	end

	if not string.nilorempty(co.category) then
		self._categorys = string.splitToNumber(co.category, "#")
	else
		self._categorys = {}
	end

	self._actId = Act248Model.instance:getActId()

	self:_parseLockInfo()
end

function Act248ClueMO:_parseLockInfo()
	self._lockInfo = {
		type = self._co.type,
		param = string.splitToNumber(self._co.param, "#")
	}

	if self._lockInfo.type == Act248Enum.UnlockType.Story then
		local storyId = self._lockInfo.param[1]

		if storyId then
			if storyId == Act248Model.instance:getAvgBeforeStoryId() or storyId == Act248Model.instance:getAvgAfterStoryId() then
				local episodeId = Act248Model.instance:getNormalEpisodeId()
				local episodeCo = lua_episode.configDict[episodeId]

				if episodeCo then
					self._lockInfo.lockName = episodeCo.name

					return
				end
			end

			for _, episodeCo in ipairs(lua_episode.configList) do
				if episodeCo.beforeStory == storyId or episodeCo.afterStory == storyId then
					self._lockInfo.lockName = episodeCo.name

					break
				end
			end
		end
	elseif self._lockInfo.type == Act248Enum.UnlockType.Element then
		local elementId = self._lockInfo.param[1]

		if elementId then
			local elementCo = lua_chapter_map_element.configDict[elementId]

			if elementCo then
				self._lockInfo.lockName = elementCo.title
			end
		end
	elseif self._lockInfo.type == Act248Enum.UnlockType.AVG then
		local episodeId = Act248Model.instance:getNormalEpisodeId()
		local episodeCo = lua_episode.configDict[episodeId]

		self._lockInfo.lockName = episodeCo.name
	end
end

function Act248ClueMO:isUnlock()
	if not self:isCanUnlcok() then
		return false
	end

	return self:_isUnlock()
end

function Act248ClueMO:_isUnlock()
	return Act248Model.instance:isUnlockClue(self.id)
end

function Act248ClueMO:isCanUnlcok()
	local lockInfo = self:getLockInfo()

	if lockInfo and lockInfo.type ~= Act248Enum.UnlockType.Story then
		return true
	end

	return Act248Model.instance:isCanUnlockClue(lockInfo.param[1], lockInfo.param[2])
end

function Act248ClueMO:isDefalutUnlock()
	local lockInfo = self:getLockInfo()

	if lockInfo and lockInfo.type == Act248Enum.UnlockType.Defalut then
		return true
	end
end

function Act248ClueMO:isNew()
	if not self:isUnlock() or self:isDefalutUnlock() then
		return false
	end

	local key = string.format("%s_%s_%s", Act248Enum.PlayerPrefKey.NewClue, self._actId, self.id)

	return GameUtil.playerPrefsGetNumberByUserId(key, 0) == 0
end

function Act248ClueMO:cancelNew()
	if not self:isUnlock() then
		return
	end

	local key = string.format("%s_%s_%s", Act248Enum.PlayerPrefKey.NewClue, self._actId, self.id)

	GameUtil.playerPrefsSetNumberByUserId(key, 1)
end

function Act248ClueMO:getConfig()
	return self._co
end

function Act248ClueMO:getClueId()
	return self._co.id
end

function Act248ClueMO:getLockInfo()
	return self._lockInfo
end

function Act248ClueMO:getIcon()
	return ResUrl.getAct248ClueSingleBg(self._co.icon)
end

function Act248ClueMO:getTabIcon()
	return ResUrl.getAct248ClueSingleBg(self._co.tabIcon)
end

function Act248ClueMO:isShowInFile(fileId)
	if self:getFileCount() == 0 or not fileId then
		return true
	end

	return LuaUtil.tableContains(self._files, fileId)
end

function Act248ClueMO:getFileCount()
	return self._files and #self._files or 0
end

function Act248ClueMO:getFiles()
	return self._files
end

function Act248ClueMO:getCategorys()
	return self._categorys
end

function Act248ClueMO:isCategory(category)
	return LuaUtil.tableContains(self._categorys, category)
end

function Act248ClueMO:setCoverClueMo(mo)
	self._coverClueMo = mo
end

function Act248ClueMO:isCover()
	if self._coverClueMo and self._coverClueMo:isUnlock() then
		return self._coverClueMo
	end
end

return Act248ClueMO
