﻿-- chunkname: @modules/logic/playercard/model/PlayerCardAchievementSelectListModel.lua

module("modules.logic.playercard.model.PlayerCardAchievementSelectListModel", package.seeall)

local PlayerCardAchievementSelectListModel = class("PlayerCardAchievementSelectListModel", ListScrollModel)

function PlayerCardAchievementSelectListModel:initDatas(tabType)
	self._curCategory = tabType or 1
	self.isGroup = false

	self:decodeShowAchievement()

	self.isGroup = self:getGroupSelectedCount() > 0
	self.infoDict = self:packInfos()
	self.moTypeCache = {}
	self.moTypeGroupCache = {}
	self._itemAniHasShownIndex = 0

	self:refreshTabData()
end

function PlayerCardAchievementSelectListModel:release()
	self.moTypeCache = nil
	self.moTypeGroupCache = nil
	self.singleSet = nil
	self.singleSelectList = nil
	self.groupSet = nil
	self.selectSingleCategoryMap = nil
	self.selectGroupCategoryMap = nil
end

function PlayerCardAchievementSelectListModel:packInfos()
	local infoDict = {}

	for category, v in ipairs(AchievementEnum.Type) do
		infoDict[category] = {}
	end

	local allCfgList = AchievementConfig.instance:getAllAchievements()

	for i, cfg in ipairs(allCfgList) do
		infoDict[cfg.category] = infoDict[cfg.category] or {}

		local list = infoDict[cfg.category]

		table.insert(list, cfg)
	end

	return infoDict
end

function PlayerCardAchievementSelectListModel:decodeShowAchievement()
	local showStr = PlayerCardModel.instance:getShowAchievement()
	local singeTaskSet, groupTaskSet = AchievementUtils.decodeShowStr(showStr)

	self.singleSet = {}
	self.singleSelectList = {}

	for _, taskId in ipairs(singeTaskSet) do
		local taskCO = AchievementConfig.instance:getTask(taskId)

		self.singleSet[taskCO.achievementId] = true

		table.insert(self.singleSelectList, taskCO.achievementId)
		self:updateSingleSelectCategoryMap(taskCO.achievementId, true)
	end

	self.groupSet = {}
	self.groupSelectList = {}

	for _, taskId in pairs(groupTaskSet) do
		local taskCO = AchievementConfig.instance:getTask(taskId)

		if taskCO then
			local achievementCO = AchievementConfig.instance:getAchievement(taskCO.achievementId)

			if achievementCO.groupId ~= 0 and not self.groupSet[achievementCO.groupId] then
				self.groupSet[achievementCO.groupId] = true

				table.insert(self.groupSelectList, achievementCO.groupId)
				self:updateGroupSelectCategoryMap(achievementCO.groupId, true)
			end
		end
	end

	self.originSingleSet = tabletool.copy(self.singleSet)
	self.originGroupSet = tabletool.copy(self.groupSet)
	self.originSingleSelectList = tabletool.copy(self.singleSelectList)
	self.originGroupSelectList = tabletool.copy(self.groupSelectList)
end

function PlayerCardAchievementSelectListModel:resumeToOriginSelect()
	self.groupSet = tabletool.copy(self.originGroupSet)
	self.singleSet = tabletool.copy(self.originSingleSet)
	self.singleSelectList = tabletool.copy(self.originSingleSelectList)
	self.groupSelectList = tabletool.copy(self.originGroupSelectList)

	self:buildSelectCategoryMap()
end

function PlayerCardAchievementSelectListModel:buildSelectCategoryMap()
	self.selectSingleCategoryMap = {}
	self.selectGroupCategoryMap = {}

	if self.singleSelectList then
		for _, achievementId in ipairs(self.singleSelectList) do
			self:updateSingleSelectCategoryMap(achievementId, true)
		end
	end

	if self.groupSelectList then
		for _, groupId in ipairs(self.groupSelectList) do
			self:updateGroupSelectCategoryMap(groupId, true)
		end
	end
end

