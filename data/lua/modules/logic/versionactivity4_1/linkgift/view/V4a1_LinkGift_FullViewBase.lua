-- chunkname: @modules/logic/versionactivity4_1/linkgift/view/V4a1_LinkGift_FullViewBase.lua

module("modules.logic.versionactivity4_1.linkgift.view.V4a1_LinkGift_FullViewBase", package.seeall)

local V4a1_LinkGift_FullViewBase = class("V4a1_LinkGift_FullViewBase", V4a1_LinkGift_ViewImpl)

function V4a1_LinkGift_FullViewBase:ctor(...)
	V4a1_LinkGift_FullViewBase.super.ctor(self, ...)
	self:internal_set_openMode(Activity101SignViewBase.eOpenMode.ActivityBeginnerView)

	self._inited = false
end

function V4a1_LinkGift_FullViewBase:onDestroyView()
	self._inited = false

	V4a1_LinkGift_FullViewBase.super.onDestroyView(self)
end

function V4a1_LinkGift_FullViewBase:onUpdateParam()
	self:_refresh()
end

function V4a1_LinkGift_FullViewBase:onOpen()
	if not self._inited then
		self:internal_onOpen()

		self._inited = true
	else
		self:_refresh()
	end
end

function V4a1_LinkGift_FullViewBase:addEvents()
	V4a1_LinkGift_FullViewBase.super.addEvents(self)
end

function V4a1_LinkGift_FullViewBase:removeEvents()
	V4a1_LinkGift_FullViewBase.super.removeEvents(self)
end

return V4a1_LinkGift_FullViewBase
