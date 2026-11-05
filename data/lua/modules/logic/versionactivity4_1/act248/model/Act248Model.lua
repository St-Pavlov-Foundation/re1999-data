-- chunkname: @modules/logic/versionactivity4_1/act248/model/Act248Model.lua

module("modules.logic.versionactivity4_1.act248.model.Act248Model", package.seeall)

local Act248Model = class("Act248Model", BaseModel)

function Act248Model:onInit()
	self:reInit()
end

function Act248Model:reInit()
	self._fileModel = nil
	self._clueGroups = nil
	self._clueModel = nil
	self._readStoryDict = nil
end

function Act248Model:getActId()
	return VersionActivity4_1Enum.ActivityId.Act248
end

function Act248Model:initInfo(info)
	local fileModel = self:getFileModel()

	for _, fileMo in ipairs(fileModel:getList()) do
		fileMo:setLock(true)
	end

	self._unlockClueIds = {}

	for _, fileInfo in ipairs(info.fileInfos) do
		self:refreshFileInfo(fileInfo)
	end

	for _, clueId in ipairs(info.unlockClueIds) do
		self._unlockClueIds[clueId] = true
	end

	self:refreshInfo(info.fileInfos, info.unlockClueIds)
end

function Act248Model:refreshInfo(fileInfos, unlockClueIds, isPush)
	if fileInfos then
		for _, fileInfo in ipairs(fileInfos) do
			self:refreshFileInfo(fileInfo)
		end
	end

	self:refreshFileNew()
	self:refreshUnlockClueInfo(unlockClueIds, isPush)
end

function Act248Model:refreshUnlockClueInfo(unlockClueIds, isPush)
	if unlockClueIds then
		if not self._unlockClueIds then
			self._unlockClueIds = {}
		end

		for _, clueId in ipairs(unlockClueIds) do
			self._unlockClueIds[clueId] = true
		end
	end

	self:refreshClueNew()

	local clueModel = self:getClueModel()

	if clueModel then
		for _, clueMo in ipairs(clueModel:getList()) do
			if clueMo:isDefalutUnlock() and not clueMo:isUnlock() then
				Act248Rpc.instance:sendAct248UnlockSingleClueRequest(clueMo.id)
			end
		end
	end
end

function Act248Model:refreshFileNew()
	local isNewFile = false
	local fileModel = self:getFileModel()

	if fileModel then
		for _, fileMo in ipairs(fileModel:getList()) do
			if fileMo:isNew() then
				isNewFile = true
			end
		end
	end

	local redDotGroupList = {}
	local isShow = isNewFile and not RedDotModel.instance:isDotShow(RedDotEnum.DotNode.Act248File)

	table.insert(redDotGroupList, {
		id = RedDotEnum.DotNode.Act248File,
		value = isShow and 1 or 0
	})
	RedDotRpc.instance:clientAddRedDotGroupList(redDotGroupList)
	Act248Controller.instance:dispatchEvent(Act248Event.OnRefreshNew)
end

function Act248Model:refreshClueNew()
	local isNewClue = false
	local clueModel = self:getClueModel()

	if clueModel then
		for _, clueMo in ipairs(clueModel:getList()) do
			if clueMo:isNew() then
				isNewClue = true
			end
		end
	end

	local redDotGroupList = {}
	local isShow = isNewClue and not RedDotModel.instance:isDotShow(RedDotEnum.DotNode.Act248Clue)

	table.insert(redDotGroupList, {
		id = RedDotEnum.DotNode.Act248Clue,
		value = isShow and 1 or 0
	})
	RedDotRpc.instance:clientAddRedDotGroupList(redDotGroupList)
	Act248Controller.instance:dispatchEvent(Act248Event.OnRefreshNew)
end

function Act248Model:refreshFileInfo(fileInfo)
	local fileMo = self:getFileById(fileInfo.fileId)

	if fileMo then
		fileMo:refreshInfo(fileInfo)
	end
end

