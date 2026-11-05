-- chunkname: @modules/logic/room/view/building/RoomFormulaMsgBoxView.lua

module("modules.logic.room.view.building.RoomFormulaMsgBoxView", package.seeall)

local RoomFormulaMsgBoxView = class("RoomFormulaMsgBoxView", BaseView)
local SCROLL_VIEW_CENTER_POS_Y = -60

RoomFormulaMsgBoxView.Source = {
	Talent = 1
}

function RoomFormulaMsgBoxView:onInitView()
	self._txtdesc = gohelper.findChildText(self.viewGO, "ContentLayout/#txt_desc")
	self._btnyes = gohelper.findChildButtonWithAudio(self.viewGO, "BGLayout/Btn/#btn_yes")
	self._txtyes = gohelper.findChildText(self.viewGO, "BGLayout/Btn/#btn_yes/yes")
	self._btnno = gohelper.findChildButtonWithAudio(self.viewGO, "BGLayout/Btn/#btn_no")
	self._goExchange = gohelper.findChild(self.viewGO, "ContentLayout/Exchange")
	self._goScrollView = gohelper.findChild(self.viewGO, "ContentLayout/Exchange/Left/ScrollView")
	self._goContent = gohelper.findChild(self.viewGO, "ContentLayout/Exchange/Left/ScrollView/Viewport/Content")
	self._contentGrid = self._goContent:GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
	self._goPropItem = gohelper.findChild(self.viewGO, "ContentLayout/Exchange/Left/ScrollView/Viewport/Content/#go_PropItem")
	self._gorightContent = gohelper.findChild(self.viewGO, "ContentLayout/Exchange/Right/ScrollView/Viewport/Content")
	self._gorightPropItem = gohelper.findChild(self.viewGO, "ContentLayout/Exchange/Right/ScrollView/Viewport/Content/#go_PropItem")
	self._goTalentBoxChange = gohelper.findChild(self.viewGO, "ContentLayout/boxchange")
	self._goTalentBoxItem = gohelper.findChild(self.viewGO, "ContentLayout/boxchange/Left/ScrollView/Viewport/Content/#go_PropItem")
	self._goTalentBoxResultItem = gohelper.findChild(self.viewGO, "ContentLayout/boxchange/Right/ScrollView/Viewport/Content/#go_PropItem")
	self._txtboxdesc = gohelper.findChildText(self.viewGO, "ContentLayout/#txt_desc")
	self._goLine = gohelper.findChild(self.viewGO, "ContentLayout/#go_lineBox")
	self._goBigBg = gohelper.findChild(self.viewGO, "BGLayout/#go_BigBG")
	self._goSmallBg = gohelper.findChild(self.viewGO, "BGLayout/#go_SmallBG")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomFormulaMsgBoxView:addEvents()
	self._btnyes:AddClickListener(self._btnyesOnClick, self)
	self._btnno:AddClickListener(self._btnnoOnClick, self)
end

function RoomFormulaMsgBoxView:removeEvents()
	self._btnyes:RemoveClickListener()
	self._btnno:RemoveClickListener()
end

function RoomFormulaMsgBoxView:_btnyesOnClick()
	if not self.viewParam then
		return
	end

	local callback = self.viewParam.callback

	if callback then
		callback(self.viewParam.callbackObj)
	end

	self:sendRpc()
	self:closeThis()
end

function RoomFormulaMsgBoxView:_btnnoOnClick()
	self:closeThis()
end

function RoomFormulaMsgBoxView:_editableInitView()
	self._originalScrollViewPosX, self._originalScrollViewPosY, _ = transformhelper.getLocalPos(self._goScrollView.transform)

	gohelper.setActive(self._goPropItem, false)
end