function PlayerCardAchievementSelectListModel:updateSingleSelectCategoryMap(achievementId, isSelect)
	local achievementCfg = AchievementConfig.instance:getAchievement(achievementId)

	if achievementCfg then
		local category = achievementCfg.category

		if isSelect then
			self.selectSingleCategoryMap = self.selectSingleCategoryMap or {}
			self.selectSingleCategoryMap[category] = self.selectSingleCategoryMap[category] or {}
			self.selectSingleCategoryMap[category][achievementId] = true
		elseif not isSelect and self.selectSingleCategoryMap and self.selectSingleCategoryMap[category] then
			self.selectSingleCategoryMap[category][achievementId] = nil
		end
	end
end

function PlayerCardAchievementSelectListModel:updateGroupSelectCategoryMap(groupId, isSelect)
	local groupCfg = AchievementConfig.instance:getGroup(groupId)

	if groupCfg then
		local category = groupCfg.category

		if isSelect then
			self.selectGroupCategoryMap = self.selectGroupCategoryMap or {}
			self.selectGroupCategoryMap[category] = self.selectGroupCategoryMap[category] or {}
			self.selectGroupCategoryMap[category][groupId] = isSelect
		elseif not isSelect and self.selectGroupCategoryMap and self.selectGroupCategoryMap[category] then
			self.selectGroupCategoryMap[category][groupId] = nil
		end
	end
end

function PlayerCardAchievementSelectListModel:setTab(tabType)
	self._curCategory = tabType

	if self:checkIsNamePlate() then
		self.isGroup = false
	end

	self:refreshTabData()
end

function PlayerCardAchievementSelectListModel:setIsSelectGroup(isGroup)
	self.isGroup = isGroup

	self:refreshTabData()
end

function PlayerCardAchievementSelectListModel:refreshTabData()
	if not self.infoDict then
		return
	end

	local targetCache = self.isGroup and self.moTypeGroupCache or self.moTypeCache
	local moList = targetCache[self._curCategory]

	if not moList then
		if self.isGroup then
			moList = self:buildGroupMOList(self._curCategory)
		elseif self._curCategory == AchievementEnum.Type.NamePlate then
			self:clearAllSelect()

			moList = self:buildNamePlateMOList(self._curCategory)
		else
			moList = self:buildSingleMOList(self._curCategory)
		end

		targetCache[self._curCategory] = moList
	end

	self:setList(moList)
end

function PlayerCardAchievementSelectListModel:buildNamePlateMOList(category)
	local moList = {}
	local achievementList = {}
	local targetList = self.infoDict[category]

	if not targetList then
		return moList
	end

	table.sort(targetList, self.sortAchievement)

	for _, cfg in ipairs(targetList) do
		local level = AchievementModel.instance:getAchievementLevel(cfg.id)
		local taskCO = AchievementConfig.instance:getTaskByAchievementLevel(cfg.id, level)

		if level > 0 then
			local mo = {}

			mo.achievementId = cfg.id
			mo.taskCo = taskCO
			mo.maxLevel = level
			mo.taskId = taskCO.id
			mo.co = cfg

			table.insert(achievementList, mo)
		end
	end

	if #achievementList > 0 then
		self:buildMO(moList, achievementList, 0)
	end

	return moList
end

function PlayerCardAchievementSelectListModel:buildSingleMOList(category)
	local moList = {}
	local achievementList = {}
	local targetList = self.infoDict[category]

	if not targetList then
		return moList
	end

	table.sort(targetList, self.sortAchievement)

	for _, cfg in ipairs(targetList) do
		local level = AchievementModel.instance:getAchievementLevel(cfg.id)

		if level > 0 then
			if #achievementList >= AchievementEnum.MainListLineCount then
				self:buildMO(moList, achievementList, 0)

				achievementList = {}
			end

			table.insert(achievementList, cfg)
		end
	end

	if #achievementList > 0 then
		self:buildMO(moList, achievementList, 0)
	end

	return moList
end

function PlayerCardAchievementSelectListModel:buildGroupMOList(category)
	local moList = {}
	local achievementList = {}
	local targetList = self.infoDict[category]

	if not targetList then
		return moList
	end

	table.sort(targetList, self.sortAchievement)

	local lastGroupId = 0

	for _, cfg in ipairs(targetList) do
		if AchievementUtils.isActivityGroup(cfg.id) then
			if lastGroupId ~= cfg.groupId then
				if lastGroupId == 0 then
					lastGroupId = cfg.groupId
				else
					self:buildMO(moList, achievementList, lastGroupId)

					achievementList = {}
					lastGroupId = cfg.groupId
				end
			end

			table.insert(achievementList, cfg)
		end
	end

	if #achievementList > 0 then
		self:buildMO(moList, achievementList, lastGroupId)
	end

	return moList
