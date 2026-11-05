-- chunkname: @modules/logic/versionactivity4_1/act248/view/clue/Act248ClueLeftListView.lua

module("modules.logic.versionactivity4_1.act248.view.clue.Act248ClueLeftListView", package.seeall)

local Act248ClueLeftListView = class("Act248ClueLeftListView", BaseView)

function Act248ClueLeftListView:onInitView()
	self._scrollcategory = gohelper.findChildScrollRect(self.viewGO, "scroll_category")
	self._gocategorycontent = gohelper.findChild(self.viewGO, "scroll_category/viewport/#go_categorycontent")
	self._gocategoryitem = gohelper.findChild(self.viewGO, "scroll_category/viewport/#go_categorycontent/#go_categoryitem")
	self._gochilditem = gohelper.findChild(self.viewGO, "scroll_category/viewport/#go_categorycontent/#go_childitem")
	self._goTitle1 = gohelper.findChild(self.viewGO, "simage_title")
	self._goTitle2 = gohelper.findChild(self.viewGO, "title")
	self._txtTitle2 = gohelper.findChildText(self.viewGO, "title/#txt_title")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act248ClueLeftListView:addEvents()
	self._scrollcategory:AddOnValueChanged(self._onScrollChange, self)
	self:addEventCb(Act248Controller.instance, Act248Event.onOpenClueCategory, self._onOpenClueCategory, self)
	self:addEventCb(Act248Controller.instance, Act248Event.onClickClueItem, self._onClickClueItem, self)
end

function Act248ClueLeftListView:removeEvents()
	self._scrollcategory:RemoveOnValueChanged()
	self:removeEventCb(Act248Controller.instance, Act248Event.onOpenClueCategory, self._onOpenClueCategory, self)
	self:removeEventCb(Act248Controller.instance, Act248Event.onClickClueItem, self._onClickClueItem, self)
end

local CategoryHight = 110

function Act248ClueLeftListView:_onScrollChange()
	local curStage = self._openCategoryId

	if not curStage then
		gohelper.setActive(self._topCategoryItem.viewGO, false)

		return
	end

	local curContentPosY = recthelper.getAnchorY(self._scrollcategory.content.transform)
	local canShowStageInfo = curContentPosY > (curStage - 1) * CategoryHight

	if canShowStageInfo and not self._topCategoryItem.viewGO.activeSelf then
		self._topCategoryItem:_refreshNew()
	end

	gohelper.setActive(self._topCategoryItem.viewGO, canShowStageInfo)

	local maskTopPadding = canShowStageInfo and CategoryHight or 0

	self._viewportMask2D.padding = Vector4(0, 0, -150, maskTopPadding)
end

function Act248ClueLeftListView:_onOpenClueCategory(category, isSelect)
	if category == self._openCategoryId and isSelect then
		return
	end

	if isSelect then
		self._openCategoryId = category
	else
		self._openCategoryId = nil
	end

	if not self._openCategoryId then
		self._viewportMask2D.padding = Vector4(0, 0, -150, 0)
	end

	self:_refreshOpenCategory()
end

function Act248ClueLeftListView:_onClickClueItem()
	local showClueId = self.viewContainer:getSelectClueId()

	if self._categoryChildItems then
		for i, item in ipairs(self._categoryChildItems) do
			item:onSelect(item.clueId == showClueId)
		end
	end
end

function Act248ClueLeftListView:_editableInitView()
	self:showTitle()

	self._gocategorychilditem = gohelper.findChild(self.viewGO, "scroll_category/viewport/#go_categorycontent/#go_childitem")
	self._categoryItems = self:getUserDataTb_()
	self._categoryChildItems = self:getUserDataTb_()

	gohelper.setActive(self._gocategoryitem, false)
	gohelper.setActive(self._gocategorychilditem, false)

	local gotopCategory = gohelper.clone(self._gocategoryitem, self.viewGO, "topItem")

	gotopCategory.transform.anchorMin = Vector2.New(0.5, 1)
	gotopCategory.transform.anchorMax = Vector2.New(0.5, 1)
	self._topCategoryItem = MonoHelper.addNoUpdateLuaComOnceToGo(gotopCategory, Act248ClueCategoryItem)
	self._topCategoryItem.viewContainer = self.viewContainer

	gohelper.setActive(self._topCategoryItem.viewGO, false)
	self._topCategoryItem:onSelect(true)
	self._topCategoryItem:showNum()
	recthelper.setAnchor(gotopCategory.transform, 20, -161)
	recthelper.setHeight(gotopCategory.transform, CategoryHight)

	local viewport = gohelper.findChild(self.viewGO, "scroll_category/viewport")

	self._viewportMask2D = viewport:GetComponent(gohelper.Type_RectMask2D)