function Act248Model:getFileModel()
	if not self._fileModel then
		self._fileModel = BaseModel.New()

		for _, co in ipairs(lua_activity248_file.configList) do
			local mo = Act248FileMO.New()

			mo:initCo(co)
			self._fileModel:addAtLast(mo)
		end
	end

	return self._fileModel
end

function Act248Model:getFileById(id)
	local model = self:getFileModel()

	return model:getById(id)
end

function Act248Model:getFinishFileCount()
	local count = 0
	local model = self:getFileModel()

	for _, mo in ipairs(model:getList()) do
		if mo:isFinish() then
			count = count + 1
		end
	end

	return count, model:getCount()
end

function Act248Model:onGenerateReport(fileId)
	local mo = self:getFileById(fileId)

	if mo then
		mo:onFinishFill(true)
	end
end

function Act248Model:onFinishReport(fileId)
	local mo = self:getFileById(fileId)

	if mo then
		mo:onFinish(true)
	end

	self:refreshFileNew()
end

function Act248Model:getClueModel()
	if not self._clueModel then
		self._clueModel = BaseModel.New()

		for _, co in ipairs(lua_activity248_clue.configList) do
			local mo = Act248ClueMO.New()

			mo:initCo(co)
			self._clueModel:addAtLast(mo)
		end

		self._clueStorySteps = {}

		for _, mo in ipairs(self._clueModel:getList()) do
			local co = mo:getConfig()

			if co.coverId > 0 then
				local coverMo = self:getClueById(co.coverId)

				if coverMo then
					coverMo:setCoverClueMo(mo)
				end
			end

			local lockInfo = mo:getLockInfo()

			if lockInfo.type == Act248Enum.UnlockType.Story then
				local storyId = lockInfo.param[1]

				if not self._clueStorySteps[storyId] then
					self._clueStorySteps[storyId] = {}
				end
			end
		end
	end

	return self._clueModel
end

function Act248Model:getClueById(id)
	local model = self:getClueModel()

	return model:getById(id)
end

function Act248Model:getHasClueCount()
	local model = self:getClueModel()
	local count, total = 0, 0

	for _, mo in ipairs(model:getList()) do
		local co = mo:getConfig()

		if co.coverId == 0 then
			local fileCount = mo:getFileCount()

			if fileCount > 0 then
				if self:isUnlockClue(mo.id) then
					count = count + 1
				end

				total = total + 1
			end
		end
	end

	return count, total
end

function Act248Model:getClueGroups()
	if not self._clueGroups then
		local model = self:getClueModel()

		self._clueGroups = {}

		for _, mo in ipairs(model:getList()) do
			local categorys = mo:getCategorys()

			for _, v in pairs(categorys) do
				if not self._clueGroups[v] then
					self._clueGroups[v] = {}
				end

				table.insert(self._clueGroups[v], mo)
			end
		end

		for _, list in pairs(self._clueGroups) do
			table.sort(list, function(a, b)
				return a.id < b.id
			end)
		end
	end

	return self._clueGroups
end

function Act248Model:getClueListByCategory(category)
	local groups = self:getClueGroups()

	return groups[category]
end

function Act248Model:getClueGroupList()
	if not self._clueGroupList then
		local groups = self:getClueGroups()

		self._clueGroupList = {}

		for category, list in pairs(groups) do
			local mo = {
				category = category,
				list = list
			}

			table.insert(self._clueGroupList, mo)
		end

		table.sort(self._clueGroupList, function(a, b)
			return a.category < b.category
		end)
	end

	return self._clueGroupList
end

function Act248Model:getCategoryByClueId(clueId)
	local moList = self:getClueGroupList()

	for i, mo in ipairs(moList) do
		local category = mo.category
		local list = mo.list

		for _, v in ipairs(list) do
			if v.id == clueId then
				return category
			end
		end
	end
end

