-- chunkname: @modules/logic/partygame/view/carddrop/view/CardDropGameView.lua

module("modules.logic.partygame.view.carddrop.view.CardDropGameView", package.seeall)

local CardDropGameView = class("CardDropGameView", BaseView)

function CardDropGameView:onInitView()
	self.floatRoot = gohelper.findChild(self.viewGO, "floatroot")
	self.interface = PartyGameCSDefine.CardDropInterfaceCs
end

function CardDropGameView:onOpen()
	local viewSetting = self.viewContainer:getSetting()
	local res = viewSetting.otherRes.float
	local prefab = self.viewContainer:getRes(res)

	CardDropFloatController.instance:init(prefab, self.floatRoot)
end

function CardDropGameView:onDestroyView()
	CardDropFloatController.instance:clear()
end

return CardDropGameView
