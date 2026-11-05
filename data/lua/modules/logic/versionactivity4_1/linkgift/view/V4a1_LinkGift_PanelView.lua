-- chunkname: @modules/logic/versionactivity4_1/linkgift/view/V4a1_LinkGift_PanelView.lua

module("modules.logic.versionactivity4_1.linkgift.view.V4a1_LinkGift_PanelView", package.seeall)

local V4a1_LinkGift_PanelView = class("V4a1_LinkGift_PanelView", V4a1_LinkGift_PanelViewBase)

function V4a1_LinkGift_PanelView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "root/go_rewarditem/#simage_icon")
	self._txtnum = gohelper.findChildText(self.viewGO, "root/go_rewarditem/#txt_num")
	self._btntips = gohelper.findChildButtonWithAudio(self.viewGO, "root/Title/#btn_tips")
	self._txttime = gohelper.findChildText(self.viewGO, "root/Title/time/#txt_time")
	self._btngoto = gohelper.findChildButtonWithAudio(self.viewGO, "root/Btn/#btn_goto")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "root/Btn/#btn_buy")
	self._txtprice = gohelper.findChildText(self.viewGO, "root/Btn/#btn_buy/#txt_price")
	self._goowned = gohelper.findChild(self.viewGO, "root/Btn/#go_owned")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V4a1_LinkGift_PanelView:addEvents()
	V4a1_LinkGift_PanelView.super.addEvents(self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btntips:AddClickListener(self._btntipsOnClick, self)
	self._btngoto:AddClickListener(self._btngotoOnClick, self)
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
end

function V4a1_LinkGift_PanelView:removeEvents()
	V4a1_LinkGift_PanelView.super.removeEvents(self)
	self._btnclose:RemoveClickListener()
	self._btntips:RemoveClickListener()
	self._btngoto:RemoveClickListener()
	self._btnbuy:RemoveClickListener()
end

function V4a1_LinkGift_PanelView:ctor(...)
	V4a1_LinkGift_PanelView.super.ctor(self, ...)
end

function V4a1_LinkGift_PanelView:onDestroyView()
	V4a1_LinkGift_PanelView.super.onDestroyView(self)
end

function V4a1_LinkGift_PanelView:_editableInitView()
	V4a1_LinkGift_PanelView.super._editableInitView(self)
end

function V4a1_LinkGift_PanelView:onRefresh()
	V4a1_LinkGift_PanelView.super.onRefresh(self)
end

function V4a1_LinkGift_PanelView:onClose()
	V4a1_LinkGift_PanelView.super.onClose(self)
end

return V4a1_LinkGift_PanelView
