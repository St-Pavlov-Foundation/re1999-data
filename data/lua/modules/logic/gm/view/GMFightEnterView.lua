-- chunkname: @modules/logic/gm/view/GMFightEnterView.lua

module("modules.logic.gm.view.GMFightEnterView", package.seeall)

local GMFightEnterView = class("GMFightEnterView", BaseView)

function GMFightEnterView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "btnClose")
end

function GMFightEnterView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
end

function GMFightEnterView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function GMFightEnterView:onOpen()
	GMFightEnterLeftModel.instance:onOpen()
end

function GMFightEnterView:onClose()
	ViewMgr.instance:openView(ViewName.GMToolView)
end

return GMFightEnterView
