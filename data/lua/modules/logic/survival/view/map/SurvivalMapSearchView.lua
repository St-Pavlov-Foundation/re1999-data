﻿-- chunkname: @modules/logic/survival/view/map/SurvivalMapSearchView.lua

module("modules.logic.survival.view.map.SurvivalMapSearchView", package.seeall)

local SurvivalMapSearchView = class("SurvivalMapSearchView", BaseView)

function SurvivalMapSearchView:onInitView()
	self._anim = gohelper.findChildAnim(self.viewGO, "")
	self._btngetall = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_getall")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
	self._itemRoot = gohelper.findChild(self.viewGO, "root/scroll_collection/Viewport/Content")
	self._btnbag = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_bag")
	self._gobagfull = gohelper.findChild(self.viewGO, "#btn_bag/#go_overweight")
	self._goinfoview = gohelper.findChild(self.viewGO, "root/#go_infoview")
	self._goheavy = gohelper.findChild(self.viewGO, "root/go_heavy")
	self._gosort = gohelper.findChild(self.viewGO, "root/#go_sort")
end

function SurvivalMapSearchView:addEvents()
	self._btngetall:AddClickListener(self._onClickGetAll, self)
	self._btnclose:AddClickListener(self._closeEvent, self)
	self._btnbag:AddClickListener(self._onClickBag, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnSearchEventUpdate, self._onUpdateMos, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapBagUpdate, self._refreshBagFull, self)
end

function SurvivalMapSearchView:removeEvents()
	self._btngetall:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnbag:RemoveClickListener()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnSearchEventUpdate, self._onUpdateMos, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapBagUpdate, self._refreshBagFull, self)
end

function SurvivalMapSearchView:onOpen()
	MonoHelper.addNoUpdateLuaComOnceToGo(self._goheavy, SurvivalWeightPart)

	local sortComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._gosort, SurvivalSortAndFilterPart)
	local sortOptions = {}

	sortOptions[1] = {
		desc = luaLang("survival_sort_worth"),
		type = SurvivalEnum.ItemSortType.Worth
	}
	sortOptions[2] = {
		desc = luaLang("survival_sort_mass"),
		type = SurvivalEnum.ItemSortType.Mass
	}
	sortOptions[3] = {
		desc = luaLang("survival_sort_type"),
		type = SurvivalEnum.ItemSortType.Type
	}

	local filterOptions = {}

	filterOptions[1] = {
		desc = luaLang("survival_filter_material"),
		type = SurvivalEnum.ItemFilterType.Material
	}
	filterOptions[2] = {
		desc = luaLang("survival_filter_equip"),
		type = SurvivalEnum.ItemFilterType.Equip
	}
	filterOptions[3] = {
		desc = luaLang("survival_filter_consume"),
		type = SurvivalEnum.ItemFilterType.Consume
	}
	self._curSort = sortOptions[1]
	self._isDec = true
	self._filterList = {}

	sortComp:setOptions(sortOptions, filterOptions, self._curSort, self._isDec)
	sortComp:setOptionChangeCallback(self._onSortChange, self)

	local infoViewRes = self.viewContainer._viewSetting.otherRes.infoView
	local infoGo = self:getResInst(infoViewRes, self._goinfoview)

	self._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(infoGo, SurvivalBagInfoPart)

	self._infoPanel:updateMo()

	local itemRes = self.viewContainer._viewSetting.otherRes.itemRes

	self._item = self:getResInst(itemRes, self.viewGO)

	gohelper.setActive(self._item, false)

	self._allItemMos = self.viewParam.preItems or self.viewParam.itemMos
	self.isShowLoading = self.viewParam.isFirst

	self:_onSortChange(self._curSort, self._isDec, self._filterList)
	self:_refreshBagFull()

	if not self.isShowLoading then
		return
	end

	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_sougua_2)

	for _, item in ipairs(self._allItems) do
		if not item._mo:isEmpty() then
			item:showLoading(true)
		end
	end

	UIBlockMgrExtend.setNeedCircleMv(false)
	TaskDispatcher.runDelay(self._delayHideLoading, self, 1)
	UIBlockHelper.instance:startBlock("SurvivalMapSearchView_PlayLoading", 1)
end

function SurvivalMapSearchView:_delayHideLoading()
	UIBlockMgrExtend.setNeedCircleMv(true)

	for _, item in ipairs(self._allItems) do
		item:showLoading(false)
		item:setIsSelect(item._mo.uid and item._mo.uid == self._curSelectUid)
	end

	self.isShowLoading = false

	if self.viewParam.preItems then
		UIBlockHelper.instance:startBlock("SurvivalMapSearchView_changeItems", 1)

		local itemMos = self.viewParam.itemMos

		for _, itemMo in pairs(self._showList) do
			if not itemMo:isEmpty() and itemMos[itemMo.uid] and itemMo.id ~= itemMos[itemMo.uid].id then
				self._items[itemMo.uid]:playComposeAnim()
			end
		end

		TaskDispatcher.runDelay(self._delayShowItemMos, self, 1)
	else
		self:_refreshLeftPart()
	end
end

function SurvivalMapSearchView:_delayShowItemMos()
	self:_onUpdateMos(self.viewParam.itemMos, true)
	self:_refreshLeftPart()
end

function SurvivalMapSearchView:_onSortChange(sortData, isDec, filterList)
	self._curSort = sortData
	self._isDec = isDec
	self._filterList = filterList

	local showList = {}

	for _, itemMo in pairs(self._allItemMos) do
		if SurvivalBagSortHelper.filterItemMo(filterList, itemMo) then
			table.insert(showList, itemMo)
		end
	end

	SurvivalBagSortHelper.sortItems(showList, sortData.type, isDec)

	self._showList = showList

	self:_refreshBag()