end

function PlayerCardAchievementSelectListModel:buildMO(moList, achievementList, groupId)
	if groupId ~= 0 then
		local hasFinished = false

		for _, achievementCO in ipairs(achievementList) do
			local level = AchievementModel.instance:getAchievementLevel(achievementCO.id)

			if level > 0 then
				hasFinished = true

				break
			end
		end

		if not hasFinished then
			return
		end
	end

	local mo = AchievementTileMO.New()

	mo:init(achievementList, groupId)
	table.insert(moList, mo)
end

function PlayerCardAchievementSelectListModel.sortAchievement(a, b)
	local aIsSelected = PlayerCardAchievementSelectListModel.instance:checkIsSelected(a)
	local bIsSelected = PlayerCardAchievementSelectListModel.instance:checkIsSelected(b)

	if aIsSelected ~= bIsSelected then
		return aIsSelected
	elseif aIsSelected and bIsSelected then
		local isGroup = PlayerCardAchievementSelectListModel.instance.isGroup
		local sortList = isGroup and PlayerCardAchievementSelectListModel.instance.groupSelectList or PlayerCardAchievementSelectListModel.instance.singleSelectList
		local aOrderIndex = tabletool.indexOf(sortList, isGroup and a.groupId or a.id) or 0
		local bOrderIndex = tabletool.indexOf(sortList, isGroup and b.groupId or b.id) or 0

		return aOrderIndex < bOrderIndex
	end

	local aGroup = a.groupId ~= 0
	local bGroup = b.groupId ~= 0

	if aGroup ~= bGroup then
		return not aGroup
	end

	if aGroup then
		if a.groupId ~= b.groupId then
			local aGroupCfg = AchievementConfig.instance:getGroup(a.groupId)
			local bGroupCfg = AchievementConfig.instance:getGroup(b.groupId)

			if aGroupCfg and bGroupCfg and aGroupCfg.order ~= bGroupCfg.order then
				return aGroupCfg.order < bGroupCfg.order
			end

			return a.groupId < b.groupId
		end

		if a.order ~= b.order then
			return a.order < b.order
		end
	end

	return a.id < b.id
end

function PlayerCardAchievementSelectListModel:checkIsSelected(achievementCfg)
	if self.isGroup and achievementCfg.groupId ~= 0 then
		return self:isGroupSelected(achievementCfg.groupId)
	else
		local taskCfgs = AchievementConfig.instance:getTasksByAchievementId(achievementCfg.id)

		if taskCfgs then
			for _, v in pairs(taskCfgs) do
				if self:isSingleSelected(v.id) then
					return true
				end
			end
		end

		return false
	end
end

function PlayerCardAchievementSelectListModel:getInfoList(scrollGO)
	local mixCellInfos = {}
	local list = self:getList()

	for i, mo in ipairs(list) do
		local mixCellInfo = SLFramework.UGUI.MixCellInfo.New(i, mo:getLineHeight(), i)

		table.insert(mixCellInfos, mixCellInfo)
	end

	return mixCellInfos
end

function PlayerCardAchievementSelectListModel:isSingleSelected(taskId)
	local taskCO = AchievementConfig.instance:getTask(taskId)

	if taskCO then
		return self.singleSet[taskCO.achievementId]
	end

	return false
end

function PlayerCardAchievementSelectListModel:getSelectOrderIndex(taskId)
	local taskCO = AchievementConfig.instance:getTask(taskId)

	if taskCO then
		return tabletool.indexOf(self.singleSelectList, taskCO.achievementId)
	end
end

function PlayerCardAchievementSelectListModel:isGroupSelected(groupId)
	return self.groupSet[groupId]
end

function PlayerCardAchievementSelectListModel:getSingleSelectedCount()
	return tabletool.len(self.singleSet)
end

function PlayerCardAchievementSelectListModel:getGroupSelectedCount()
	return tabletool.len(self.groupSet)
end

