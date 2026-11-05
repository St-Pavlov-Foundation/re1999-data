-- chunkname: @modules/logic/versionactivity4_1/linkgift/view/V4a1_LinkGift_FullView.lua

module("modules.logic.versionactivity4_1.linkgift.view.V4a1_LinkGift_FullView", package.seeall)

local V4a1_LinkGift_FullView = class("V4a1_LinkGift_FullView", V4a1_LinkGift_FullViewBase)

function V4a1_LinkGift_FullView:onInitView()
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

function V4a1_LinkGift_FullView:addEvents()
	V4a1_LinkGift_FullView.super.addEvents(self)
	self._btntips:AddClickListener(self._btntipsOnClick, self)
	self._btngoto:AddClickListener(self._btngotoOnClick, self)
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
end

function V4a1_LinkGift_FullView:removeEvents()
	self._btntips:RemoveClickListener()
	self._btngoto:RemoveClickListener()
	self._btnbuy:RemoveClickListener()
	V4a1_LinkGift_FullView.super.removeEvents(self)
end

function V4a1_LinkGift_FullView:ctor(...)
	V4a1_LinkGift_FullView.super.ctor(self, ...)
end

function V4a1_LinkGift_FullView:_editableInitView()
	V4a1_LinkGift_FullView.super._editableInitView(self)
end

function V4a1_LinkGift_FullView:onDestroyView()
	V4a1_LinkGift_FullView.super.onDestroyView(self)
end

function V4a1_LinkGift_FullView:onRefresh()
	V4a1_LinkGift_FullView.super.onRefresh(self)
end

function V4a1_LinkGift_FullView:onClose()
	V4a1_LinkGift_FullView.super.onClose(self)
end

return V4a1_LinkGift_FullView