end

function SurvivalMapSearchView:_onUpdateMos(itemMos, isShowPreItemAnim)
	local isSearch = not isShowPreItemAnim and not SurvivalMapModel.instance.isSearchRemove
	local haveRemove = false

	SurvivalMapModel.instance.isSearchRemove = false
	self._allItemMos = itemMos

	for _, itemMo in pairs(self._showList) do
		if not itemMo:isEmpty() then
			if itemMos[itemMo.uid] then
				if itemMo.id ~= itemMos[itemMo.uid].id and itemMo.id > 0 and itemMos[itemMo.uid].id > 0 then
					itemMo:init(itemMos[itemMo.uid])
				elseif itemMo.count ~= itemMos[itemMo.uid].count then
					itemMo:init(itemMos[itemMo.uid])

					if isSearch then
						self._items[itemMo.uid]:playSearch()
					end
				end
			else
				if itemMo.uid == self._curSelectUid then
					self._infoPanel:updateMo()
				end

				if isSearch then
					self._items[itemMo.uid]:playSearch()
				end

				self._items[itemMo.uid]:playCloseAnim()
				itemMo:ctor()

				haveRemove = true
			end
		end
	end

	if isSearch or haveRemove then
		if isSearch then
			AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_sougua_3)
			self._anim:Play("searching", 0, 0)
		end

		UIBlockHelper.instance:startBlock("SurvivalMapSearchView.searching", 0.167)
		TaskDispatcher.runDelay(self._onSearchAnim, self, 0.167)
	else
		self:_refreshBag()
		SurvivalController.instance:dispatchEvent(SurvivalEvent.SurvivalSearchAnimFinish)
	end
end

function SurvivalMapSearchView:_onSearchAnim()
	UIBlockHelper.instance:startBlock("SurvivalMapSearchView.searching", 0.5)
	TaskDispatcher.runDelay(self._delayRefreshBag, self, 0.5)
end

function SurvivalMapSearchView:_delayRefreshBag()
	SurvivalController.instance:dispatchEvent(SurvivalEvent.SurvivalSearchAnimFinish)
	self:_refreshBag()
end

function SurvivalMapSearchView:_refreshBag()
	SurvivalHelper.instance:makeArrFull(self._showList, SurvivalBagItemMo.Empty, 4, 3)

	self._items = {}
	self._allItems = {}

	gohelper.CreateObjList(self, self._createItem, self._showList, self._itemRoot, self._item, SurvivalBagItem)

	if self._curSelectUid and (not self._items[self._curSelectUid] or self._items[self._curSelectUid] and self._items[self._curSelectUid]._mo:isEmpty()) then
		self._curSelectUid = nil
	end

	if not self._curSelectUid then
		for _, v in ipairs(self._showList) do
			if not v:isEmpty() then
				self._curSelectUid = v.uid

				self._items[self._curSelectUid]:setIsSelect(true)

				break
			end
		end
	end

	self:_refreshLeftPart()
end

function SurvivalMapSearchView:_createItem(obj, data, index)
	if not data:isEmpty() then
		self._items[data.uid] = obj
	end

	self._allItems[index] = obj

	obj:updateMo(data)
	obj:setClickCallback(self._onClickItem, self)
	obj:setIsSelect(data.uid and data.uid == self._curSelectUid)
end

function SurvivalMapSearchView:_onClickItem(item)
	if self._curSelectUid == item._mo.uid then
		return
	end

	if self._curSelectUid then
		self._items[self._curSelectUid]:setIsSelect(false)
	end

	self._curSelectUid = item._mo.uid

	item:setIsSelect(true)
	self:_refreshLeftPart()
end

function SurvivalMapSearchView:_refreshLeftPart()
	if self.isShowLoading then
		return
	end

	if self._curSelectUid then
		AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_details)
		self._infoPanel:updateMo(self._items[self._curSelectUid]._mo)
	else
		self._infoPanel:updateMo()
	end
end

function SurvivalMapSearchView:_onClickGetAll()
	SurvivalInteriorRpc.instance:sendSurvivalSceneOperation(SurvivalEnum.OperType.OperSearch, "1#-1")
end

function SurvivalMapSearchView:_closeEvent()
	local sceneMo = SurvivalMapModel.instance:getSceneMo()

	if not sceneMo.panel then
		self:closeThis()

		return
	end

	SurvivalWeekRpc.instance:sendSurvivalClosePanelRequest(sceneMo.panel.uid, self._onRecvMsg, self)
end

function SurvivalMapSearchView:_onRecvMsg(cmd, resultCode, msg)
	if resultCode == 0 then
		local sceneMo = SurvivalMapModel.instance:getSceneMo()

		if sceneMo.panel and sceneMo.panel.type == SurvivalEnum.PanelType.Search then
			sceneMo.panel = nil
		end

		self:closeThis()
	end
end

function SurvivalMapSearchView:_onClickBag()
	ViewMgr.instance:openView(ViewName.SurvivalMapBagView)
end

function SurvivalMapSearchView:_refreshBagFull()
	local bagMo = SurvivalMapHelper.instance:getBagMo()
	local isFull = bagMo.totalMass > bagMo.maxWeightLimit + SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.AttrWeight)

	gohelper.setActive(self._gobagfull, isFull)
end

function SurvivalMapSearchView:onClose()
	UIBlockMgrExtend.setNeedCircleMv(true)
	TaskDispatcher.cancelTask(self._onSearchAnim, self)
	TaskDispatcher.cancelTask(self._delayRefreshBag, self)
	TaskDispatcher.cancelTask(self._delayShowItemMos, self)
end

return SurvivalMapSearchView
