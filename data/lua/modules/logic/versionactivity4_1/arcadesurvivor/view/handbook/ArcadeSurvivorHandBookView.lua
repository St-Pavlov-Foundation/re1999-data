-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/handbook/ArcadeSurvivorHandBookView.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.handbook.ArcadeSurvivorHandBookView", package.seeall)

local ArcadeSurvivorHandBookView = class("ArcadeSurvivorHandBookView", BaseView)

function ArcadeSurvivorHandBookView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._goview = gohelper.findChild(self.viewGO, "#go_view")
	self._scroll = gohelper.findChildScrollRect(self.viewGO, "#go_view/root/scroll")
	self._goitem = gohelper.findChild(self.viewGO, "#go_view/root/scroll/Viewport/Content/#go_item")
	self._simagehero = gohelper.findChildImage(self.viewGO, "#go_view/root/scroll/Viewport/Content/#go_item/unlock/#simage_hero")
	self._btnclose = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeSurvivorHandBookView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self:addEventCbs()
end

function ArcadeSurvivorHandBookView:removeEvents()
	self._btnclose:RemoveClickListener()
	self:removeEventCbs()
end

function ArcadeSurvivorHandBookView:_btncloseOnClick()
	self:closeThis()
end

function ArcadeSurvivorHandBookView:onClickModalMask()
	self:_btncloseOnClick()
end

function ArcadeSurvivorHandBookView:addEventCbs()
	self:addEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnCutHandBookTab, self._onCutHandBookTab, self)
	self:addEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnClickHandBookItem, self._onClickHandBookItem, self)
end

function ArcadeSurvivorHandBookView:removeEventCbs()
	self:removeEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnCutHandBookTab, self._onCutHandBookTab, self)
	self:removeEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnClickHandBookItem, self._onClickHandBookItem, self)
end

function ArcadeSurvivorHandBookView:_onClickHandBookItem(type, id)
	local tabItem = self._tabItems[type]

	tabItem:refreshReddot()
end

function ArcadeSurvivorHandBookView:_onCutHandBookTab(type)
	self:refreshView()
end

function ArcadeSurvivorHandBookView:_editableInitView()
	self._model = ArcadeSurvivorHandBookModel.instance
	self._gotab = gohelper.findChild(self.viewGO, "tab")

	gohelper.setActive(self._goitem, false)

	self._tabItems = self:getUserDataTb_()

	local categoryList = ArcadeSurvivorConfig.instance:getHandbookCategoryList()

	for i = 1, #categoryList do
		local go = gohelper.findChild(self._gotab, "#go_tab" .. i)

		if gohelper.isNil(go) then
			logError(string.format("ArcadeSurvivorHandBookView:_editableInitView error, tab go is nil, index:%s", i))

			break
		else
			local type = categoryList[i]
			local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, ArcadeSurvivorHandBookTabItem)

			item:onUpdateMO(type)

			self._tabItems[type] = item
		end
	end

	self._goContent = gohelper.findChild(self.viewGO, "#go_view/root/scroll/Viewport/Content")
	self._itemList = self:getUserDataTb_()
end

function ArcadeSurvivorHandBookView:onUpdateParam()
	return
end

function ArcadeSurvivorHandBookView:onOpen()
	self:refreshView()
	AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_interface_open)
end

function ArcadeSurvivorHandBookView:refreshView()
	self:_refreshItem()
	self:_refreshTab()
	self:_refreshReddot()

	self._scroll.verticalNormalizedPosition = 1
end

function ArcadeSurvivorHandBookView:_refreshTab()
	local curType, id = ArcadeSurvivorHandBookModel.instance:getShowCategoryType()

	for _type, item in pairs(self._tabItems) do
		item:onSelect(curType == _type)
	end
end

function ArcadeSurvivorHandBookView:_refreshReddot()
	local list = ArcadeSurvivorHandBookListModel.instance:getList()
	local curType, _ = ArcadeSurvivorHandBookModel.instance:getShowCategoryType()
	local clearNewIds = {}

	for i, mo in ipairs(list) do
		if not mo:isLock() and mo:isNew() then
			local id = mo:getId()

			clearNewIds[#clearNewIds + 1] = id
		end
	end

	if #clearNewIds > 0 then
		ArcadeSurvivorRpc.instance:sendArcadeSurvivorClearNewBookRequest(curType, clearNewIds, self._afterClearNew, self)
	end
end

function ArcadeSurvivorHandBookView:_afterClearNew(cmd, resultCode, msg)
	ArcadeSurvivorHallModel.instance:refreshHandBookReddot()
	ArcadeSurvivorController.instance:dispatchEvent(ArcadeSurvivorEvent.OnRefreshHallBuildingReddot, ArcadeSurvivorHallEnum.HallInteractiveUnitId.HandBook)
end

function ArcadeSurvivorHandBookView:_refreshItem()
	local list = ArcadeSurvivorHandBookListModel.instance:getList()

	for i, mo in ipairs(list) do
		local item = self:_getItem(i)

		item:onUpdateMO(mo)
	end

	for i = 1, #self._itemList do
		gohelper.setActive(self._itemList[i].viewGO, i <= #list)
	end

	local lastMO = list[#list]
	local _, sizeY = lastMO:getIconSize()
	local _, anchorY = lastMO:getAnchor()
	local itemParams = ArcadeSurvivorHallEnum.HandBookItemParams

	recthelper.setHeight(self._goContent.transform, sizeY + anchorY + itemParams.DiffY)
end

function ArcadeSurvivorHandBookView:_getItem(index)
	local item = self._itemList[index]

	if not item then
		local go = gohelper.cloneInPlace(self._goitem, "item_" .. index)

		item = MonoHelper.addNoUpdateLuaComOnceToGo(go, ArcadeSurvivorHandBookItem)
		self._itemList[index] = item
	end

	return item
end

function ArcadeSurvivorHandBookView:onClose()
	return
end

function ArcadeSurvivorHandBookView:onDestroyView()
	return
end

return ArcadeSurvivorHandBookView