function Act248Model:getAvgClueInfos()
	if not self._avgClueInfos then
		self._avgClueInfos = {}

		local model = self:getClueModel()

		for _, mo in ipairs(model:getList()) do
			local lockInfo = mo:getLockInfo()

			if lockInfo and lockInfo.type == Act248Enum.UnlockType.AVG then
				local index = lockInfo.param[1]

				if not self._avgClueInfos[index] then
					self._avgClueInfos[index] = {}
				end

				table.insert(self._avgClueInfos[index], mo)
			end
		end

		for _, v in pairs(self._avgClueInfos) do
			table.sort(v, function(a, b)
				return a.id < b.id
			end)
		end
	end

	return self._avgClueInfos
end

function Act248Model:getAvgClueInfosByIndex(index)
	local infos = self:getAvgClueInfos()

	return infos[index]
end

function Act248Model:isAllFinishCollectAvgClueInfos()
	local infos = self:getAvgClueInfos()

	for _, v in pairs(infos) do
		for _, mo in pairs(v) do
			if not self:isUnlockClue(mo.id) then
				return false
			end
		end
	end

	return true
end

function Act248Model:isUnlockClue(clueId)
	if not self._unlockClueIds then
		return
	end

	return self._unlockClueIds[clueId]
end

function Act248Model:isCanUnlockClue(storyId, step)
	if not self._readStoryDict then
		self._readStoryDict = {}
	end

	if StoryModel.instance:isStoryFinished(storyId) then
		if self._readStoryDict[storyId] then
			self._readStoryDict[storyId] = nil
		end

		return true
	end

	if not self._readStoryDict[storyId] then
		return false
	end

	return self._readStoryDict[storyId][step]
end

function Act248Model:onReadStory(storyId, step)
	local _isAct248Story = self:isAct248Story(storyId)

	if not _isAct248Story then
		return
	end

	if not self._readStoryDict then
		self._readStoryDict = {}
	end

	if not self._readStoryDict[storyId] then
		self._readStoryDict[storyId] = {}
	end

	self._readStoryDict[storyId][step] = true
end

function Act248Model:isAct248Story(storyId)
	if not self._clueStoryIds then
		self:_initAct248Story()
	end

	return self._clueStoryIds[storyId] ~= nil
end

function Act248Model:_initAct248Story()
	self._clueStoryIds = {}

	local model = self:getClueModel()

	for _, mo in ipairs(model:getList()) do
		local lockInfo = mo:getLockInfo()

		if lockInfo and lockInfo.type == Act248Enum.UnlockType.Story then
			local _storyId = lockInfo.param[1]
			local _step = lockInfo.param[2]

			if not self._clueStoryIds[_storyId] then
				self._clueStoryIds[_storyId] = {}
			end

			self._clueStoryIds[_storyId][_step] = mo
		end
	end
end

function Act248Model:getClueMoByStoryStep(storyId, step)
	if not self._clueStoryIds then
		self:_initAct248Story()
	end

	if not self._clueStoryIds[storyId] then
		return
	end

	return self._clueStoryIds[storyId][step]
end

function Act248Model:getAvgBeforeStoryId()
	return Act248Config.instance:getConstValue(Act248Enum.Const.AvgBeforeStoryId, true)
end

function Act248Model:getAvgAfterStoryId()
	return Act248Config.instance:getConstValue(Act248Enum.Const.AvgAfterStoryId, true)
end

function Act248Model:getNormalEpisodeId()
	if not self._normalEpisodeId then
		local list = DungeonConfig.instance:getChapterEpisodeCOList(VersionActivity4_1DungeonEnum.DungeonChapterId.Story)
		local beforeStoryId = self:getAvgBeforeStoryId()

		for _, episodeCo in ipairs(list) do
			if episodeCo.beforeStory == beforeStoryId then
				self._normalEpisodeId = episodeCo.id

				break
			end
		end
	end

	return self._normalEpisodeId
end

