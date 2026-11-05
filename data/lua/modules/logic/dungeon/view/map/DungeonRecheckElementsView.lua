-- chunkname: @modules/logic/dungeon/view/map/DungeonRecheckElementsView.lua

module("modules.logic.dungeon.view.map.DungeonRecheckElementsView", package.seeall)

local DungeonRecheckElementsView = class("DungeonRecheckElementsView", BaseView)

function DungeonRecheckElementsView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._scrollitem = gohelper.findChildScrollRect(self.viewGO, "#scroll_item")
	self._goitem = gohelper.findChild(self.viewGO, "#scroll_item/Viewport/Content/#go_item")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonRecheckElementsView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function DungeonRecheckElementsView:removeEvents()
	self._btnclose:RemoveClickListener()

	for _, item in ipairs(self._items) do
		item.btngoto:RemoveClickListener()
	end
end

function DungeonRecheckElementsView:_btncloseOnClick()
	self:closeThis()
end

function DungeonRecheckElementsView:onClickModalMask()
	self:closeThis()
end

function DungeonRecheckElementsView:_btngotoOnClick(index)
	local item = self:_getItem(index)

	self:_onRecheck(item.elementId)
end

function DungeonRecheckElementsView:_onRecheck(elementId)
	if not elementId then
		return
	end

	local elementCo = lua_chapter_map_element.configDict[elementId]

	if not elementCo then
		return
	end

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnRecheckElement, elementId, self.viewParam.isGM)
	self:closeThis()
end

function DungeonRecheckElementsView:_editableInitView()
	gohelper.setActive(self._goitem, false)

	self._items = self:getUserDataTb_()
	self._serialNumFunc = {
		[DungeonEnum.RecheckShowType.RomanNum] = GameUtil.getRomanNums
	}
end

function DungeonRecheckElementsView:onUpdateParam()
	return
end

function DungeonRecheckElementsView:_getElements(chapterId)
	if self.viewParam.isAll then
		local chapterElements = DungeonMapModel.instance:getChapterElements(chapterId)
		local list = {}

		if chapterElements then
			for _, co in ipairs(chapterElements) do
				if DungeonMapModel.instance:isCanRecheckElements(co) then
					table.insert(list, co.id)
				end
			end
		end

		return list
	end

	return DungeonMapModel.instance:getCanRecheckElements(chapterId)
end

function DungeonRecheckElementsView:onOpen()
	local chapterId = self.viewParam.chapterId

	self._canRecheckElements = self:_getElements(chapterId)

	if self._canRecheckElements then
		table.sort(self._canRecheckElements, function(a, b)
			local aco = lua_chapter_map_element.configDict[a]
			local bco = lua_chapter_map_element.configDict[b]
			local a_recheckCo = lua_paper_trail.configDict[aco.type]
			local b_recheckCo = lua_paper_trail.configDict[bco.type]
			local a_serialNum = a_recheckCo and a_recheckCo.serial or 0
			local b_serialNum = b_recheckCo and b_recheckCo.serial or 0

			if a_serialNum ~= b_serialNum then
				return a_serialNum < b_serialNum
			end

			if aco.mapId == bco.mapId then
				return a < b
			end

			return aco.mapId < bco.mapId
		end)

		local recheckTypeDic = {}

		for i, elementId in ipairs(self._canRecheckElements) do
			local item = self:_getItem(i)

			item.elementId = elementId

			local co = lua_chapter_map_element.configDict[elementId]

			if co then
				item.txtinfo.text = co.title

				local recheckCo = lua_paper_trail.configDict[co.type]
				local txtColor = Color.black
				local serialType = recheckCo and recheckCo.serial or DungeonEnum.RecheckShowType.Normal

				if not recheckTypeDic[serialType] then
					recheckTypeDic[serialType] = {}
				end

				table.insert(recheckTypeDic[serialType], elementId)

				if recheckCo and not string.nilorempty(recheckCo.color) then
					txtColor = GameUtil.parseColor(recheckCo.color)
				end

				local index = recheckTypeDic[serialType] and #recheckTypeDic[serialType] or i

				item.txtindex.text = self._serialNumFunc[serialType] and self._serialNumFunc[serialType](index) or index
				item.txtindex.color = txtColor
				item.txtinfo.color = txtColor
			end
		end
	end

	local count = self._canRecheckElements and #self._canRecheckElements

	for i, item in ipairs(self._items) do
		gohelper.setActive(item.go, i <= count)
	end
end

function DungeonRecheckElementsView:_getItem(index)
	local item = self._items[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._goitem, index)
		item.txtindex = gohelper.findChildText(item.go, "index")
		item.txtinfo = gohelper.findChildText(item.go, "info")
		item.btngoto = gohelper.findChildButtonWithAudio(item.go, "#btn_goto")
		self._items[index] = item

		item.btngoto:AddClickListener(self._btngotoOnClick, self, index)
	end

	return item
end

function DungeonRecheckElementsView:onClose()
	return
end

function DungeonRecheckElementsView:onDestroyView()
	return
end

return DungeonRecheckElementsView
