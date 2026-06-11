-- chunkname: @modules/logic/necrologiststory/view/NecrologistStoryBranchView.lua

module("modules.logic.necrologiststory.view.NecrologistStoryBranchView", package.seeall)

local NecrologistStoryBranchView = class("NecrologistStoryBranchView", BaseView)

function NecrologistStoryBranchView:onInitView()
	self.scroll = gohelper.findChildScrollRect(self.viewGO, "#scroll_view")
	self.goRect = gohelper.findChild(self.viewGO, "#scroll_view/Viewport")
	self.transformRect = self.goRect.transform
	self.goContent = gohelper.findChild(self.viewGO, "#scroll_view/Viewport/Content")
	self.goSectionItem = gohelper.findChild(self.viewGO, "#scroll_view/Viewport/Content/#go_sectionitem")

	gohelper.setActive(self.goSectionItem, false)

	self.itemList = {}
	self.goTabItem = gohelper.findChild(self.viewGO, "#scroll_tab/Viewport/Content/#go_tabitem")

	gohelper.setActive(self.goTabItem, false)

	self.tabItemList = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function NecrologistStoryBranchView:addEvents()
	self.scroll:AddOnValueChanged(self._onScrollChange, self)
end

function NecrologistStoryBranchView:removeEvents()
	self.scroll:RemoveOnValueChanged()
end

function NecrologistStoryBranchView:_editableInitView()
	return
end

function NecrologistStoryBranchView:onOpen()
	self:onUpdateParam()
end

function NecrologistStoryBranchView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function NecrologistStoryBranchView:refreshParam()
	local viewParam = self.viewParam or {}

	self.storyId = viewParam.roleStoryId or 26
end

function NecrologistStoryBranchView:refreshView()
	local list = NecrologistStoryConfig.instance:getOptionListByStoryId(self.storyId)
	local dataCount = #list
	local optionsList = {}

	for i = 1, math.max(dataCount, #self.itemList) do
		local item = self.itemList[i] or self:createSectionItem(i)
		local tabItem = self.tabItemList[i] or self:createTabItem(i)

		item:setTabItem(tabItem)
		item:setIndex(i, dataCount)
		item:onUpdateMO(list[i])
		item:addOptionDataList(optionsList)
	end

	local branchDataList = {}
	local lastStoryGroup, curStoryGroup
	local branchCount = 0

	for i, options in ipairs(optionsList) do
		table.insert(branchDataList, {
			options
		})

		branchCount = branchCount + 1
		curStoryGroup = options[1].config.storygroup

		if branchCount > 1 then
			if curStoryGroup - lastStoryGroup <= 1 then
				table.insert(branchDataList[branchCount - 1], options)
			else
				table.insert(branchDataList, branchCount, {
					[2] = options
				})

				branchCount = branchCount + 1
			end
		end

		lastStoryGroup = curStoryGroup
	end

	local curIndex = 0

	for i = 1, #list do
		local item = self.itemList[i]
		local useCount = item:refreshBranchs(branchDataList, curIndex)

		curIndex = curIndex + useCount
	end

	TaskDispatcher.cancelTask(self.refreshTabShowState, self)
	TaskDispatcher.runDelay(self.refreshTabShowState, self, 0.1)
end

function NecrologistStoryBranchView:createSectionItem(index)
	local go = gohelper.cloneInPlace(self.goSectionItem, tostring(index))
	local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, NecrologistStoryBranchSectionItem)

	self.itemList[index] = item

	return item
end

function NecrologistStoryBranchView:createTabItem(index)
	local item = self:getUserDataTb_()

	item.index = index
	item.go = gohelper.cloneInPlace(self.goTabItem, tostring(index))
	item.goSelect = gohelper.findChild(item.go, "select")
	item.goUnSelect = gohelper.findChild(item.go, "unselect")
	item.txtSelectIndex = gohelper.findChildTextMesh(item.go, "select/#txt_section")
	item.txtUnSelectIndex = gohelper.findChildTextMesh(item.go, "unselect/#txt_section")
	item.goLight = gohelper.findChild(item.go, "Light")
	item.goUnLight = gohelper.findChild(item.go, "unLight")
	item.btnClick = gohelper.findChildButtonWithAudio(item.go, "#btn_click")

	item.btnClick:AddClickListener(self.onClickTabItem, self, item)

	self.tabItemList[index] = item

	return item
end

function NecrologistStoryBranchView:onClickTabItem(item)
	self:moveToByIndex(item.index, 0.2)
end

function NecrologistStoryBranchView:_onScrollChange(value)
	self:refreshTabShowState()
end

function NecrologistStoryBranchView:refreshTabShowState()
	local frontIndex = 0

	for i, item in ipairs(self.itemList) do
		if item and item.viewGO then
			local screenPosX, screenPosY = recthelper.uiPosToScreenPos2(item.transformPos)
			local isInRect = recthelper.screenPosInRect(self.transformRect, nil, screenPosX, screenPosY)

			if isInRect then
				frontIndex = i

				break
			end
		end
	end

	self:refreshTabList(frontIndex)
end

function NecrologistStoryBranchView:refreshTabList(showIndex)
	for i, v in ipairs(self.tabItemList) do
		gohelper.setActive(v.goSelect, i == showIndex)
		gohelper.setActive(v.goUnSelect, i ~= showIndex)
	end
end

function NecrologistStoryBranchView:moveToByIndex(moveIndex, time)
	local item = self.itemList[moveIndex]

	if not item then
		return
	end

	local content = self.goContent.transform
	local posX = item:getTransformPos()
	local moveLimt = 0
	local contentWidth = recthelper.getWidth(content)
	local scrollWidth = recthelper.getWidth(self.transformRect)
	local widthOffset = contentWidth - scrollWidth

	moveLimt = math.max(0, widthOffset)
	posX = math.min(moveLimt, posX)
	posX = -posX

	if self._moveTweenId then
		ZProj.TweenHelper.KillById(self._moveTweenId)

		self._moveTweenId = nil
	end

	if time and time > 0 then
		self._moveTweenId = ZProj.TweenHelper.DOAnchorPosX(content, posX, time)
	else
		recthelper.setAnchorX(content, posX)
	end
end

function NecrologistStoryBranchView:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshTabShowState, self)

	for i, v in ipairs(self.tabItemList) do
		v.btnClick:RemoveClickListener()
	end

	if self._moveTweenId then
		ZProj.TweenHelper.KillById(self._moveTweenId)

		self._moveTweenId = nil
	end
end

return NecrologistStoryBranchView
