-- chunkname: @modules/logic/sodache/view/outside/SodacheRelicView.lua

module("modules.logic.sodache.view.outside.SodacheRelicView", package.seeall)

local SodacheRelicView = class("SodacheRelicView", BaseView)

function SodacheRelicView:onInitView()
	self._scrollCard = gohelper.findChildScrollRect(self.viewGO, "#scroll_Card")
	self._goRelicItem = gohelper.findChild(self.viewGO, "#scroll_Card/Viewport/Content/#go_RelicItem")
	self._goRareBtns = gohelper.findChild(self.viewGO, "#go_RareBtns")
	self._btnViewAll = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_ViewAll")
	self._btnOneKeyUp = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_OneKeyUp")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SodacheRelicView:addEvents()
	self._btnViewAll:AddClickListener(self._btnViewAllOnClick, self)
	self._btnOneKeyUp:AddClickListener(self._btnOneKeyUpOnClick, self)
end

function SodacheRelicView:removeEvents()
	self._btnViewAll:RemoveClickListener()
	self._btnOneKeyUp:RemoveClickListener()
end

function SodacheRelicView:_btnOneKeyUpOnClick()
	if self.canUpgrade then
		SodacheOutsideRpc.instance:sendSodacheRelicOneKeyUpgrade()
	end
end

function SodacheRelicView:_btnViewAllOnClick()
	ViewMgr.instance:openView(ViewName.SodacheRelicOverView)
end

function SodacheRelicView:_btnQualityOnClick(quality)
	if self.quality == quality then
		return
	end

	self.quality = quality

	for key, item in pairs(self.tabItemMap) do
		gohelper.setActive(item.goUnSelecte, key ~= self.quality)
		gohelper.setActive(item.goSelect, key == self.quality)
	end

	SodacheRelicMoListModel.instance:setData(self.quality)
end

function SodacheRelicView:_editableInitView()
	self.tabItemMap = {}

	local qualityTbl = {
		0,
		4,
		5,
		6
	}

	for _, quality in ipairs(qualityTbl) do
		local item = self:getUserDataTb_()
		local go = gohelper.findChild(self._goRareBtns, "Tab" .. quality)

		item.goUnSelecte = gohelper.findChild(go, "unselect")
		item.goSelect = gohelper.findChild(go, "selected")

		local btnClick = gohelper.findChildButtonWithAudio(go, "btn_Click")

		self:addClickCb(btnClick, self._btnQualityOnClick, self, quality)

		self.tabItemMap[quality] = item
	end
end

function SodacheRelicView:onOpen()
	self:addEventCb(SodacheController.instance, SodacheEvent.OnRelicUpgradeOneKey, self.refreshOneKeyUp, self)
	self:_btnQualityOnClick(0)
	self._scrollCard:AddOnValueChanged(self.onScrollMove, self)
	self:refreshOneKeyUp()
end

function SodacheRelicView:onDestroyView()
	self._scrollCard:RemoveOnValueChanged()
end

function SodacheRelicView:onScrollMove()
	SodacheController.instance:dispatchEvent(SodacheEvent.OnRelicScrollMove)
end

function SodacheRelicView:refreshOneKeyUp()
	self.canUpgrade = SodacheUtil.checkOneKeyUpRelic()

	gohelper.setActive(self._btnOneKeyUp, self.canUpgrade)
end

return SodacheRelicView