function RoomFormulaMsgBoxView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_upgrade)
	self:setExchangeList()
	self:setTalentBoxChangeList()
	self:refreshTips()

	local yesStr = self.viewParam.combineCb and "roomformula_combine_and_up" or "confirm_text"

	if self.viewParam and self.viewParam.source == RoomFormulaMsgBoxView.Source.Talent then
		local sourceParam = self.viewParam and self.viewParam.sourceParam
		local sourceHeroId = sourceParam and sourceParam.heroId
		local heroMo = sourceHeroId and HeroModel.instance:getByHeroId(sourceHeroId)

		yesStr = heroMo and "talent_charactertalentlevelup_btntalent" .. heroMo:getTalentTxtByHeroType() or "p_charactertalentlevelupview_talentup"
	end

	self._txtyes.text = luaLang(yesStr)
end

function RoomFormulaMsgBoxView:setExchangeList()
	local produceDataList = self.viewParam and self.viewParam.produceDataList

	self._hasAnyProduct = produceDataList and #produceDataList > 0

	gohelper.setActive(self._goExchange, self._hasAnyProduct)

	if not self._hasAnyProduct then
		return
	end

	self:setMatItemList()
	self:setProduceItemList()
end

function RoomFormulaMsgBoxView:setMatItemList()
	self.costItemList = {}
	self._contentGrid.enabled = false

	local typeDic = self.viewParam and self.viewParam.costItemAndFormulaIdList.itemTypeDic

	if typeDic then
		for type, itemDic in pairs(typeDic) do
			for itemId, quantity in pairs(itemDic) do
				if quantity > 0 then
					local item = {}

					item.type = type
					item.id = itemId
					item.quantity = quantity

					table.insert(self.costItemList, item)
				end
			end
		end
	end

	RoomFormulaMsgBoxModel.instance:setCostItemList(self.costItemList)

	local list = RoomFormulaMsgBoxModel.instance:getList()

	if #list <= self.viewContainer.lineCount then
		transformhelper.setLocalPosXY(self._goScrollView.transform, self._originalScrollViewPosX, SCROLL_VIEW_CENTER_POS_Y)

		self._contentGrid.enabled = true
	else
		self._contentGrid.enabled = false

		transformhelper.setLocalPosXY(self._goScrollView.transform, self._originalScrollViewPosX, self._originalScrollViewPosY)
	end
end

function RoomFormulaMsgBoxView:setProduceItemList()
	self.produceItemList = {}

	local produceDataList = self.viewParam and self.viewParam.produceDataList or {}

	gohelper.CreateObjList(self, self._onCreateProduceItem, produceDataList, self._gorightContent, self._gorightPropItem, RoomFormulaMsgBoxItem)

	self._allProductName = self:_produceList2NameStr(produceDataList)
end

function RoomFormulaMsgBoxView:_onCreateProduceItem(obj, data, index)
	obj:onUpdateMO(data, true)

	self.produceItemList[index] = obj
end

function RoomFormulaMsgBoxView:setTalentBoxChangeList()
	self._talentItemList = self.viewParam and self.viewParam.lackTalentItemList
	self._lackTalentItemNum = self._talentItemList and #self._talentItemList or 0
	self._hasLackTalentItems = self._lackTalentItemNum > 0

	gohelper.setActive(self._goTalentBoxChange, self._hasLackTalentItems)

	if not self._hasLackTalentItems then
		return
	end

	self._talentBoxDataList = {
		{
			type = MaterialEnum.MaterialType.Item,
			id = ItemEnum.TalentBoxItemId,
			quantity = self._lackTalentItemNum
		}
	}

	gohelper.CreateObjList(self, self._refreshTalentBoxItem, self._talentBoxDataList, nil, self._goTalentBoxItem, RoomFormulaMsgTalentBoxItem)
	gohelper.CreateObjList(self, self._refreshTalentBoxResultItem, self._talentItemList, nil, self._goTalentBoxResultItem, RoomFormulaMsgBoxItem)

	self._allBoxName = self:_produceList2NameStr(self._talentBoxDataList)
	self._allBoxResultName = self:_produceList2NameStr(self._talentItemList)
end

function RoomFormulaMsgBoxView:_refreshTalentBoxItem(boxItem, boxData, index)
	boxItem:onUpdateMO(boxData)
end

