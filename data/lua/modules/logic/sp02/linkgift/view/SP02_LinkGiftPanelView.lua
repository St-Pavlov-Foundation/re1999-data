-- chunkname: @modules/logic/sp02/linkgift/view/SP02_LinkGiftPanelView.lua

module("modules.logic.sp02.linkgift.view.SP02_LinkGiftPanelView", package.seeall)

local SP02_LinkGiftPanelView = class("SP02_LinkGiftPanelView", SP02_LinkGiftBaseView)

function SP02_LinkGiftPanelView:onInitView()
	self.super.onInitView(self)

	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#btn_close")
end

function SP02_LinkGiftPanelView:addEvents()
	self.super.addEvents(self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function SP02_LinkGiftPanelView:removeEvents()
	self.super.removeEvents(self)
	self._btnclose:RemoveClickListener()
end

function SP02_LinkGiftPanelView:_btncloseOnClick()
	self:closeThis()
end

return SP02_LinkGiftPanelView
