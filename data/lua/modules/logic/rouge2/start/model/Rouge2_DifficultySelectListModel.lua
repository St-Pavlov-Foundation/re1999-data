-- chunkname: @modules/logic/rouge2/start/model/Rouge2_DifficultySelectListModel.lua

module("modules.logic.rouge2.start.model.Rouge2_DifficultySelectListModel", package.seeall)

local Rouge2_DifficultySelectListModel = class("Rouge2_DifficultySelectListModel", ListScrollModel)

function Rouge2_DifficultySelectListModel:init()
	self._diffMap = {}
	self._difficultyList = Rouge2_Config.instance:getDifficultyCoList()

	local allPageList = {}
	local pageDiffList = {}

	for _, diffCo in ipairs(self._difficultyList) do
		local id = diffCo.difficulty

		self._diffMap[id] = diffCo

		table.insert(pageDiffList, diffCo)

		if #pageDiffList >= Rouge2_Enum.DifficultyPageNum then
			table.insert(allPageList, pageDiffList)

			pageDiffList = {}
		end
	end

	if #pageDiffList > 0 then
		table.insert(allPageList, pageDiffList)

		pageDiffList = {}
	end

	self._curPageIndex = 1
	self._selectDiff = nil

	self:setList(allPageList)
end

function Rouge2_DifficultySelectListModel:selectDifficulty(difficulty)
	local diffCo = self._diffMap and self._diffMap[difficulty]

	if not diffCo or self._selectDiff == difficulty then
		return
	end

	self._selectDiff = difficulty

	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnSelectDifficulty, difficulty)
end

function Rouge2_DifficultySelectListModel:getCurSelectDifficulty()
	return self._selectDiff
end

function Rouge2_DifficultySelectListModel:isPageUnlock(pageIndex)
	local pageNum = self:getCount()

	if pageIndex < 0 or pageNum < pageIndex then
		return false
	end

	local pageDiffList = self:getByIndex(pageIndex)

	if not pageDiffList then
		return false
	end

	for _, diffCo in ipairs(pageDiffList) do
		local diffId = diffCo.difficulty
		local isUnlock = Rouge2_OutsideModel.instance:isOpenedDifficulty(diffId)

		if isUnlock then
			return true
		end
	end

	return false, ToastEnum.Rouge2LockDifficulty
end

function Rouge2_DifficultySelectListModel:canSwitchPage(isNext)
	local targetPageIndex = isNext and self._curPageIndex + 1 or self._curPageIndex - 1

	return self:isPageUnlock(targetPageIndex)
end

function Rouge2_DifficultySelectListModel:switchPage(isNext)
	local tagetPageIndex = isNext and self._curPageIndex + 1 or self._curPageIndex - 1

	return self:switch2TargetPage(tagetPageIndex)
end

function Rouge2_DifficultySelectListModel:switch2TargetPage(pageIndex)
	local canSwitch, toastId = self:isPageUnlock(pageIndex)

	if not canSwitch then
		return false, toastId
	end

	self._curPageIndex = pageIndex

	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnSwitchDifficultyPage, self._curPageIndex)

	local diffList = self:getByIndex(pageIndex)
	local selectDiffCo = diffList and diffList[1]

	self:selectDifficulty(selectDiffCo.difficulty)

	return true
end

function Rouge2_DifficultySelectListModel:selectNewestDifficulty()
	for i = self:getCount(), 1, -1 do
		local pageMo = self:getByIndex(i)
		local difficultyNum = pageMo and #pageMo or 0

		for j = difficultyNum, 1, -1 do
			local diffCo = pageMo[j]
			local difficulty = diffCo.difficulty
			local isUnlock = Rouge2_OutsideModel.instance:isOpenedDifficulty(difficulty)

			if isUnlock then
				self:switch2TargetPage(i)
				self:selectDifficulty(difficulty)

				return
			end
		end
	end
end

Rouge2_DifficultySelectListModel.instance = Rouge2_DifficultySelectListModel.New()

return Rouge2_DifficultySelectListModel