function RoomFormulaMsgBoxView:_refreshTalentBoxResultItem(resultItem, resultData, index)
	resultItem:onUpdateMO(resultData, true)
end

function RoomFormulaMsgBoxView:_produceList2NameStr(produceDataList)
	local produceNameTable = {}

	for _, produceData in ipairs(produceDataList) do
		local config = ItemModel.instance:getItemConfigAndIcon(produceData.type, produceData.id)
		local numDisplay = GameUtil.numberDisplay(produceData.quantity)
		local name = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("multiple_2"), config.name, numDisplay)

		produceNameTable[#produceNameTable + 1] = name
	end

	local strComma = luaLang("comma_sep")

	return table.concat(produceNameTable, strComma)
end

function RoomFormulaMsgBoxView:refreshTips()
	gohelper.setActive(self._goLine, false)
	gohelper.setActive(self._goBigBg, false)
	gohelper.setActive(self._goSmallBg, false)

	if self._hasAnyProduct and self._hasLackTalentItems then
		self._txtdesc.text = GameUtil.getSubPlaceholderLuaLang(luaLang("roomformulamsgboxview_tips2"), {
			self._allBoxName,
			self._allBoxResultName,
			self._allProductName
		})

		gohelper.setActive(self._goLine, true)
		gohelper.setActive(self._goBigBg, true)
	elseif self._hasLackTalentItems then
		gohelper.setActive(self._goSmallBg, true)

		self._txtdesc.text = GameUtil.getSubPlaceholderLuaLang(luaLang("roomformulamsgboxview_tips1"), {
			self._allBoxName,
			self._allBoxResultName
		})
	elseif self._hasAnyProduct then
		gohelper.setActive(self._goSmallBg, true)

		self._txtdesc.text = formatLuaLang("room_formula_easy_combine_msg_box_tip", self._allProductName)
	else
		self._txtdesc.text = ""
	end
end

function RoomFormulaMsgBoxView:sendRpc()
	local callback = self.viewParam.combineCb
	local callbackObj = self.viewParam.combineCbObj

	if self._hasAnyProduct and self._hasLackTalentItems then
		self:sendRpcUseTalentBoxItem()
		self:sendRpcStartProductionLine(callback, callbackObj)
	elseif self._hasLackTalentItems then
		self:sendRpcUseTalentBoxItem(callback, callbackObj)
	elseif self._hasAnyProduct then
		self:sendRpcStartProductionLine(callback, callbackObj)
	end
end

function RoomFormulaMsgBoxView:sendRpcUseTalentBoxItem(callback, callbackObj)
	if not self._talentItemList then
		return
	end

	for _, talentData in ipairs(self._talentItemList) do
		local data = {}
		local o = {}

		o.materialId = ItemEnum.TalentBoxItemId
		o.quantity = talentData.quantity

		table.insert(data, o)

		local index = self:_findItemIndexFromGift(MaterialEnum.MaterialType.Item, ItemEnum.TalentBoxItemId, talentData.type, talentData.id)

		ItemRpc.instance:sendUseItemRequest(data, index - 1, callback, callbackObj)
	end
end

function RoomFormulaMsgBoxView:_findItemIndexFromGift(boxType, boxId, itemType, itemId)
	local gifts = string.split(ItemModel.instance:getItemConfig(boxType, boxId).effect, "|")

	for k, v in ipairs(gifts) do
		local gift = string.split(v, "#")

		if tonumber(gift[1]) == itemType and tonumber(gift[2]) == itemId then
			return k
		end
	end
end

function RoomFormulaMsgBoxView:sendRpcStartProductionLine(callback, callbackObj)
	local lineMO = RoomProductionModel.instance:getLineMO(self.viewParam.lineId)

	RoomRpc.instance:sendStartProductionLineRequest(lineMO.id, self.viewParam.costItemAndFormulaIdList.formulaIdList, self.costItemList, callback, callbackObj)
end

function RoomFormulaMsgBoxView:onClose()
	return
end

return RoomFormulaMsgBoxView