end

function Act248ClueLeftListView:showTitle()
	gohelper.setActive(self._goTitle1, true)
	gohelper.setActive(self._goTitle2, false)
end

function Act248ClueLeftListView:onUpdateParam()
	return
end

function Act248ClueLeftListView:onOpen()
	self:_initOpenClue()
	self:_initCategory()
	self:_refreshOpenCategory()
end

function Act248ClueLeftListView:_initOpenClue()
	local groupsList = Act248Model.instance:getClueGroupList()

	for i, info in ipairs(groupsList) do
		for _, mo in ipairs(info.list) do
			if mo:isUnlock() and not mo:isCover() then
				self._openCategoryId = i

				self.viewContainer:showClueInfo(mo.id)

				return
			end
		end
	end
end

function Act248ClueLeftListView:_initCategory()
	local groupsList = Act248Model.instance:getClueGroupList()

	self._categoryCount = 0

	if groupsList then
		for i, mo in ipairs(groupsList) do
			local category = mo.category
			local co = Act248Config.instance:getCategoryCo(category)

			if co.notShow == 0 then
				local item = self:_getCategoryItem(i)

				item:onUpdateMO(mo, i)

				item.category = mo.category
				self._categoryCount = self._categoryCount + 1
			end
		end
	end

	for i, item in ipairs(self._categoryItems) do
		gohelper.setActive(item.viewGO, i <= self._categoryCount)

		if i > #groupsList then
			item.category = nil
		end
	end
end

function Act248ClueLeftListView:getFileId()
	return
end

function Act248ClueLeftListView:_refreshOpenCategory()
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

	local fileId = self:getFileId()
	local count = 0

	if clueList then
		for i, mo in ipairs(clueList) do
			if mo:isShowInFile(fileId) then
				local coverMo = mo:isCover()

				if not coverMo then
					local isUnlock = mo:isUnlock()
					local co = mo:getConfig()

					if isUnlock or co.coverId == 0 then
						count = count + 1

						local item = self:_getCategoryChildItem(count, root)

						item.clueId = mo:getClueId()

						item:onUpdateMO(mo, i)
					end
				end
			end
		end
	end

	for i, item in ipairs(self._categoryChildItems) do
		item:onSelect(item.clueId == showClueId)
		item:playAnim(i <= count)

		if count < i then
			item.clueId = nil
		end
	end

	local groupsList = Act248Model.instance:getClueGroupList()
	local mo = self._openCategoryId and groupsList[self._openCategoryId]

	if mo then
		self._topCategoryItem:onUpdateMO(mo)
	end
end

function Act248ClueLeftListView:_getCategoryItem(index)
	local item = self._categoryItems[index]

	if not item then
		local go = gohelper.cloneInPlace(self._gocategoryitem, "category_" .. index)

		item = MonoHelper.addNoUpdateLuaComOnceToGo(go, Act248ClueCategoryItem)

		item:showNum()

		item.viewContainer = self.viewContainer
		self._categoryItems[index] = item
	end

	return item
end

function Act248ClueLeftListView:_getCategoryChildItem(index, root)
	local item = self._categoryChildItems[index]

	if not item then
		root = root or self._gocategorycontent

		local go = gohelper.clone(self._gocategorychilditem, root, "clueItem_" .. index)

		item = MonoHelper.addNoUpdateLuaComOnceToGo(go, self:_getClueCategoryChildItem())
		item.viewContainer = self.viewContainer
		self._categoryChildItems[index] = item
	else
		gohelper.addChild(root, item.viewGO)
	end

	gohelper.setSibling(item.viewGO, index)

	return item
end

function Act248ClueLeftListView:_getClueCategoryChildItem()
	return Act248ClueCategoryChildItem
end

function Act248ClueLeftListView:cancelAllClueNew()
	local fileId = self:getFileId()
	local groupsList = Act248Model.instance:getClueGroupList()
	local hasCancelNew = false

	if groupsList then
		for i, info in ipairs(groupsList) do
			local category = info.category
			local clueList = Act248Model.instance:getClueListByCategory(category)

			if clueList then
				for _, mo in ipairs(clueList) do
					if mo:isShowInFile(fileId) and mo:isNew() then
						mo:cancelNew()

						hasCancelNew = true
					end
				end
			end
		end
	end

	if hasCancelNew then
		Act248Controller.instance:dispatchEvent(Act248Event.OnRefreshNew)
		Act248Model.instance:refreshClueNew()
	end
end

function Act248ClueLeftListView:onClose()
	self:cancelAllClueNew()
end

function Act248ClueLeftListView:onDestroyView()
	return
end

return Act248ClueLeftListView
