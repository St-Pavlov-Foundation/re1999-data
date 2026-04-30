-- chunkname: @modules/logic/sodache/view/inside/SodacheCheckPanelView.lua

module("modules.logic.sodache.view.inside.SodacheCheckPanelView", package.seeall)

local SodacheCheckPanelView = class("SodacheCheckPanelView", BaseView)

function SodacheCheckPanelView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_close2")
	self._goscroll = gohelper.findChild(self.viewGO, "left/#scroll_rewardview")
	self._godropitem = gohelper.findChild(self.viewGO, "left/#scroll_rewardview/Viewport/Content/sodache_carditem")
	self._gocheck = gohelper.findChild(self.viewGO, "right/check")
	self._gosuccessdiceitem = gohelper.findChild(self.viewGO, "right/check/#go_dices/#go_success/dices/#go_item")
	self._gobigsuccess = gohelper.findChild(self.viewGO, "right/check/#go_dices/#go_bigsuccess")
	self._gobigsuccessdiceitem = gohelper.findChild(self.viewGO, "right/check/#go_dices/#go_bigsuccess/dices/#go_item")
	self._animcard = gohelper.findChildAnim(self.viewGO, "right/check/base")
	self._goempty = gohelper.findChild(self.viewGO, "right/check/base/#go_empty")
	self._gocard = gohelper.findChild(self.viewGO, "right/check/base/go_card/#go_carditem/sodache_carditem")
	self._btnclickcard = gohelper.findChildButtonWithAudio(self.viewGO, "right/check/base/#btn_click")
	self._txtcarddesc = gohelper.findChildTextMesh(self.viewGO, "right/check/base/#txt_desc")
	self._btncheck = gohelper.findChildButtonWithAudio(self.viewGO, "right/check/#btn_check")
end

function SodacheCheckPanelView:addEvents()
	self._btnclose:AddClickListener(self.onClickModalMask, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnClosePanel, self._onPanelClose, self)
	self._btnclickcard:AddClickListener(self._onClickCard, self)
	self._btncheck:AddClickListener(self._onClickCheck, self)
end

function SodacheCheckPanelView:removeEvents()
	self._btnclose:RemoveClickListener()
	SodacheController.instance:unregisterCallback(SodacheEvent.OnClosePanel, self._onPanelClose, self)
	self._btnclickcard:RemoveClickListener()
	self._btncheck:RemoveClickListener()
end

function SodacheCheckPanelView:onOpen()
	local insideMo = SodacheModel.instance:getInsideMo()
	local panelMo = insideMo.panelBox.currPanel
	local unitMo = panelMo:getUnitMo()

	self._unitMo = unitMo
	self._panelMo = panelMo

	self:initDrop()
	self:refreshCheck()
end

function SodacheCheckPanelView:_onPanelClose()
	if self._unitMo.type ~= SodacheEnum.UnitType.Container then
		return
	end

	self:closeThis()
end

function SodacheCheckPanelView:onClickModalMask()
	if self._unitMo.type ~= SodacheEnum.UnitType.Container then
		return
	end

	if self.isEventFinish then
		self:closeThis()

		return
	end

	SodacheInsideRpc.instance:sendSodacheInsideClosePanel()
end

function SodacheCheckPanelView:initDrop()
	local dropPreview = self._unitMo.eventCo.dropPreview

	if string.nilorempty(dropPreview) then
		gohelper.setActive(self._goscroll, false)
	else
		gohelper.setActive(self._goscroll, true)

		local datas = GameUtil.splitString2(dropPreview, true, "&", ":")

		gohelper.CreateObjList(self, self._createDropItem, datas, nil, self._godropitem)
	end
end

function SodacheCheckPanelView:_createDropItem(obj, data, index)
	local gorate = gohelper.findChild(obj, "#go_rate")
	local item = MonoHelper.addNoUpdateLuaComOnceToGo(obj, SodacheCardItem)

	item:updateMo(SodacheCardMo.Create(data[1]))

	local rate = data[2]

	gohelper.setActive(gorate, rate == 2)
end

function SodacheCheckPanelView:refreshCheck()
	if self._unitMo.type ~= SodacheEnum.UnitType.Container then
		gohelper.setActive(self._gocheck, false)

		return
	end

	gohelper.setActive(self._gocheck, true)
	gohelper.setActive(self._btnclose, true)

	local choiceCo = lua_sodache_choice.configDict[self._panelMo.options[1]]

	if not choiceCo then
		logError("面板选项配置不存在！！" .. tostring(self._panelMo.options[1]))

		return
	end

	self._choiceCo = choiceCo

	local arr = string.split(choiceCo.verifyCond, "|") or {}

	if #arr <= 0 then
		logError("不需要检定的事件也打开了弹窗？？" .. tostring(choiceCo.id))

		return
	end

	self:setDices(arr[1], self._gosuccessdiceitem)
	self:setDices(arr[2], self._gobigsuccessdiceitem)
	gohelper.setActive(self._gobigsuccess, arr[2])

	local isValid, cards = SodacheOptionUtil.instance:checkOption(self._choiceCo.verifyCard)

	if not isValid then
		-- block empty
	end

	self._canUseCards = cards or {}
	self.curSelectCardMo = nil

	if choiceCo.autoCard == 1 and self._canUseCards[1] then
		self.curSelectCardMo = self._canUseCards[1]:toCardMo()
	end

	self._gocarditem = MonoHelper.addNoUpdateLuaComOnceToGo(self._gocard, SodacheCardItem)
	self._txtcarddesc.text = self._choiceCo.verifyDesc

	self:_refreshCardShow()
end

function SodacheCheckPanelView:setDices(str, itemGo)
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

function SodacheCheckPanelView:_createDices(obj, data, index)
	local icon = gohelper.findChildImage(obj, "#image_icon")

	UISpriteSetMgr.instance:setSodache2Sprite(icon, "sodache_touzi_" .. data)
end

function SodacheCheckPanelView:_onClickCard()
	if not self._canUseCards then
		return
	end

	local selectMo = SodacheCardSelectMo.New()

	selectMo.selectCallobj = self
	selectMo.selectCallback = self.onSelectCardEnd

	selectMo:setCards(self._canUseCards)

	selectMo.totalSelectCount = 1
	selectMo.choiceCo = self._choiceCo

	if self.curSelectCardMo then
		selectMo:addItemCount(self.curSelectCardMo.serverMo.configId, 1)
	end

	ViewMgr.instance:openView(ViewName.SodacheCardQuickSelectView, selectMo)
end

function SodacheCheckPanelView:_refreshCardShow()
	self._animcard:Play(self.curSelectCardMo and "in" or "out")

	if self.curSelectCardMo then
		self._gocarditem:updateMo(self.curSelectCardMo)
	end
end

function SodacheCheckPanelView:onSelectCardEnd(cardSelects)
	local cardId, num = next(cardSelects)

	if cardId then
		self.curSelectCardMo = SodacheCardMo.Create(cardId, num)
	else
		self.curSelectCardMo = nil
	end

	self:_refreshCardShow()
end

function SodacheCheckPanelView:_onClickCheck()
	if not self.curSelectCardMo and self._choiceCo.forceCard then
		GameFacade.showToast(ToastEnum.SodacheToastId373014)

		return
	end

	ViewMgr.instance:openView(ViewName.SodacheCheckView, {
		cardMo = self.curSelectCardMo,
		choiceCo = self._choiceCo
	})
end

return SodacheCheckPanelView
