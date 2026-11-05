-- chunkname: @modules/logic/versionactivity4_1/act248/view/decryption/Act248SlotTipView.lua

module("modules.logic.versionactivity4_1.act248.view.decryption.Act248SlotTipView", package.seeall)

local Act248SlotTipView = class("Act248SlotTipView", BaseView)

function Act248SlotTipView:onInitView()
	self._goslot = gohelper.findChild(self.viewGO, "root/#go_slot")
	self._gotips = gohelper.findChild(self.viewGO, "root/#go_tips")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_tips/#btn_close")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "root/#go_tips/#scroll_desc")
	self._goDescItem = gohelper.findChild(self.viewGO, "root/#go_tips/#scroll_desc/Viewport/Content/#go_DescItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act248SlotTipView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self:addEventCb(Act248Controller.instance, Act248Event.onShowSlotTip, self._onShowSlotTip, self)
end

function Act248SlotTipView:removeEvents()
	self._btnclose:RemoveClickListener()
	self:removeEventCb(Act248Controller.instance, Act248Event.onShowSlotTip, self._onShowSlotTip, self)
end

function Act248SlotTipView:_btncloseOnClick()
	gohelper.setActive(self._gotips, false)
	self.viewContainer:openSlotView()
end

function Act248SlotTipView:_editableInitView()
	self._clueIds = {}
	self._slotGroupMo = nil
	self._slots = self:getUserDataTb_()

	for i = 1, 11 do
		local item = self:getUserDataTb_()

		item.goline = gohelper.findChild(self._goline, i)
		item.goitempos = gohelper.findChild(self._goslot, "card/#go_cluecarditem" .. i)
		self._slots[i] = item
	end

	self._slotPath = self.viewContainer:getSetting().otherRes[1]

	gohelper.setActive(self._goDescItem, false)

	self._clueItems = self:getUserDataTb_()
end

function Act248SlotTipView:onUpdateParam()
	return
end

function Act248SlotTipView:onOpen()
	gohelper.setActive(self._gotips, false)

	self._fileMo = self.viewParam.fileMo
end

function Act248SlotTipView:_onShowSlotTip(slotGroupMo, isShowLne)
	if not slotGroupMo then
		gohelper.setActive(self._gotips, false)

		return
	end

	if not self._slotGroupMo or self._slotGroupMo.id ~= slotGroupMo.id then
		self._clueIds = {}

		for _, mo in ipairs(slotGroupMo:getMos()) do
			local clueId = mo:getCorrectClueId()

			if clueId and clueId > 0 then
				table.insert(self._clueIds, clueId)
			end
		end

		self._slotGroupMo = slotGroupMo
	end

	self:_refreshClue()
	gohelper.setActive(self._gotips, true)
	AudioMgr.instance:trigger(AudioEnum4_1.Act248.play_ui_wulu_aizila_forward_paper)
end

function Act248SlotTipView:hideView()
	gohelper.setActive(self._gotips, false)
end

function Act248SlotTipView:_refreshClue()
	local count = 0

	if self._slotGroupMo then
		local mos = self._slotGroupMo:getMos()

		for i, mo in ipairs(mos) do
			local item = self:_getClueItem(i)

			item.slotItem:onUpdateMO(mo, self._slotGroupMo)

			count = count + 1

			local co = mo:getConfig()
			local clueId = co.clueId
			local clueMo = Act248Model.instance:getClueById(clueId)

			item.txtname.text = clueMo:getConfig().name
			item.txtdesc.text = co.clueText
		end
	end

	for i, item in ipairs(self._clueItems) do
		item.slotItem:onShow(i <= count)
		gohelper.setActive(item.go, i <= count)
	end
end

function Act248SlotTipView:_getClueItem(index)
	local item = self._clueItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._goDescItem, index)
		item.goclue = gohelper.findChild(item.go, "#go_cluecarditem")

		local go = self.viewContainer:getResInst(self._slotPath, item.goclue)

		item.slotItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, Act248ClueSlotItem)
		item.slotItem.viewContainer = self.viewContainer

		item.slotItem:setHideStatus(true)

		item.txtname = gohelper.findChildText(item.go, "txt_Name")
		item.txtdesc = gohelper.findChildText(item.go, "txt_Desc")
		self._clueItems[index] = item
	end

	return item
end

function Act248SlotTipView:onClose()
	return
end

function Act248SlotTipView:onDestroyView()
	return
end

return Act248SlotTipView