function PlayerCardAchievementSelectListModel:setSingleSelect(taskId, isSelect)
	local taskCO = AchievementConfig.instance:getTask(taskId)

	if not taskCO then
		return
	end

	tabletool.removeValue(self.singleSelectList, taskCO.achievementId)

	if isSelect then
		self.singleSet[taskCO.achievementId] = true

		table.insert(self.singleSelectList, taskCO.achievementId)
	else
		self.singleSet[taskCO.achievementId] = nil
	end

	self:updateSingleSelectCategoryMap(taskCO.achievementId, isSelect)
end

function PlayerCardAchievementSelectListModel:setGroupSelect(groupId, isSelect)
	tabletool.removeValue(self.groupSelectList, groupId)

	if isSelect then
		self.groupSet[groupId] = true

		table.insert(self.groupSelectList, groupId)
	else
		self.groupSet[groupId] = nil
	end

	self:updateGroupSelectCategoryMap(groupId, isSelect)
end

function PlayerCardAchievementSelectListModel:getSaveRequestParam()
	local taskIdList = {}
	local groupIdResult = 0

	if self.isGroup then
		for _, groupId in ipairs(self.groupSelectList) do
			self:fillGroupTaskIds(taskIdList, groupId)

			groupIdResult = groupId
		end
	else
		for _, achievementId in ipairs(self.singleSelectList) do
			self:fillSingleTaskId(taskIdList, achievementId)
		end
	end

	return taskIdList, groupIdResult
end

function PlayerCardAchievementSelectListModel:getCurrentCategory()
	return self._curCategory
end

function PlayerCardAchievementSelectListModel:checkIsNamePlate()
	return self._curCategory == AchievementEnum.Type.NamePlate
end

function PlayerCardAchievementSelectListModel:fillGroupTaskIds(taskIdList, groupId)
	local achievementCOs = AchievementConfig.instance:getAchievementsByGroupId(groupId)

	for _, achievementCO in ipairs(achievementCOs) do
		self:fillSingleTaskId(taskIdList, achievementCO.id)
	end
end

function PlayerCardAchievementSelectListModel:fillSingleTaskId(taskIdList, achievementId)
	local level = AchievementModel.instance:getAchievementLevel(achievementId)

	if level > 0 then
		local taskCO = AchievementConfig.instance:getTaskByAchievementLevel(achievementId, level)

		if taskCO ~= nil then
			table.insert(taskIdList, taskCO.id)
		end
	end
end

function PlayerCardAchievementSelectListModel:checkDirty(isGroup)
	if isGroup then
		if tabletool.len(self.groupSet) == tabletool.len(self.originGroupSet) then
			for k, v in pairs(self.groupSet) do
				if v ~= self.originGroupSet[k] then
					return true
				end
			end
		else
			return true
		end
	elseif #self.singleSelectList == #self.originSingleSelectList then
		for k, v in ipairs(self.singleSelectList) do
			if v ~= self.originSingleSelectList[k] then
				return true
			end
		end
	else
		return true
	end

	return false
end

function PlayerCardAchievementSelectListModel:clearAllSelect()
	self.singleSet = {}
	self.singleSelectList = {}
	self.groupSet = {}
	self.groupSelectList = {}
	self.selectSingleCategoryMap = {}
	self.selectGroupCategoryMap = {}
end

function PlayerCardAchievementSelectListModel:getSelectCount()
	if self.isGroup then
		return self.groupSet and tabletool.len(self.groupSet) or 0
	else
		return self.singleSet and tabletool.len(self.singleSet) or 0
	end
end

function PlayerCardAchievementSelectListModel:getSelectCountByCategory(category)
	local selectMap = self.isGroup and self.selectGroupCategoryMap or self.selectSingleCategoryMap
	local categoryMap = selectMap and selectMap[category]
	local categorySelectCount = categoryMap and tabletool.len(categoryMap) or 0

	return categorySelectCount
end

function PlayerCardAchievementSelectListModel:getItemAniHasShownIndex()
	return self._itemAniHasShownIndex
end

function PlayerCardAchievementSelectListModel:setItemAniHasShownIndex(index)
	self._itemAniHasShownIndex = index or 0
end

PlayerCardAchievementSelectListModel.instance = PlayerCardAchievementSelectListModel.New()

return PlayerCardAchievementSelectListModel
