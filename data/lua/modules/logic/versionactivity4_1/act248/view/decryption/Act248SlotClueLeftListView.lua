-- chunkname: @modules/logic/versionactivity4_1/act248/view/decryption/Act248SlotClueLeftListView.lua

module("modules.logic.versionactivity4_1.act248.view.decryption.Act248SlotClueLeftListView", package.seeall)

local Act248SlotClueLeftListView = class("Act248SlotClueLeftListView", Act248ClueLeftListView)

function Act248SlotClueLeftListView:addEvents()
	Act248SlotClueLeftListView.super.addEvents(self)
	self:addEventCb(Act248Controller.instance, Act248Event.onFillClueItem, self._onFillClueItem, self)
	self:addEventCb(Act248Controller.instance, Act248Event.onConfirmFillClue, self._onConfirmFillClue, self, LuaEventSystem.Low)
end

function Act248SlotClueLeftListView:removeEvents()
	Act248SlotClueLeftListView.super.removeEvents(self)
	self:removeEventCb(Act248Controller.instance, Act248Event.onFillClueItem, self._onFillClueItem, self)
	self:removeEventCb(Act248Controller.instance, Act248Event.onConfirmFillClue, self._onConfirmFillClue, self)
end

function Act248SlotClueLeftListView:onOpen()
	self._fileMo = self.viewParam.fileMo
	self._correctClueIds = {}

	for _, slotGroupMo in ipairs(self._fileMo:getSlotMos()) do
		local mos = slotGroupMo:getMos()

		for _, mo in ipairs(mos) do
			self._correctClueIds[mo:getCorrectClueId()] = true
		end
	end

	self:_initOpenClue()
	self:_initCategory()
end

function Act248SlotClueLeftListView:_onConfirmFillClue()
	self:_refreshFillClues()
end

function Act248SlotClueLeftListView:_initOpenClue()
	return
end

function Act248SlotClueLeftListView:_onClickClueItem()
	self:_refreshFillClues()
end

function Act248SlotClueLeftListView:_onFillClueItem()
	self:_refreshFillClues()
end

function Act248SlotClueLeftListView:getFileId()
	return self._fileMo.id
end

function Act248SlotClueLeftListView:_refreshFillClues()
	local fillClues = self.viewContainer:getEditorFillClues()
	local showClueId = self.viewContainer:getSelectClueId()

	if self._categoryChildItems then
		for i, item in ipairs(self._categoryChildItems) do
			local clueId = item.clueId
			local isFill = fillClues[clueId]
			local isSelect = showClueId == clueId

			item:refreshStatus(isFill, isSelect)
		end
	end

	local categoryDict = {}

	if fillClues then
		for clueId in pairs(fillClues) do
			local clueMo = Act248Model.instance:getClueById(clueId)
			local categorys = clueMo:getCategorys()

			for _, v in ipairs(categorys) do
				if not categoryDict[v] then
					categoryDict[v] = 0
				end

				categoryDict[v] = categoryDict[v] + 1
			end
		end
	end

	if self._categoryItems then
		for i, item in ipairs(self._categoryItems) do
			local num = categoryDict[item.category] or 0

			item:showNum(num)
		end
	end
end

function Act248SlotClueLeftListView:_addShowClueList(showClueList, mo)
	if not LuaUtil.tableContains(showClueList, mo) and mo:isCategory(self._openCategoryId) then
		table.insert(showClueList, mo)
	end
end

function Act248SlotClueLeftListView:_checkAddShowClueList(showClueList, mo)
	local coverMo = mo:isCover()
	local co = mo:getConfig()

	if not coverMo and co.coverId == 0 then
		self:_addShowClueList(showClueList, mo)
	elseif self._correctClueIds[mo.id] then
		self:_addShowClueList(showClueList, mo)
	elseif coverMo then
		self:_checkAddShowClueList(showClueList, coverMo)
	elseif co.coverId > 0 and not self._correctClueIds[co.coverId] then
		self:_addShowClueList(showClueList, mo)
	end
end

function Act248SlotClueLeftListView:_refreshOpenCategory()
	local clueList = Act248Model.instance:getClueListByCategory(self._openCategoryId)
	local showClueId = self.viewContainer:getSelectClueId()
	local root

	for i, item in ipairs(self._categoryItems) do
		local category = item.category

		if self._openCategoryId == category then
			root = item:getChildRoot()
		end

		item:onSelect(self._openCategoryId == category)
	end

	local count = 0
	local showClueList = {}
	local fileId = self:getFileId()

	if clueList then
		for i, mo in ipairs(clueList) do
			if mo:isShowInFile(fileId) then
				self:_checkAddShowClueList(showClueList, mo)
			end
		end
	end

	table.sort(showClueList, function(a, b)
		return a.id < b.id
	end)

	for i, mo in ipairs(showClueList) do
		count = count + 1

		local item = self:_getCategoryChildItem(i, root)

		item.clueId = mo:getClueId()

		item:onUpdateMO(mo, i)
	end

	for i, item in ipairs(self._categoryChildItems) do
		item:onSelect(item.clueId == showClueId)
		gohelper.setActive(item.viewGO, i <= count)

		if count < i then
			item.clueId = nil
		end
	end

	local groupsList = Act248Model.instance:getClueGroupList()
	local mo = self._openCategoryId and groupsList[self._openCategoryId]

	if mo then
		self._topCategoryItem:onUpdateMO(mo)
	end

	self:_refreshFillClues()
end

function Act248SlotClueLeftListView:_getClueCategoryChildItem()
	return Act248SlotClueCategoryChildItem
end

function Act248SlotClueLeftListView:showTitle()
	gohelper.setActive(self._goTitle1, false)
	gohelper.setActive(self._goTitle2, true)
end

function Act248SlotClueLeftListView:showView(slotGroupMo)
	if self._categoryChildItems then
		for i, item in ipairs(self._categoryChildItems) do
			item:onReset()
		end
	end

	self._txtTitle2.text = slotGroupMo and slotGroupMo:getCatrgoryCo().name

	local showClueId = self.viewContainer:getSelectClueId()

	if showClueId and showClueId > 0 then
		local category = Act248Model.instance:getCategoryByClueId(showClueId)

		self:_onOpenClueCategory(category, true)
	end
end

function Act248SlotClueLeftListView:hideView()
	return
end

function Act248SlotClueLeftListView:onSelectClueId(id)
	self:_onClickClueItem()

	if not id or id == 0 then
		local slotMo = self.viewContainer:getSelectSlotMo()

		if slotMo then
			local co = slotMo:getConfig()
			local category = co.tagId

			if category then
				self:_onOpenClueCategory(category, true)
			end
		end

		return
	end

	if id then
		local category = Act248Model.instance:getCategoryByClueId(id)

		self:_onOpenClueCategory(category, true)
	end
end

return Act248SlotClueLeftListView
