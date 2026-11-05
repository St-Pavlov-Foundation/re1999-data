-- chunkname: @modules/logic/versionactivity4_1/linkgift/view/V4a1_LinkGift_PanelViewBase.lua

module("modules.logic.versionactivity4_1.linkgift.view.V4a1_LinkGift_PanelViewBase", package.seeall)

local V4a1_LinkGift_PanelViewBase = class("V4a1_LinkGift_PanelViewBase", V4a1_LinkGift_ViewImpl)

function V4a1_LinkGift_PanelViewBase:ctor(...)
	V4a1_LinkGift_PanelViewBase.super.ctor(self, ...)

	self._inited = false

	self:internal_set_openMode(Activity101SignViewBase.eOpenMode.PaiLian)
end

function V4a1_LinkGift_PanelViewBase:onDestroyView()
	V4a1_LinkGift_PanelViewBase.super.onDestroyView(self)

	self._inited = false
end

function V4a1_LinkGift_PanelViewBase:onUpdateParam()
	self:_refresh()
end

function V4a1_LinkGift_PanelViewBase:onOpen()
	self:internal_set_actId(self.viewParam.actId)

	if not self._inited then
		self:internal_onOpen()

		self._inited = true
	else
		self:_refresh()
	end
end

return V4a1_LinkGift_PanelViewBase
