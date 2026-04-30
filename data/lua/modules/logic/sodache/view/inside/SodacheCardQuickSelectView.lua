-- chunkname: @modules/logic/sodache/view/inside/SodacheCardQuickSelectView.lua

module("modules.logic.sodache.view.inside.SodacheCardQuickSelectView", package.seeall)

local SodacheCardQuickSelectView = class("SodacheCardQuickSelectView", BaseView)

function SodacheCardQuickSelectView:onInitView()
	self._gorecommend = gohelper.findChild(self.viewGO, "root/left/recommendInspiration")
	self._goattritem = gohelper.findChild(self.viewGO, "root/left/recommendInspiration/#go_attrlist/#go_attritem")
	self._txtvalue = gohelper.findChildTextMesh(self.viewGO, "root/right/bottom/#txt_value")
	self._btnok = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/bottom/#btn_ok")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/bottom/#btn_notok")
	self._btnsort = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/top/#btn_quality")
	self._transarrow = gohelper.findChild(self.viewGO, "root/right/top/#btn_quality/txt/arrow").transform
	self._scroll = gohelper.findChild(self.viewGO, "root/right/#scroll_cardlist")
	self._goleftinfo = gohelper.findChild(self.viewGO, "root/left/sodache_cardinfoleft")
	self._goempty = gohelper.findChild(self.viewGO, "root/left/#go_empty")
	self._godices = gohelper.findChild(self.viewGO, "root/left/#go_dices")
	self._gosuccessdiceitem = gohelper.findChild(self.viewGO, "root/left/#go_dices/#go_success/dices/#go_item")
	self._gobigsuccess = gohelper.findChild(self.viewGO, "root/left/#go_dices/#go_bigsuccess")
	self._gobigsuccessdiceitem = gohelper.findChild(self.viewGO, "root/left/#go_dices/#go_bigsuccess/dices/#go_item")
end

function SodacheCardQuickSelectView:addEvents()
	self._btnok:AddClickListener(self._onConfirmClick, self)
	self._btncancel:AddClickListener(self.closeThis, self)
	self._btnsort:AddClickListener(self._onClickSort, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnClickCardQuickSelectItem, self._onClickItem, self)
end

function SodacheCardQuickSelectView:removeEvents()
	self._btnok:RemoveClickListener()
	self._btncancel:RemoveClickListener()
	self._btnsort:RemoveClickListener()
	SodacheController.instance:unregisterCallback(SodacheEvent.OnClickCardQuickSelectItem, self._onClickItem, self)
end

function SodacheCardQuickSelectView:onOpen()
	self._cardInfo = MonoHelper.addNoUpdateLuaComOnceToGo(self._goleftinfo, SodacheCardInfoLeft)
	self._isColorDec = true
	self.mo = self.viewParam
	self._simpleList = MonoHelper.addNoUpdateLuaComOnceToGo(self._scroll, SurvivalSimpleListPart)

	self._simpleList:setCellCls(SodacheCardQuickSelectItem)
	self._simpleList:setCellParam(self.mo)
	self:refreshRecommend()
	self:refreshItems()
	self:refreshCount()
	self:refreshDices()

	local curItem

	if self.curSelectItem then
		local count = self.mo:getItemSelectCount(self.curSelectItem.serverMo.configId)

		if count > 0 then
			curItem = self.curSelectItem
		end
	end

	if curItem then
		self._cardInfo:setData(curItem)
		gohelper.setActive(self._goempty, false)
		gohelper.setActive(self._goleftinfo, true)
	else
		gohelper.setActive(self._goleftinfo, false)
		gohelper.setActive(self._goempty, true)
	end
end

function SodacheCardQuickSelectView:_onClickSort()
	self._isColorDec = not self._isColorDec

	self:refreshItems()
end

local temp

function SodacheCardQuickSelectView:refreshItems()
	transformhelper.setLocalScale(self._transarrow, 1, self._isColorDec and -1 or 1, 1)

	local allShowItems = self.mo.canSelectCards

	temp = self

	table.sort(allShowItems, self.sortFunc)

	temp = nil
	self.curSelectItem = allShowItems[1]
	self.allItems = allShowItems

	self._simpleList:setList(allShowItems)
end

function SodacheCardQuickSelectView.sortFunc(a, b)
	local self = temp

	if self.mo:getItemSelectCount(a.serverMo.configId) > 0 ~= (self.mo:getItemSelectCount(b.serverMo.configId) > 0) then
		return self.mo:getItemSelectCount(a.serverMo.configId) > 0
	end

	if a.serverMo.itemCo.quality ~= b.serverMo.itemCo.quality then
		if self._isColorDec then
			return a.serverMo.itemCo.quality > b.serverMo.itemCo.quality
		else
			return a.serverMo.itemCo.quality < b.serverMo.itemCo.quality
		end
	end

	return a.serverMo.configId < b.serverMo.configId
end

function SodacheCardQuickSelectView:_onClickItem(cardMo, isAdd)
	if self.mo.isMultSelect or isAdd then
		self._cardInfo:setData(cardMo)
		gohelper.setActive(self._goempty, false)
		gohelper.setActive(self._goleftinfo, true)
	else
		gohelper.setActive(self._goempty, true)
		gohelper.setActive(self._goleftinfo, false)
	end

	self:refreshCount()
end

function SodacheCardQuickSelectView:refreshCount()
	if self.mo.isMultSelect then
		self._txtvalue.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("sodache_cardquickselectview_count"), self.mo.selectCount, self.mo.totalSelectCount)
	else
		self._txtvalue.text = ""
	end
end

function SodacheCardQuickSelectView:refreshRecommend()
	gohelper.setActive(self._gorecommend, self.mo.recommendList ~= nil)

	if self.mo.recommendList then
		gohelper.CreateObjList(self, self._createCareerIcon, self.mo.recommendList, nil, self._goattritem)
	end
end

function SodacheCardQuickSelectView:refreshDices()
	if not self.mo.choiceCo then
		gohelper.setActive(self._godices, false)

		return
	end

	gohelper.setActive(self._godices, true)

	local arr = string.split(self.mo.choiceCo.verifyCond, "|") or {}

	self:setDices(arr[1], self._gosuccessdiceitem)
	self:setDices(arr[2], self._gobigsuccessdiceitem)
	gohelper.setActive(self._gobigsuccess, arr[2])
end

function SodacheCardQuickSelectView:setDices(str, itemGo)
	if string.nilorempty(str) then
		return
	end

	local arr = GameUtil.splitString2(str, true, "&", ":") or {}
	local datas = {}

	for i, v in ipairs(arr) do
		for count = 1, v[1] do
			table.insert(datas, v[2])
		end
	end

	gohelper.CreateObjList(self, self._createDices, datas, nil, itemGo)
end

function SodacheCardQuickSelectView:_createDices(obj, data, index)
	local icon = gohelper.findChildImage(obj, "#image_icon")

	UISpriteSetMgr.instance:setSodache2Sprite(icon, "sodache_touzi_" .. data)
end

function SodacheCardQuickSelectView:_createCareerIcon(obj, data, index)
	local icon = gohelper.findChildImage(obj, "icon")

	UISpriteSetMgr.instance:setHeroGroupSprite(icon, "career_" .. data)
end

function SodacheCardQuickSelectView:_onConfirmClick()
	if self.mo.selectCallback and self.mo.selectCallback(self.mo.selectCallobj, self.mo.selectCards) then
		return
	end

	self:closeThis()
end

return SodacheCardQuickSelectView