function Act248Model:clearAct248Client()
	local actId = self:getActId()
	local fileModel = self:getFileModel()

	for _, mo in ipairs(fileModel:getList()) do
		local fileStatusKey = string.format("%s_%s_%s", Act248Enum.PlayerPrefKey.FileAnimStatus, actId, mo.id)

		GameUtil.playerPrefsSetNumberByUserId(fileStatusKey, Act248Enum.FileStatus.Lock)

		local fileNewFile = string.format("%s_%s_%s", Act248Enum.PlayerPrefKey.NewFile, actId, mo.id)

		GameUtil.playerPrefsSetNumberByUserId(fileNewFile, 0)

		local fileFirstFinish = string.format("%s_%s_%s", Act248Enum.PlayerPrefKey.FileFirstFinish, actId, mo.id)

		GameUtil.playerPrefsSetNumberByUserId(fileFirstFinish, 0)

		local slotGroupMos = mo:getSlotMos()

		for _, slotGroupMo in pairs(slotGroupMos) do
			for _, slotMo in ipairs(slotGroupMo:getMos()) do
				slotMo:setStatus(Act248Enum.SlotFillStatus.Normal)
			end

			local slotGroupWrongClueIdsKey = string.format("%s_%s_%s", Act248Enum.PlayerPrefKey.SlotWrongClueIds, actId, slotGroupMo.id)

			GameUtil.playerPrefsSetStringByUserId(slotGroupWrongClueIdsKey, "")
			slotGroupMo:checkWrongClues()
		end
	end

	local clueModel = self:getClueModel()

	for _, mo in ipairs(clueModel:getList()) do
		local newClueKey = string.format("%s_%s_%s", Act248Enum.PlayerPrefKey.NewClue, actId, mo.id)

		GameUtil.playerPrefsSetNumberByUserId(newClueKey, 0)
	end
end

function Act248Model:getAct248StoryBtnInfo()
	if not self._act248StoryBtnInfo then
		self._act248StoryBtnInfo = {
			sibling = 1,
			btnText = "act248_clue_title",
			btnIcon = "common_btn_book",
			btnClickFunc = function(cb, cbObj)
				Act248Controller.instance:openAct248ClueMainView(nil, cb, cbObj)
			end
		}
	end

	return self._act248StoryBtnInfo
end

function Act248Model:isAct248StoryId(storyId)
	if not self._canShowStoryBtn then
		self._canShowStoryBtn = {}

		local avgBeforeStoryId = self:getAvgBeforeStoryId()
		local avgAfterStoryId = self:getAvgAfterStoryId()
		local normalEpisodeId = self:getNormalEpisodeId()

		self._canShowStoryBtn[avgBeforeStoryId] = normalEpisodeId
		self._canShowStoryBtn[avgAfterStoryId] = normalEpisodeId

		local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(VersionActivity4_1DungeonEnum.DungeonChapterId.Story1)

		if episodeList then
			for _, config in ipairs(episodeList) do
				if self:isCanShowAct248(config.id) then
					if config.beforeStory > 0 then
						self._canShowStoryBtn[config.beforeStory] = config.id
					end

					if not string.nilorempty(config.story) then
						self._canShowStoryBtn[config.story] = config.id
					end

					if config.afterStory > 0 then
						self._canShowStoryBtn[config.afterStory] = config.id
					end
				end
			end
		end
	end

	return self._canShowStoryBtn[storyId]
end

function Act248Model:isCanShowAct248(episodeId)
	local normalEpisodeId = self:getNormalEpisodeId()
	local episodeIndex = VersionActivityFixedDungeonConfig.instance:getEpisodeIndex(normalEpisodeId)
	local index = VersionActivityFixedDungeonConfig.instance:getEpisodeIndex(episodeId)

	return episodeIndex <= index
end

function Act248Model:isUnlockAct248()
	local actId = self:getActId()

	if not ActivityHelper.isOpen(actId) then
		return
	end

	local normalEpisodeId = self:getNormalEpisodeId()
	local isUnlock = DungeonModel.instance:hasPassLevel(normalEpisodeId)

	if not isUnlock then
		return
	end

	return true
end

Act248Model.instance = Act248Model.New()

return Act248Model
